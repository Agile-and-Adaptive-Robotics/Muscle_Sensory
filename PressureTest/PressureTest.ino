/*sketch adapted by Lindie Burgess for use by the Agile and Adaptive Robotics Lab at Portland State
University.

This sketch is used in conjunction with Matlab function called, "KneeTest.m"

This arduino sketch is adapted from the "SparkFun_HX711_KnownZeroStartup" example, which
can be found here
https://github.com/sparkfun/HX711-Load-Cell-Amplifier/tree/master/firmware

Source Code for the HX711 can be found here:
https://github.com/bogde/HX711/tree/master/src

*/

int valve_in = 3;
int valve_out = 5;
int baud = 9600;

int choose_branch; //initialize the variable "choose_branch"

void setup() {
  pinMode(valve_in, OUTPUT);
  Serial.begin(baud);  //initialize arduino serial communication
  Serial.setTimeout(200);
  digitalWrite(valve_out, LOW);
  digitalWrite(valve_in, LOW);
}

void loop() {
  char choose_branch = '0';
  int total = 0;
  if (Serial.available() > 0) {     //if information is sent over serial from matlab]
    choose_branch = Serial.read();  //read the serial data into variable "choose_branch"
    if (choose_branch == '2') {     //if choose_branch is equal to '2', iterate through the following for loop

      Serial.println("running");    // tell matlab that the arduino recieved the protocol id
      String reading = "2";
      //initiate variable to store the serial data when it is being read

      while (true) 
      {
        reading = Serial.readString();                      
        //read from serial
        //if the reading is anything but 2 then break and start collecting data (we need to ignore any value of '2' because matlab sends many instances   
        //of the protocol id, so we want to make sure that it checks for the next unique value, which would be how many data points to collect)
        if (reading.length() > 1 and reading != "2\n") {    
          break;
        }
      }
      
      total = reading.toInt();     //convert the read string to an integer
      double start = millis();     //start timer
      double timer = 0;

      
      for (int i = 0; i < 500; i++) {                 //Fill phase of test
        digitalWrite(valve_out,HIGH);
        digitalWrite(valve_in,HIGH);
        timer = millis() - start;
        Serial.println(analogRead(A0));         //reads raw pressure sensor data
        Serial.println(timer);       //record time stamp of data collection
        
      }

      for (int i = 0; i < total; i++) {             //Hold phase of test, to test for leak rate
        digitalWrite(valve_in,LOW);
        digitalWrite(valve_out,HIGH);
        timer = millis() - start;
        Serial.println(analogRead(A0));         //reads raw pressure sensor data
        Serial.println(timer);       //record time stamp of data collection
        
      }
      digitalWrite(valve_out, LOW);
      digitalWrite(valve_in, LOW);
      delay(100);
      
    } else {  //if there is no information to read over serial from matlab, wait...
      digitalWrite(valve_out, LOW);
      digitalWrite(valve_in, LOW);
      delay(100);
    
    }
  }
}
