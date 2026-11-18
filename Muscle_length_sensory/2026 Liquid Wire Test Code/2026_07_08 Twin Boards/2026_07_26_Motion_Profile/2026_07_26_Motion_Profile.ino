#include <SD.h>
#include <SPI.h>
#include <math.h> 

const int NUM_LUT_POINTS = 200;
const float LUT_DT_MS = 6.371; // Milliseconds per index
const float CYCLE_DURATION_MS = 1274.112;
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
float integralError = 0;
float lastError = 0;
const float HYSTERESIS_MM = 0.5;

// =========================================================
// ASYMMETRIC PID GAINS 
// =========================================================
// Gains for CONTRACTING (Input Valve Open - Fights stiffness, needs higher gains)
float Kp_contract = 255.0;
float Ki_contract = 5;
float Kd_contract = 0;

// Gains for EXTENDING (Output Valve Open - Aided by stiffness, needs lower gains)
float Kp_extend = 255.0;
float Ki_extend = 5;
float Kd_extend = 0;

// Stop the integral from spooling up too high and causing overshoot
const float INTEGRAL_WINDUP_LIMIT = 100.0; 

// Deadband: If the error is within this many mm, close both valves
const float DEADBAND_MM = 0.3;
const int MIN_PWM_INPUT = 200;
const int MIN_PWM_OUTPUT = 200;


void setup() {

   // Open serial communications and wait for port to open:
  Serial.begin(115200);
  while (!Serial) {
    ; // wait for serial port to connect.
  }
  pinMode(ivalvePin, OUTPUT);
  pinMode(evalvePin, OUTPUT);
  analogWrite(ivalvePin, 245);
  //Set pin modes
  pinMode(TriggerPin, OUTPUT);
  pinMode(UpdatePin, OUTPUT);
  digitalWrite(TriggerPin, LOW);
  digitalWrite(UpdatePin, LOW);

  pinMode(valvePin, OUTPUT);

  // ensure actuator fully extended at start
  digitalWrite(valvePin, HIGH);
  delay(5000);
  Lpot_Out = analogRead(LpotPin);
  Lref = 101.6 + Lpot_Out * (101.6/1024);
  Serial.print("_________________________");
  Serial.println(Lref);
  delay(3000);

  analogWrite(valvePin, LOW);
  delay(4000);

  Serial.println("System Ready. Send 'a' to begin 5-cycle profile.");
}

void loop() {
  if (Serial.available()) {
    char c = Serial.read();
    if (c == 'a') {
      Serial.println("Starting 5-cycle profile...");
      for (int i = 0; i < 5; i++) {
        digitalWrite(TriggerPin, HIGH);
        delay(500); // Hold for 500ms between cycles
        
        // Execute the 2mm contraction and immediate release
        executeContractionSequence();
        delay(1500);
        digitalWrite(TriggerPin, LOW);
        digitalWrite(UpdatePin, HIGH);
        delay(500); // Hold for 500ms between cycles
        digitalWrite(UpdatePin, LOW);
        delay(1000);
      }
      Serial.println("Profile complete. Returning to rest position.");
    }
  }
}

// =========================================================
// SEQUENTIAL TEST LOGIC
// =========================================================
void executeContractionSequence() {
  // 1. Open the valve to pressurize and contract
  digitalWrite(valvePin, HIGH);
  
  unsigned long startTime = millis();
  unsigned long timeoutMs = 5000; // 5-second failsafe
  float currentLength = readSensorLength();

  // 2. Wait until the muscle contracts to 2.0mm or the timeout is reached
  while (currentLength > 2.0) {
    currentLength = readSensorLength();
    
    // Keep plotting data during the movement at ~100Hz
    if (millis() - lastTime >= 10) {
      lastTime = millis();
      Serial.print("CurrentLength:"); Serial.print(currentLength); Serial.print(",");
      Serial.print("lengthADC:"); Serial.println(analogRead(LpotPin));
    }

    // Failsafe timeout to prevent hanging if it can't reach 2.0mm
    if (millis() - startTime > timeoutMs) {
      Serial.println("Timeout reached before hitting 2.0mm!");
      break; 
    }
  }

  // 3. Close the valve to unpressurize and let the muscle extend
  digitalWrite(valvePin, LOW);
}

void holdRestPosition(unsigned long durationMs) {
  unsigned long holdStart = millis();
  
  // Ensure the valve stays closed during the rest period
  digitalWrite(valvePin, LOW);
  
  // Wait for the duration while keeping the Serial Plotter updated
  while (millis() - holdStart <= durationMs) {
    if (millis() - lastTime >= 10) {
      lastTime = millis();
      float currentLength = readSensorLength();
      Serial.print("CurrentLength:"); Serial.print(currentLength); Serial.print(",");
      Serial.print("lengthADC:"); Serial.println(analogRead(LpotPin));
    }
  }
}

// =========================================================
// HELPER: SENSOR READING
// =========================================================
float readSensorLength() {
  // Calculates length from the linear potentiometer
  Lpot_Out = analogRead(LpotPin); 
  length = Lref - (101.6 + Lpot_Out * (101.6/1024.0));
  return length;
}