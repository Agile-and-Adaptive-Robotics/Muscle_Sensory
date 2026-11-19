#include <SD.h>
#include <SPI.h>
#include <math.h> 

File myFile;

// change this to match your SD shield or module;
const int chipSelect = 10;

const int LpotPin = A5;
const int eSkinPin = A4; // analog pin for the liquid wire skin
const int PressurePin = A2; // pressure pin to measure internal pressure
const int TriggerPin = 2; // pin to trigger recording
const int UpdatePin = 4; // pin to trigger recording

float Rref = 100;        //Reference resistance
float pressure = 0.0 ;        // pressure sensor value
float PSIpressure = 0.0 ;        // pressure sensor value
float Lref = 0;        //Reference length
float Vout = 0;         //Vout 
float Vin = 5.00;         //Vin 
float Vref = 0;        //Reference LW Voltage
int Lpot_Out = 0; // output of linear potentiometer
float length = 0; // length of the muscle
int c1 = 101;           //initialise naming counter 1
int c2 = 1;           //initialise naming counter 2
float Rsensor = 0;      //Resistance from sensor
int sensorValue = 0;        //sensorPin default value

char filename[20];

void setup() {
   // Open serial communications and wait for port to open:
  Serial.begin(115200);
  while (!Serial) {
    ; // wait for serial port to connect.
  }

  Serial.print("Initializing SD card...");
  if (!SD.begin()) {
    Serial.println("initialization failed!");
    return;
  }else{
    Serial.println("initialization success!");
  }
//Set pin modes
  pinMode(TriggerPin, INPUT);
  pinMode(UpdatePin, INPUT);

  Lpot_Out = analogRead(LpotPin); 
  Lref = 101.6 + Lpot_Out * (101.6/1024);
  Serial.println("Potentiometer Tared!");

}

void loop() {

  if(digitalRead(TriggerPin) == HIGH){
    snprintf(filename, sizeof(filename), "s%03dp%03d.txt", c1, c2);
    file_setup(filename);
  }

  while(digitalRead(TriggerPin) == HIGH){
    read_data();
    write_data(filename, c2);
  }

  if(digitalRead(UpdatePin) == HIGH){
    c2 ++;
    // after 5 trials update the MS number
    if (c2 > 5){
      c2 = 1;
      c1 ++ ;
    }
    Serial.print(c1);
    Serial.println(c2);
    delay(1000);
  }

  if(digitalRead(TriggerPin) == LOW){
    // Serial.println("Waiting for trigger");
  }
}

void file_setup(char filename[20]){
  myFile = SD.open(filename, FILE_WRITE);
  if (myFile) {
    myFile.println("MS, MPT, t (s), Pressure (Psi), LW RAW, Displacement RAW, Length (mm)");
    myFile.close();
  } else {
    // if the file didn't open, print an error:
    Serial.println("error opening file in setup");
  }
}

void read_data(){ 
  // This  portion calculates Voltage from LW sensor
  sensorValue = analogRead(A4);
  Vout = Vref - ((Vin*sensorValue)/1023.00);

  //This portion calculates pressure from the pressure sensor
  pressure = analogRead(PressurePin) ; //Measure analog value for pressure
  pressure = pressure/1024 * 5; //Convert analog value to voltage
  pressure = ((pressure / 5) -0.04)/ 0.0012858 ; //Convert to kPa
  PSIpressure = (pressure * 0.145); //Convert to PSI

  //This portion calculates length from the linear potentiometer
  Lpot_Out = analogRead(LpotPin); //Measure analog value for length
  length =Lref + 25 - (101.6 + Lpot_Out * (101.6/1024));
}

void write_data(char filename[20], int c2) {
  myFile = SD.open(filename, FILE_WRITE);
  if (myFile) {
    myFile.print(c1);
    myFile.print(" ,  ");
    myFile.print(c2);
    myFile.print(" ,  ");
    myFile.print(millis());
    myFile.print(" ,  ");
    myFile.print(PSIpressure);
    myFile.print(" ,  ");
    myFile.print(sensorValue);
    myFile.print(" ,  ");
    myFile.print(Lpot_Out);
    myFile.print(" ,  ");
    myFile.println(length);
    myFile.close();
  } else {
      // if the file didn't open, print an error:
      Serial.println("error opening file to write data");
    }
}