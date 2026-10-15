 // Arduino sketch: measure actuator velocity across percentages of travel

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

const int PWM_start   = 105;    // starting PWM for sweep
const int PWM_max     = 255;    // max PWM
const int PWM_inc     = 3;      // PWM increment
const int numPoints   = 100;    // number of percentage thresholds (1% increments)
const uint32_t fallbackTimeout = 3000;  // ms to wait per point before fallback
const int PressurePin = A2; // pressure pin to measure internal pressure
float Vout = 0;         //Vout 
float Vin = 5;         //Vin 
float Rref = 100;        //Reference resistance
float Lref = 0;        //Reference length
int PWMi = 0;         //Inlet Valve PWM
int PWMe = 0;         //Exit valve PWM
int c1 = 1;
int c2 = 3;

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

void setup() {
    Serial.begin(9600);

    while (!Serial) {
    ; // wait for serial port to connect. Needed for Leonardo only
  }
  // char filename[20];
  // snprintf(filename, sizeof(filename),"s%03dp%03d.txt", c1, c2);
  // Serial.print("Initializing SD card...");

  // if (!SD.begin()) {
  //   Serial.println("initialization failed!");
  //   return;
  // }
  // Serial.println("initialization done.");

  // myFile = SD.open(filename, FILE_WRITE);
  //  if (myFile) {
  // myFile.println("MS, MPT, t (s), PWMi, PWMe, Pressure (Psi), LW (V), Displacement (mm)");
  // myFile.close();
  // } else {
  //   // if the file didn't open, print an error:
  //   Serial.println("error opening file a");
  // }

    pinMode(ivalvePin, OUTPUT);
    pinMode(evalvePin, OUTPUT);

    // ensure actuator fully extended at start
    analogWrite(ivalvePin, 0);
    analogWrite(evalvePin, 255);
    delay(1000);
    Lpot_Out = analogRead(LpotPin); 
    Lref = 101.6 - Lpot_Out * (101.6/1024);

}

void loop() {
  if (Serial.available()) {
    char c = Serial.read();
    if (c == 'a') {
      PWMi = 255;
      PWMe = 0;
    analogWrite(ivalvePin, PWMi);
    analogWrite(evalvePin, PWMe);
      }

    if (c == 'b') {
      PWMi = 0;
      PWMe = 255;
    analogWrite(ivalvePin, PWMi);
    analogWrite(evalvePin, PWMe);
      }
  }
// This  portion calculates Resistance from LW sensor
sensorValue = analogRead(A4);
Vout = (Vin*sensorValue)/1023;
Rsensor = Rref*(1/((Vin/Vout)-1));  

pressure = analogRead(PressurePin) ; //Measure analog value
Lpot_Out = analogRead(LpotPin); 
pressure = pressure/1024 * 5; //Convert analog value to voltage
pressure = ((pressure / 5) -0.04)/ 0.0012858 ; //Convert to kPa
PSIpressure = (pressure * 0.145);
length =Lref - (101.6 - Lpot_Out * (101.6/1024));

// char buffer[4];          // 3 digits + null terminator
// sprintf(buffer, "%03d", c1);
// snprintf(filename, sizeof(filename),"s%03dp%03d.txt", c1, c2);
// Serial.println(filename);
// myFile = SD.open(filename, FILE_WRITE);
// if (myFile) {
// myFile.print(buffer);
// myFile.print(" ,  ");
// myFile.print("001");
// myFile.print(" ,  ");
// myFile.print(millis());
// myFile.print(" ,  ");
// myFile.print(PWMi);
// myFile.print(" ,  ");
// myFile.print(PWMe);
// myFile.print(" ,  ");
// myFile.print(PSIpressure);
// myFile.print(" ,  ");
// myFile.print(Vout);
// myFile.print(" ,  ");
// // myFile.print(Lpot_Out);
// // myFile.print(" ,  ");
// myFile.println(length);
Serial.print(pressure);
Serial.print(" Kpa  ");
Serial.print(PSIpressure); // in psi
Serial.print(" Psi  Vout: ");
Serial.print(Vout); // in ohm
Serial.println(""); // in psi
delay(1000);
// myFile.close();
// } else {
//     // if the file didn't open, print an error:
//     Serial.println("error opening file b");
//   }
}


// This is a test edit

