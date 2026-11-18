#include <SD.h>
#include <SPI.h>
#include <math.h> 

const int valvePin = 8;
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
unsigned long lastTime = 0;
const int limitContractPin = 12;    // Hit when muscle contracts (closes the valve)
const int limitExtendPin = 7;       // Hit when muscle fully extends (ends the cycle)

void setup() {

   // Open serial communications and wait for port to open:
  Serial.begin(115200);
  while (!Serial) {
    ; // wait for serial port to connect.
  }
  pinMode(ivalvePin, OUTPUT);
  pinMode(evalvePin, OUTPUT);
  analogWrite(evalvePin, 0);
  pinMode(limitContractPin, INPUT_PULLUP);
  pinMode(limitExtendPin, INPUT_PULLUP);
  //Set pin modes
  pinMode(TriggerPin, OUTPUT);
  pinMode(UpdatePin, OUTPUT);
  digitalWrite(TriggerPin, LOW);
  digitalWrite(UpdatePin, LOW);

  pinMode(valvePin, OUTPUT);

  // ensure actuator fully extended at start
  digitalWrite(valvePin, LOW);

  Serial.println("Exhausting valve. Waiting to reach fully extended state...");
  
  // Wait for the extension limit switch right at startup
  unsigned long startupTimeout = millis();
  while (digitalRead(limitExtendPin) == HIGH) {
    if (millis() - startupTimeout > 5000) {
      Serial.println("Warning: Did not hit extension limit switch on startup.");
      break;
    }
  }

  delay(3000);
  Serial.println("System Ready. Send 'a' to begin 5-cycle profile.");
}
void loop() {
  // Check for trigger
  if (Serial.available()) {
    char c = Serial.read();
    if (c == 'a') {
      Serial.println("Starting 5-cycle profile...");
      
      for (int i = 0; i < 5; i++) {
        digitalWrite(TriggerPin, HIGH);
        delay(1000);
        
        // 1. Contract until pin 12 is pulled LOW
        executeContractionSequence(); 
        // 2. Exhaust and wait until pin 7 is pulled LOW to end the cycle
        waitForFullExtension(); 
        // 1. Contract until pin 12 is pulled LOW
        executeContractionSequence(); 
        // 2. Exhaust and wait until pin 7 is pulled LOW to end the cycle
        waitForFullExtension(); 
        
        digitalWrite(TriggerPin, LOW);
        delay(100);
        digitalWrite(UpdatePin, HIGH);
        delay(100); // Brief delay to ensure DAQ board registers the pulse
        digitalWrite(UpdatePin, LOW);
        delay(1000);
      }
      Serial.println("Profile complete. Resting in fully extended state.");
    }
  }
}

// =========================================================
// SEQUENTIAL TEST LOGIC
// =========================================================
void executeContractionSequence() {
  
  // Open the valve to pressurize and contract
  analogWrite(evalvePin, 255);
  analogWrite(ivalvePin, 255);
  delay(100);
  digitalWrite(valvePin, HIGH);
  delay(100);
  analogWrite(evalvePin, 0);
  analogWrite(ivalvePin, 0);


  // Wait until pin 12 is pulled LOW
  while (digitalRead(limitContractPin) == HIGH) {
  }
  analogWrite(evalvePin, 255);
  analogWrite(ivalvePin, 255);
  delay(200);
  digitalWrite(valvePin, LOW);
}

void waitForFullExtension() {
  while (digitalRead(limitExtendPin) == HIGH) {
  }
  analogWrite(evalvePin, 0);
  analogWrite(ivalvePin, 0);
}

