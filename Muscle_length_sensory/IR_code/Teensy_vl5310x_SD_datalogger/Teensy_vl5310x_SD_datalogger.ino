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
// include the SD library:
#include <SD.h>
#include <SPI.h>

// set up variables using the SD utility library functions:
Sd2Card card;
SdVolume volume;
SdFile root;

// set up the sensor
VL53L0X sensor;

const int chipSelect = BUILTIN_SDCARD;
// String IR_reading;
// File dataFile

void setup()
{ 
    // Open serial communications and wait for port to open:
    Serial.begin(9600);
    while (!Serial) {
        ; // wait for serial port to connect.
    }

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

    Serial.println("Initializing SD card...");
    // see if the card is present and can be initialized:
    if (!SD.begin(chipSelect)) {
        Serial.println("Card failed, or not present");
        while (1) {}
    }
    Serial.println("SD card is ready!");
}

void loop()
{
    String IR_reading = String(sensor.readRangeContinuousMillimeters());
    if (sensor.timeoutOccurred()) { Serial.print(" TIMEOUT"); }
    //open file 
    File dataFile = SD.open("datalog.txt", FILE_WRITE);
    if (!dataFile){
        Serial.println("Failed to open file.");
        while (1) {}
    }
    if (dataFile){
        dataFile.println(IR_reading);
        dataFile.close();
        // write to Serial. Comment out when run for real
        Serial.println(IR_reading); 

    }
}
