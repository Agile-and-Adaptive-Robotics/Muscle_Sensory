#include <SD.h>
#include <SPI.h>
#include <math.h> 

const int NUM_LUT_POINTS = 200;
const float LUT_DT_MS = 6.371; // Milliseconds per index
const float CYCLE_DURATION_MS = 1274.112;


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
  Serial.print("_________________________");
  Serial.println(Lref);
  delay(5000);

  analogWrite(ivalvePin, 0);
  analogWrite(evalvePin, 255);
  delay(4000);

  Serial.println("System Ready. Send 'a' to begin 5-cycle profile.");
}

// =========================================================
// VALVE CONTROL LOGIC
// =========================================================
void driveValves(float output, float currentError) {
  if (abs(currentError) < DEADBAND_MM) {
    analogWrite(ivalvePin, 0);
    analogWrite(evalvePin, 0);
    return;
  }

  int rawPWM = constrain(abs(output), 0, 255);

  if (output > 0) {
    // Need to CONTRACT: Route to Input Valve with Deadzone mapping
    int inputPWM = map(rawPWM, 0, 255, MIN_PWM_INPUT, 255);
    analogWrite(ivalvePin, inputPWM);
    analogWrite(evalvePin, 0);
  } 
  else {
    // Need to EXTEND: Route to Output Valve with Deadzone mapping
    int outputPWM = map(rawPWM, 0, 255, MIN_PWM_OUTPUT, 255);
    analogWrite(ivalvePin, 0);
    analogWrite(evalvePin, outputPWM);
  }
}

void holdPosition(unsigned long durationMs) {
  unsigned long holdStart = millis();
  float restTarget = 7.2; // Hardcode the rest position
  
  while (millis() - holdStart <= durationMs) {
    updatePID(restTarget);
  }
}

// =========================================================
// HELPER: SENSOR READING
// =========================================================
float readSensorLength() {
  //This portion calculates length from the linear potentiometer
  Lpot_Out = analogRead(LpotPin); //Measure analog value for length
  length =Lref - (101.6 + Lpot_Out * (101.6/1024));
  // Serial.println(length);
  return(length);
}

void updatePID(float targetLength) {
  unsigned long currentMillis = millis();
  
  // Run control loop at roughly 100Hz (every 10ms)
  if (currentMillis - lastTime >= 10) {
    float dt = (currentMillis - lastTime) / 1000.0; 
    lastTime = currentMillis;

    float currentLength = readSensorLength(); 
    
    // Reverse-acting setup
    float error = currentLength - targetLength; 
    
    float current_Kp, current_Ki, current_Kd;
    
    if (error > 0) {
      // Need to CONTRACT
      current_Kp = Kp_contract;
      current_Ki = Ki_contract;
      current_Kd = Kd_contract;
    } else {
      // Need to EXTEND
      current_Kp = Kp_extend;
      current_Ki = Ki_extend;
      current_Kd = Kd_extend;
    }

    float pTerm = current_Kp * error;
    
    integralError += error * dt;
    integralError = constrain(integralError, -INTEGRAL_WINDUP_LIMIT, INTEGRAL_WINDUP_LIMIT);
    float iTerm = current_Ki * integralError;
    
    float dTerm = current_Kd * ((error - lastError) / dt);
    lastError = error;
    
    float pidOutput = pTerm + iTerm + dTerm;
    
    driveValves(pidOutput, error);
    
    // Serial output for plotting
    Serial.print("Target:"); Serial.print(targetLength); Serial.print(",");
    Serial.print("Current:"); Serial.print(currentLength); Serial.print(",");
    // Serial.print("PWM:"); Serial.println(constrain(pidOutput, -255, 255));
    Serial.print("length"); Serial.println(analogRead(LpotPin));
    
  }
}

void runSingleCycle() {
  // Start directly at State 1
  int state = 1; 
  float currentTarget = 2.0;
  unsigned long stateStartTime = millis();
  
  // Tolerance in mm to consider a target "reached" 
  float tolerance = 0.5; 
  
  // Timeout in milliseconds (failsafe)
  unsigned long timeoutMs = 3000; 

  Serial.println("Cycle Triggered: Snapping to 2.0mm");

  // Run until all 3 movement states are complete
  while (state <= 3) {
    float currentLength = readSensorLength();
    unsigned long timeInState = millis() - stateStartTime;

    // STATE 1: Move to 2.0mm as fast as possible
    if (state == 1) {
      currentTarget = 2.0;
      // If we crossed the target threshold OR timed out
      if (currentLength <= (currentTarget + tolerance) || timeInState > timeoutMs) {
        state = 2;
        stateStartTime = millis();
        Serial.println("State 2: Snapping to 21.0mm");
      }
    }
    // STATE 2: Move to 21.0mm as fast as possible
    else if (state == 2) {
      currentTarget = 21.0;
      if (currentLength >= (currentTarget - tolerance) || timeInState > timeoutMs) {
        state = 3;
        stateStartTime = millis();
        Serial.println("State 3: Returning to 7.2mm");
      }
    }
    // STATE 3: Return to 7.2mm as fast as possible
    else if (state == 3) {
      currentTarget = 7.2;
      if (currentLength <= (currentTarget + tolerance) || timeInState > timeoutMs) {
        state = 4; // Exit the while loop and finish the cycle
      }
    }
    updatePID(currentTarget);
  }
}

void loop() {

  if (Serial.available()) {
    char c = Serial.read();
    if (c == 'a') {
      Serial.println("Starting 5-cycle profile...");
      for (int i = 0; i < 5; i++) {
        digitalWrite(TriggerPin, HIGH);
        holdPosition(500); // Hold for 500ms between cycles
        runSingleCycle();
        digitalWrite(TriggerPin, LOW);
        digitalWrite(UpdatePin, HIGH);
        holdPosition(500); // Hold for 500ms between cycles
        digitalWrite(UpdatePin, LOW);

      }
      Serial.println("Profile complete. Returning to rest position.");
    }
  }
  updatePID(7.2);
}



