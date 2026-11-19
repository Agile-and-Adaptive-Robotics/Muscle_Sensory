#include <SD.h>
#include <SPI.h>
#include <math.h> 

const int LpotPin = A1;
const int ivalvePin    = 3;      // PWM pin for contraction (inlet)
const int evalvePin   = 5;      // PWM pin for extension (outlet)
const int TriggerPin = 2; // pin to trigger recording
const int UpdatePin = 4; // pin to trigger recording
float Lref = 0;        //Reference length
int Lpot_Out = 0; // output of linear potentiometer
float length = 0; // length of the muscle
int PWMi = 0;         //Inlet Valve PWM
int PWMe = 0;         //Exit valve PWM


void setup() {

   // Open serial communications and wait for port to open:
  Serial.begin(115200);
  while (!Serial) {
    ; // wait for serial port to connect.
  }
  pinMode(ivalvePin, OUTPUT);
  pinMode(evalvePin, OUTPUT);
  //Set pin modes
  pinMode(TriggerPin, OUTPUT);
  pinMode(UpdatePin, OUTPUT);
  digitalWrite(TriggerPin, LOW);
  digitalWrite(UpdatePin, LOW);

  // ensure actuator fully extended at start
  analogWrite(ivalvePin, 255);
  analogWrite(evalvePin, 0);
  delay(5000);
  Lpot_Out = analogRead(LpotPin);
  Lref = 101.6 + Lpot_Out * (101.6/1024);

  analogWrite(ivalvePin, 0);
  analogWrite(evalvePin, 255);
  delay(4000);
}

void loop() {
if (Serial.available()) {
    char c = Serial.read();
    if (c == 'a') {
      digitalWrite(TriggerPin, HIGH);
    }

    if (c == 'b') {
      digitalWrite(TriggerPin, LOW);
      digitalWrite(UpdatePin, HIGH);
      delay(500);
      digitalWrite(UpdatePin, LOW);
    }

    if (c == 'c') {
      PWMi = 255;
      PWMe = 0;
      analogWrite(ivalvePin, PWMi);
      analogWrite(evalvePin, PWMe);
    }

    if (c == 'd') {
      PWMi = 0;
      PWMe = 255;
      analogWrite(ivalvePin, PWMi);
      analogWrite(evalvePin, PWMe);
    }
  }
  Lpot_Out = analogRead(LpotPin); 
  length =Lref - (101.6 + Lpot_Out * (101.6/1024));

  // Print the value to the Serial Monitor
  Serial.print(length);
  Serial.println(" mm  ");
  
  // Wait 100 milliseconds before the next read to make the monitor easier to read
  delay(100);

}
