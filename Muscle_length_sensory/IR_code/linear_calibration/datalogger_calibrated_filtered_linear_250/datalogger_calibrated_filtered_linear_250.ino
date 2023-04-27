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

// address we will assign if dual sensor is present
#define ISS_ADDRESS 0x30
#define ESS_ADDRESS 0x31
// set the pins to shutdown
#define SHT_ISS 24
#define SHT_ESS 25
// set up the sensor
Adafruit_VL53L0X iss = Adafruit_VL53L0X();
Adafruit_VL53L0X ess = Adafruit_VL53L0X();
// this holds the measurement
VL53L0X_RangingMeasurementData_t measure_iss;
VL53L0X_RangingMeasurementData_t measure_ess;


// set up variables using the SD utility library functions:
Sd2Card card;
SdVolume volume;
SdFile root;


// create interrupt function
IntervalTimer myTimer; 


const int chipSelect = BUILTIN_SDCARD;
float Ts_micro;
// running 2 sensors on I2C bus, do not recommend running more than 50Hz sampling frequency. 
// Check pin 12 to verify interrupt frequency
float samplingFreq = 50; //define sampling frequency in Hz
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
volatile float vfin1 = 0.0;
volatile float v21 = 0.0;
volatile float v22 = 0.0;
volatile float v23 = 0.0;
volatile float vfin2 = 0.0; 
//rest offset value 
//define the rest offset linear equation for each sensor. 
//Use the restoffset_calibration code to find the restoffset for each sensor. 
volatile float rest_m_iss = 1.0;
volatile float rest_b_iss = 0.0;
volatile float rest_m_ess = 1.0;
volatile float rest_b_ess = 0.0;
//filter coefficients
volatile float fc1 = 0.013359200027857;
volatile float fc2 = -0.7008967811884;
volatile float fc3 = 1.64745998107697655399;
//variables for calibration
volatile float vfin2_m = 0.63354956584373;
volatile float vfin2_b = 137.8876193269644;
volatile float vfin2_cal = 0.0;
/*
date and time of data collection 
Format:
date: "YYYYMMDD"
time: "HHMM" - use military time5
*/
char collectDate[11] = "23/01/2022";
char collectTime[6] = "00:00"; 
char fileName[14] = "IR_test88.txt";
char notes[200] = "filter and calibrated data";  // add notes, make it short

void setup()
{
    // Open serial communications and wait for port to open:
    Serial.begin(115200);
    while (!Serial) {
        ; // wait for serial port to connect.
    }
    delay(500);
    // Set up the digital pins for sensors
    pinMode(SHT_ISS, OUTPUT);
    pinMode(SHT_ESS, OUTPUT);
    pinMode(11, OUTPUT); // Set pin D11 as output to control muscle
    pinMode(12, OUTPUT); // Timer pin to check sampling frequency
    digitalWrite(12, LOW); 
    // shutdown both sensors
    Serial.println("Shutdown all sensors...");
    digitalWrite(SHT_ISS, LOW);
    digitalWrite(SHT_ESS, LOW);

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
        digitalWriteFast(11, LOW);
        return;
    }

    if ((counter < 5*check) & (counter > 4*check))
    {
        // do nothing, static low
        digitalWriteFast(11, LOW);
    } 
    else if ((counter < 4*check) & (counter > 3*check))
    {
        // toggle high
        digitalWriteFast(11, HIGH);
    }
    else if ((counter < 3*check) & (counter > 2*check))
    {
        // toggle at 1.0Hz
        counter2 = counter2 + samplingPeriod;
        if (counter2 > 1.0)
        {
            digitalWriteFast(11, !digitalReadFast(11));
            Serial.println(counter2);
            counter2 = 0;
        }
    }
    else if ((counter < 2*check) & (counter > 1*check))
    {
        //toggle at 2Hz
        counter2 = counter2 + samplingPeriod;
        if (counter2 > 0.5)
        {
            digitalWriteFast(11, !digitalReadFast(11));
            Serial.println(counter2);
            counter2 = 0;
        }
    }
    else if ((counter < 1*check))
    {
        //toggle at 3Hz
        counter2 = counter2 + samplingPeriod;
        if (counter2 > 0.333)
        {
            digitalWriteFast(11, !digitalReadFast(11));
            Serial.println(counter2);
            counter2 = 0;
        }
    }
    else
    {
        //toggle at 0.5Hz
        counter2 = counter2 + samplingPeriod;
        if (counter2 > 0.2)
        {
            digitalWriteFast(11, !digitalReadFast(11));
            Serial.println(counter2);
            counter2 = 0;
        }
    }
    
    iss.rangingTest(&measure_iss, false); // pass in 'true' to get debug data printout!
    ess.rangingTest(&measure_ess, false); // pass in 'true' to get debug data printout!  
    // String IR1_reading = String(measure1.RangeMilliMeter);
    // String IR2_reading = String(measure2.RangeMilliMeter);

    // Need to filter both ISS and ESS
    v11 = v12;
    v12 = v13;
    v13 = (fc1*measure_iss.RangeMilliMeter) + (fc2*v11) + (fc3*v12);
    vfin1 = v11 + v12 + 2*v13;

    v21 = v22;
    v22 = v23;
    v23 = (fc1*measure_ess.RangeMilliMeter) + (fc2*v21) + (fc3*v22);
    vfin2 = v21 + v22 + 2*v23;

    // Apply calibration to correct for sensor offset
    vfin1 = rest_m_iss*vfin1 + rest_b_iss;
    vfin2 = rest_m_ess*vfin2 + rest_b_ess;

    // Apply calibration to shift the internal sensor to match the external sensor
    vfin2_cal = vfin2_m*vfin2 + vfin2_b;

    String ISS_reading = String(vfin1);
    String ESS_reading = String(vfin2_cal);   

    //open file 
    File dataFile = SD.open(fileName, FILE_WRITE);
    if (!dataFile){
        Serial.println("Failed to open file.");
        while (1) {}
    }
    
    if (dataFile){
        
        dataFile.print(counter);
        dataFile.print(", ");
        dataFile.print(ISS_reading);
        dataFile.print(", ");
        dataFile.println(ESS_reading);
        if (counter==stopCount) //print end of data
        {
            dataFile.println("=====End_data=====");
        }
        dataFile.close();
        // Serial.print(IR1_reading);
        // Serial.print("\t");
        // Serial.print(IR2_reading);
        // Serial.print("\t");
        // Serial.println(counter); // write to Serial. Comment out when run for real
    }
    
    counter += 1;
    digitalWriteFast(12, !digitalReadFast(12));
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
    digitalWrite(SHT_ISS, LOW);    
    digitalWrite(SHT_ESS, LOW);
    delay(10);

    // all unreset
    digitalWrite(SHT_ISS, HIGH);
    digitalWrite(SHT_ESS, HIGH);
    delay(10);

    // activating Internal and reseting External
    digitalWrite(SHT_ISS, HIGH);
    digitalWrite(SHT_ESS, LOW);

    // initing Internal SS
    Serial.println("Init sensor 1.");
    if(!iss.begin(ISS_ADDRESS)) {
        Serial.println(F("Failed to boot Internal VL53L0X"));
        while(1);
    }
    delay(10);

    // activating External SS
    digitalWrite(SHT_ESS, HIGH);
    delay(10);

    //initing External SS
    Serial.println("Init sensor 2.");
    if(!ess.begin(ESS_ADDRESS)) {
        Serial.println(F("Failed to boot External VL53L0X"));
        while(1);
    }
    delay(100);
    iss.startRangeContinuous();
    ess.startRangeContinuous();	
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
