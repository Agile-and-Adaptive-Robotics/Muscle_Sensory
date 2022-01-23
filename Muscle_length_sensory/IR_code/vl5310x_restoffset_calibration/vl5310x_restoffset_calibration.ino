/*
This code uses the Teensy SD card to collect data from the VL53L0X IR 
range finder chips. It collect data from 2 chips at the same time. 
The continuous reading is based on the vl53l0x_ContinuousRanging_Example.c 
from the VL53L0X API.
The code was derived from Teensy_vl5310x_SD_datalogger.ino
Range readding is in mm
Author: Jake Chung
June 27 2021
*/

// include libraries for communicating with the VL53L0X
#include <Wire.h>
#include <VL53L0X.h> //not used
#include <Adafruit_VL53L0X.h>
// standard C libs
#include <string.h>
#include <stdio.h>
// include the SD library
#include <SD.h>
#include <SPI.h>
// include interrupt library
#include <avr/io.h>
#include <avr/interrupt.h>

// set up the sensor
Adafruit_VL53L0X lox = Adafruit_VL53L0X();
// this holds the measurement
VL53L0X_RangingMeasurementData_t measure;


// set up variables using the SD utility library functions:
Sd2Card card;
SdVolume volume;
SdFile root;

// create interrupt function
IntervalTimer myTimer; 

const int chipSelect = BUILTIN_SDCARD;
float Ts_micro;
float samplingFreq = 100; //define sampling frequency in Hz
float samplingPeriod = 1/samplingFreq;
float collectPeriod = 20; //number of seconds to collect data
volatile float randNum;
volatile float stopCount; //how mane counts to stop counting given sampling Frequency
volatile int counter = 0; //variable to count about many times interrupt was fired
volatile float counter2 = 0;
volatile float check = (collectPeriod/samplingPeriod)/6; //check to switch between different drive signals
//variables for data filtering
volatile float v11 = 0.0;
volatile float v12 = 0.0;
volatile float v13 = 0.0; 
volatile float vfin = 0.0;
//filter coefficients
volatile float fc1 = 0.013359200027857;
volatile float fc2 = -0.7008967811884;
volatile float fc3 = 1.64745998107697655399;
//initiate variable for moving average
volatile float mv1 = 0.0;
volatile float mv2 = 0.0;
volatile float mv3 = 0.0;
volatile float vfin_ma = 0.0;
//variable for calibration
volatile float vfin2_cal = 0.0;

void setup()
{
    // Open serial communications and wait for port to open:
    pinMode(12, OUTPUT);
    digitalWrite(12, LOW);
    Serial.begin(115200);
    while (!Serial) {
        ; // wait for serial port to connect.
    }
    InitSensor();
    delay(500);

    // init interrupt
    Serial.println("Initialize interrupt routine.");
    Ts_micro = 1.0/samplingFreq * 1000000.0; //sampling in microseconds
    myTimer.begin(DataLoggingLoop, Ts_micro); //control loop 
    Serial.println("Interrupt is ready!");
    stopCount = floor(collectPeriod/(1/samplingFreq));
    Serial.print("Stop count: ");
    Serial.println(stopCount);
}

void loop()
{
    //do nothing

}

void DataLoggingLoop() //Interrupt loop
{
    
    // lox1.rangingTest(&measure1, false); // pass in 'true' to get debug data printout!
    // lox2.rangingTest(&measure2, false); // pass in 'true' to get debug data printout!  
    // String IR1_reading = String(measure1.RangeMilliMeter);
    // String IR2_reading = String(measure2.RangeMilliMeter);

    // Need to apply filtering equation to IR2
    v11 = v12;
    v12 = v13;
    v13 = (fc1*lox.readRangeResult()) + (fc2*v11) + (fc3*v12);
    vfin = v11 + v12 + 2*v13;

    // calculate moving average 
    mv1 = vfin;
    mv2 = mv1;
    mv3 = mv2;
    vfin_ma = (mv1 + mv2 + mv3)/3.0;

    String IR1_reading = String(vfin_ma);

    Serial.println(IR1_reading);

    // toggle pin for frequency debugging
    digitalWriteFast(12, !digitalReadFast(12));
}

void InitSensor()
{
    // begin sensor initialization
    Serial.println("Initializing VL53L0X...");
    if (!lox.begin())
    {
        Serial.println("Failed to detect and initialize sensor!");
        while (1);
    }
    lox.startRangeContinuous();
}
