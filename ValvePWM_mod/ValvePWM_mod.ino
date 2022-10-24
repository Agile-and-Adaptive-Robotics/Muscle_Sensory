/* sketch adapted by Lindie Burgess for use by the Agile and Adaptive Robotics Lab at Portland State
  University.

  This sketch is used in conjunction with Matlab function called, "ValvePWM"

  This arduino sketch is adapted from the "SparkFun_HX711_KnownZeroStartup" example, which
  can be found here
  https://github.com/sparkfun/HX711-Load-Cell-Amplifier/tree/master/firmware

  Source Code for the HX711 can be found here:
  https://github.com/bogde/HX711/tree/master/src


  Example using the SparkFun HX711 breakout board with a scale
  By: Nathan Seidle
  SparkFun Electronics
  Date: November 19th, 2014
  License: This code is public domain but you buy me a beer if you use this and we meet someday (Beerware license).*/


  #include <math.h>
      int choose_branch;    //initialize the variable "choose_branch"
      
      //Initiating Input and Output pins on Arduino
      int air_in = 13;  
      int air_out = 12;
      int pressure_pin = A0;
      int force_pin = A1;
      
      //Setting the timing of the valves pwm 
      String pw_in = "500";            //use milliseconds
      String pw_out = "0";
      String period_in = "1000";
      String period_out = "1";
      //initiate timer at 0
      int timer = 0;
      
  void setup() {
    pinMode(air_in, OUTPUT);
    pinMode(air_out, OUTPUT);
    Serial.begin(115200);           //initialize arduino serial communication
    Serial.setTimeout(1000);         //this sets the maximum milliseconds to wait for serial data. (Nov 5th, changed from 100 ->1000) 
    digitalWrite(air_in,LOW);
    digitalWrite(air_out,LOW);
  }

  void loop() {
    char choose_branch = '0'; 
    int total = 0;
        digitalWrite(air_in,LOW);
        digitalWrite(air_out,LOW);

    if (Serial.available() > 0)              //If there's info sent over serial from MATLAB, read the serial data into "choose branch" variable.    ('2' = PWM data collection) 
    {     
      choose_branch = Serial.read();        
      if (choose_branch == '2')              //If "choose branch" = 2, then proceed to the following while loop
      {           
        Serial.println("running");          //Tell matlab that the arduino recieved the protocol id = running. 
        String reading = "2";               //initiate variable to store the serial data as string when it is being read
        
            while (true) 
            {
               reading = Serial.readStringUntil(',');       //read from serial until next ',' sign
                  if (reading.length() > 1 and reading != "2\n") 
                  {   //if the reading is anything but 2, break and start collecting data (we need to ignore 2 because matlab sends many instances of the protocol id, so we want to make sure that it checks for the next unique value, which would be how many data points to collect)
                    break;        
                  }
            }
                //MATLAB variables
                total = reading.toInt();                                  
                pw_in = Serial.readStringUntil(',').toInt();              
                period_in = Serial.readStringUntil(',').toInt();
                pw_out = Serial.readStringUntil(',').toInt();
                period_out = Serial.readStringUntil(',').toInt();
        
                double start = millis();          //start timer
                double timer = 0;
                
            //Data collection for pressurizing the BPA 
            for (int i = 0; i < total/2; i++)         //data collection begins with total/2  number of data points. 
            {
              timer = millis() - start;
                  if (fmod(timer,period_in.toInt())<= pw_in.toInt())      //fmod = floating point modulus. If the remainder of timer/period is smaller than the valve open time, then proceed to turn on valve. 
                  {       
                    digitalWrite(air_in,HIGH);
                    digitalWrite(air_out,HIGH);
                  } else 
                  {
                    digitalWrite(air_in,LOW);                             //If remainder of timer/period is greater than valve open time, shut valve off. 
                  }
                  Serial.println(analogRead(force_pin));       //reads raw force data
                  Serial.println(analogRead(pressure_pin));       //reads raw pressure sensor data
                  Serial.println(timer);                //record time stamp of data collection
                  Serial.println(1);
                 
            }
                  // digitalWrite(air_in,LOW)
             //Data collection for depressurizing BPA       
             for (int i = 0; i < total/2; i++) 
             {
                timer = millis() - start; 
                  if (fmod(timer,period_out.toInt())<= pw_out.toInt()) 
                  {
                  digitalWrite(air_in,LOW);
                  digitalWrite(air_out,HIGH);
                  } else 
                  {
                  digitalWrite(air_out,LOW);
                  }
                Serial.println(analogRead(force_pin));       //reads raw force data
                Serial.println(analogRead(pressure_pin));       //reads raw pressure sensor data
                Serial.println(timer);                //record time stamp of data collection
                Serial.println(2);
              }
              //digitalWrite(air_out,LOW);
      } else {  //if there is no information to read over serial from matlab, wait and release valve  
        digitalWrite(air_in,LOW);
        digitalWrite(air_out,LOW);
      }
      
    }
  }
