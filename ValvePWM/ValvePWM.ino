/* sketch adapted by Lindie Burgess for use by the Agile and Adaptive Robotics Lab at Portland State
  University.

  This sketch is used in conjunction with Matlab function called, "KneeTest.m"

  This arduino sketch is adapted from the "SparkFun_HX711_KnownZeroStartup" example, which
  can be found here
  https://github.com/sparkfun/HX711-Load-Cell-Amplifier/tree/master/firmware

  Source Code for the HX711 can be found here:
  https://github.com/bogde/HX711/tree/master/src


  Example using the SparkFun HX711 breakout board with a scale
  By: Nathan Seidle
  SparkFun Electronics
  Date: November 19th, 2014
  License: This code is public domain but you buy me a beer if you use this and we meet someday (Beerware license).

  Most scales require that there be no weight on the scale during power on. This sketch shows how to pre-load tare values
  so that you don't have to clear the scale between power cycles. This is good if you have something on the scale
  all the time and need to reset the Arduino and not need to tare the scale.

  This example code uses bogde's excellent library: https://github.com/bogde/HX711
  bogde's library is released under a GNU GENERAL PUBLIC LICENSE

  The HX711 does one thing well: read load cells. The breakout board is compatible with any wheat-stone bridge
  based load cell which should allow a user to measure everything from a few grams to tens of tons.
  Arduino pin 2 -> HX711 CLK
  3 -> DOUT
  5V -> VCC
  GND -> GND

  The HX711 board can be powered from 2.7V to 5V so the Arduino 5V power should be fine.

*/

#include <math.h>

int choose_branch; // initialize the variable "choose_branch"
int valve = 4;


String pw = "500";     //  use milliseconds
String period = "1000";

int timer = 0;

void setup() {
  pinMode(valve, OUTPUT);
  Serial.begin(115200);  // initialize arduino serial communication
  Serial.setTimeout(1);
}

void loop() {
  char choose_branch = '0';
  int total = 0;
  if (Serial.available() > 0) {     // if information is sent over serial from matlab]
    choose_branch = Serial.read();  // read the serial data into variable "choose_branch"
    if (choose_branch == '2') {     // If choose_branch is equal to '2', iterate through the following for loop

      Serial.println("running"); // tell matlab that the arduino recieved the protocol id
      String reading = "2";
      // initiate variable to store the serial data when it is being read


      while (true) {
        reading = Serial.readStringUntil(',');            //read from serial
        //if the reading is anything but 2 then break and start collecting data (we need to ignore 2 because matlab sends many instances
        if (reading.length() > 1 and reading != "2\n") {  //of the protocol id, so we want to make sure that it checks for the next unique value, which would be how many data points to collect)
          break;
        }
      }

      total = reading.toInt();              //convert the read string to an integer
      pw = Serial.readStringUntil(',').toInt();
      period = Serial.readStringUntil(',').toInt();
      double start = millis();              //start timer
        
      for (int i = 0; i < total; i++) {
        timer = millis() - start;
        
        if (fmod(timer,period.toInt())< pw.toInt()) {
          digitalWrite(valve,HIGH);
        } else {
          digitalWrite(valve,LOW);
        }
        Serial.println(analogRead(A1));       // reads raw force data
        Serial.println(analogRead(A0));       //reads raw pressure sensor data
        Serial.println(timer);                //record time stamp of data collection
      }
      
      digitalWrite(valve,LOW);
    
  } else {  //if there is no information to read over serial from matlab, wait...
  
  digitalWrite(valve,LOW);
  
  }
}
}
