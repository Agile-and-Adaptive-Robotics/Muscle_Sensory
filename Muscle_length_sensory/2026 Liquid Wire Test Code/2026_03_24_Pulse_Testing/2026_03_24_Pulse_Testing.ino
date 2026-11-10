#include <SPI.h>
#include <SD.h>
#include <math.h> 

File myFile;

// change this to match your SD shield or module;
const int chipSelect = 10;

// Muscle rest length (clip to clip) = 160mm
const int LpotPin     = A5;     // position sensor pin (linear pot)
const int ivalvePin    = 3;      // PWM pin for contraction (inlet)
const int evalvePin   = 5;      // PWM pin for extension (outlet)
const int eSkinPin = A4; // analog pin for the liquid wire skin

const int PWM_start   = 190;    // starting PWM for sweep
const int PWM_max     = 255;    // max PWM
const int PWM_inc     = 3;      // PWM increment
const int numPoints   = 100;    // number of percentage thresholds (1% increments)
const uint32_t fallbackTimeout = 3000;  // ms to wait per point before fallback
const int PressurePin = A2; // pressure pin to measure internal pressure
float Vout = 0;         //Vout 
float Vin = 5.00;         //Vin 
float Rref = 100;        //Reference resistance
float Lref = 0;        //Reference length
float Vref = 0;        //Reference LW Voltage
int PWMi = 0;         //Inlet Valve PWM
int PWMe = 0;         //Exit valve PWM
int c1 = 29;           //initialise naming counter 1

double Len[numPoints];     // actual position thresholds

double posMax = 0;         // sensor value at fully contracted
double posMin = 0;         // sensor value at fully extended
float pressure = 0.0 ;        // pressure sensor value
float PSIpressure = 0.0 ;        // pressure sensor value
int Lpot_Out = 0; // output of linear potentiometer
float length = 0; // length of the muscle
float Rsensor = 0;      //Resistance from sensor
int sensorValue = 0;        //sensorPin default value
char filename[20];
double tstart = 0;
double tnow = 0;
double tstart2 = 0;
double tnow2 = 0;

void setup() {
Serial.begin(115200);
    while (!Serial) {
    ; // wait for serial port to connect. Needed for Leonardo only
  } 

  Serial.print("Initializing SD card...");
  if (!SD.begin()) {
    Serial.println("initialization failed!");
    return;
  }

  //Set pin modes
    pinMode(ivalvePin, OUTPUT);
    pinMode(evalvePin, OUTPUT);

    // ensure actuator fully extended at start
    analogWrite(ivalvePin, 0);
    analogWrite(evalvePin, 255);
    delay(1000);

    // Set 0 value for Linear potentiometer
    Lpot_Out = analogRead(LpotPin); 
    Lref = 101.6 - Lpot_Out * (101.6/1024);

   // Set 0 value for Liquid Wire
    sensorValue = analogRead(A4);
    Vref = (Vin*sensorValue)/1023.00;

}

void loop() {

  if (Serial.available()) {
    char c = Serial.read();
    if (c == 'a') {
      for (int i = 1; i <= 5; i++){

        snprintf(filename, sizeof(filename),"s%03dp%03d.txt", c1, i);
        file_setup(filename);
        read_data();
        write_data(filename, i);  

        for (int j = 0; j <= 5; j++){

          tstart = millis();
          set_PWM_valves(PWMi = 255, PWMe = 0);
          wait(100, i);

          set_PWM_valves(PWMi = 0, PWMe = 255);
          while (length >= 2){
            read_data();
            write_data(filename, i);
          }

          set_PWM_valves(PWMi = 255, PWMe = 0);
          wait(100, i);
          set_PWM_valves(PWMi = 0, PWMe = 255);

          tnow = millis();
          while (tnow - tstart <= 1500){
            read_data();
            write_data(filename, i);
            tnow = millis();
          }
        }
        Serial.println("Done!");
        // ensure actuator fully extended at finish
        analogWrite(ivalvePin, 0);
        analogWrite(evalvePin, 255);
        delay(1000);
      }
    }
  }
    
  // ensure actuator fully extended at finish
  analogWrite(ivalvePin, 0);
  analogWrite(evalvePin, 255);
}

void set_PWM_valves( int PWMi, int PWMe){
  analogWrite(ivalvePin, PWMi);
  analogWrite(evalvePin, PWMe);
}

void file_setup(char filename[20]){
  myFile = SD.open(filename, FILE_WRITE);
  if (myFile) {
    myFile.println("MS, MPT, t (s), PWMi, PWMe, Pressure (Psi), LW (V), Displacement (mm)");
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
  length =Lref - (101.6 - Lpot_Out * (101.6/1024));
}

void write_data(char filename[20], int i) {
  myFile = SD.open(filename, FILE_WRITE);
  if (myFile) {
    myFile.print(c1);
    myFile.print(" ,  ");
    myFile.print(i);
    myFile.print(" ,  ");
    myFile.print(millis());
    myFile.print(" ,  ");
    myFile.print(PWMi);
    myFile.print(" ,  ");
    myFile.print(PWMe);
    myFile.print(" ,  ");
    myFile.print(PSIpressure);
    myFile.print(" ,  ");
    myFile.print(Vout);
    myFile.print(" ,  ");
    myFile.println(length);
    myFile.close();
  } else {
      // if the file didn't open, print an error:
      Serial.println("error opening file to write data");
    }
}

void wait(int wait_time, int i){
  tstart2 = millis();
  tnow2 = millis();
  while (tnow2 - tstart2 <= wait_time){
  read_data();
  write_data(filename, i);
  tnow2 = millis();
  }
}
