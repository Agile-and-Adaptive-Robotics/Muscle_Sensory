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
char fileName[13] = "IR_data2.txt";
char notes[200] = "this is a note for what ever data collection";  // add notes, make it short

void setup()
{
    // Open serial communications and wait for port to open:
    Serial.begin(115200);
    while (!Serial) {
        ; // wait for serial port to connect.
    }
    delay(500);
    // Set up the digital pins for sensors
    pinMode(SHT_LOX1, OUTPUT);
    pinMode(SHT_LOX2, OUTPUT);
    pinMode(11, OUTPUT); // Set pin D11 as output to control muscle(DA)
    // shutdown both sensors
    Serial.println("Shutdown all sensors...");
    digitalWrite(SHT_LOX1, LOW);
    digitalWrite(SHT_LOX2, LOW);

    // Init functions
    setID();
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
    
    digitalWriteFast(11, !digitalReadFast(11));

    // lox1.rangingTest(&measure1, false); // pass in 'true' to get debug data printout!
    // lox2.rangingTest(&measure2, false); // pass in 'true' to get debug data printout!  
    // String IR1_reading = String(measure1.RangeMilliMeter);
    // String IR2_reading = String(measure2.RangeMilliMeter);

    String IR1_reading = String(lox1.readRangeResult());
    String IR2_reading = String(lox2.readRangeResult());   

    //open file 
    File dataFile = SD.open(fileName, FILE_WRITE);
    if (!dataFile){
        Serial.println("Failed to open file.");
        while (1) {}
    }
    /*
    if (dataFile){
        dataFile.print(counter);
        dataFile.print(", ");
        dataFile.print(IR1_reading);
        dataFile.print(", ");
        dataFile.println(IR2_reading);
        if (counter==stopCount) //print end of data
        {
            dataFile.println("=====End_data=====");
        }
        dataFile.close();
        Serial.print(IR1_reading);
        Serial.print("\t");
        Serial.print(IR2_reading);
        Serial.print("\t");
        Serial.println(counter); // write to Serial. Comment out when run for real
    }
    */
    counter += 1;
}

/*
    Reset all sensors by setting all of their XSHUT pins low for delay(10), then set all XSHUT high to bring out of reset
    Keep sensor #1 awake by keeping XSHUT pin high
    Put all other sensors into shutdown by pulling XSHUT pins low
    Initialize sensor #1 with lox.begin(new_i2c_address) Pick any number but 0x29 and it must be under 0x7F. Going with 0x30 to 0x3F is probably OK.
    Keep sensor #1 awake, and now bring sensor #2 out of reset by setting its XSHUT pin high.
    Initialize sensor #2 with lox.begin(new_i2c_address) Pick any number but 0x29 and whatever you set the first sensor to
 */
void setID() {
    // all reset
    Serial.println("Reset all sensors.");
    digitalWrite(SHT_LOX1, LOW);    
    digitalWrite(SHT_LOX2, LOW);
    delay(10);

    // all unreset
    digitalWrite(SHT_LOX1, HIGH);
    digitalWrite(SHT_LOX2, HIGH);
    delay(10);

    // activating LOX1 and reseting LOX2
    digitalWrite(SHT_LOX1, HIGH);
    digitalWrite(SHT_LOX2, LOW);

    // initing LOX1
    Serial.println("Init sensor 1.");
    if(!lox1.begin(LOX1_ADDRESS)) {
        Serial.println(F("Failed to boot first VL53L0X"));
        while(1);
    }
    delay(10);

    // activating LOX2
    digitalWrite(SHT_LOX2, HIGH);
    delay(10);

    //initing LOX2
    Serial.println("Init sensor 2.");
    if(!lox2.begin(LOX2_ADDRESS)) {
        Serial.println(F("Failed to boot second VL53L0X"));
        while(1);
    }
    delay(100);
    lox1.startRangeContinuous();
    lox2.startRangeContinuous();	
}

// void InitSensor()
// {
//     // begin sensor initialization
//     Serial.println("Initializing VL53L0X...");
//     Wire.begin();
//     sensor.setTimeout(500);
//     if (!sensor.init())
//     {
//         Serial.println("Failed to detect and initialize sensor!");
//         while (1) {}
//     }
//     Serial.println("VL53L0X is ready!");
//     // Start continuous back-to-back mode (take readings as
//     // fast as possible).  To use continuous timed mode
//     // instead, provide a desired inter-measurement period in
//     // ms (e.g. sensor.startContinuous(100)).
//     sensor.startContinuous();
// }

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