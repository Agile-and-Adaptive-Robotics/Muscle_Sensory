/*
This code uses the Teensy SD card to collect data from the VL53L0X IR 
range finder chip. 
The continuous reading is based on the vl53l0x_ContinuousRanging_Example.c 
from the VL53L0X API.
Range readding is in mm
Author: Jake Chung
June 26 2021
*/

// include libraries for communicating with the VL53L0X
#include <Wire.h>
#include <VL53L0X.h>
// standard C libs
#include <string.h>
#include <stdio.h>
// include the SD library
#include <SD.h>
#include <SPI.h>
// include interrupt library
#include <avr/io.h>
#include <avr/interrupt.h>

// set up variables using the SD utility library functions:
Sd2Card card;
SdVolume volume;
SdFile root;

// set up the sensor
VL53L0X sensor;

// create interrupt function
IntervalTimer myTimer; 

const int chipSelect = BUILTIN_SDCARD;
float Ts_micro;
float samplingFreq = 50; //define sampling frequency in Hz
float collectPeriod = 10; //number of seconds to collect data
volatile float stopCount; //how mane counts to stop counting given sampling Frequency
volatile int counter = 0; //variable to count about many times interrupt was fired
/*
date and time of data collection 
Format:
date: "YYYYMMDD"
time: "HHMM" - use military time
*/
char collectDate[11] = "06/27/2021";
char collectTime[6] = "11:48"; 
char fileName[12] = "IR_data.txt";
char notes[200] = "this is a note for what ever data collection";  // add notes, make it short

void setup()
{ 
    // Open serial communications and wait for port to open:
    Serial.begin(9600);
    while (!Serial) {
        ; // wait for serial port to connect.
    }

    //Init functions
    InitSensor();
    InitSDCard();
    WriteHeader2SD();

    // init interrupt
    Serial.println("Initialize interrupt routine.");
    Ts_micro = 1/samplingFreq * 1000000.0; //sampling in microseconds
    myTimer.begin(DataLoggingLoop, Ts_micro); //control loop to run at 1kHz
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
    if (counter > stopCount) { //stop data collection
        Serial.println("Completed data collection!");
        return;
    }
    String IR_reading = String(sensor.readRangeContinuousMillimeters());
    if (sensor.timeoutOccurred()) { Serial.print(" TIMEOUT"); }
    //open file 
    File dataFile = SD.open(fileName, FILE_WRITE);
    if (!dataFile){
        Serial.println("Failed to open file.");
        while (1) {}
    }
    if (dataFile){
        dataFile.print(counter);
        dataFile.print(", ");
        dataFile.println(IR_reading);
        if (counter==stopCount) //print end of data
        {
            dataFile.println("=====End_data=====");
        }
        dataFile.close();
        Serial.print(collectDate);
        Serial.print("\t");
        Serial.print(collectTime);
        Serial.print("\t");
        Serial.println(counter); // write to Serial. Comment out when run for real
    }
    counter += 1;
}

void InitSensor()
{
    // begin sensor initialization
    Serial.println("Initializing VL53L0X...");
    Wire.begin();
    sensor.setTimeout(500);
    if (!sensor.init())
    {
        Serial.println("Failed to detect and initialize sensor!");
        while (1) {}
    }
    Serial.println("VL53L0X is ready!");
    // Start continuous back-to-back mode (take readings as
    // fast as possible).  To use continuous timed mode
    // instead, provide a desired inter-measurement period in
    // ms (e.g. sensor.startContinuous(100)).
    sensor.startContinuous();
}

void InitSDCard()
{
    Serial.println("Initializing SD card...");
    // see if the card is present and can be initialized:
    if (!SD.begin(chipSelect)) {
        Serial.println("Card failed, or not present");
        while (1) {}
    }
    Serial.println("SD card is ready!");
    Serial.println("Check if file exists.");
    if (SD.exists(fileName))
    {
        Serial.println("File exists.");
    }
    else
    {
        Serial.println("File does not exist. Create new file.");
        File dataFile = SD.open(fileName, FILE_WRITE); //create file
        if (!dataFile) 
        {
            Serial.println("Failed to create file.");
            while(1) {}
        }
        dataFile.close();
    }
}

void WriteHeader2SD()
{
    //Write header file
    File dataFile = SD.open(fileName, FILE_WRITE);
    if (!dataFile){
        Serial.println("Failed to open file to write header.");
        while (1) {}
    }
    if (dataFile){
        dataFile.println("=====Start_data=====");
        dataFile.print("Date: ");
        dataFile.print(collectDate);
        dataFile.print(", Time: ");
        dataFile.println(collectTime);
        dataFile.print("Notes: ");
        dataFile.println(notes);
        dataFile.print("Collection period (s): ");
        dataFile.print(collectPeriod);
        dataFile.print(", Sampling Frequency (Hz): ");
        dataFile.println(samplingFreq);
        dataFile.println("Counter, Distance(mm)");
        dataFile.close();
    }
}