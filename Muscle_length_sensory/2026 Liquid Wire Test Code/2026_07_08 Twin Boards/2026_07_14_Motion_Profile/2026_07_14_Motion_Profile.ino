#include <SD.h>
#include <SPI.h>
#include <math.h> 

const int NUM_LUT_POINTS = 200;
const float LUT_DT_MS = 6.371; // Milliseconds per index
const float CYCLE_DURATION_MS = 1274.112;

// Store in Flash memory to save SRAM
const float PROGMEM length_profile[] = {
    7.2165, 6.8911, 6.5892, 6.2725, 5.8589, 5.4966, 5.2113, 4.9066, 4.6565, 4.4555,
    4.1594, 3.8174, 3.5937, 3.4255, 3.2717, 3.1247, 2.9726, 2.8024, 2.6241, 2.4549,
    2.2891, 2.1215, 1.9550, 1.8016, 1.6674, 1.5422, 1.4206, 1.3079, 1.2023, 1.0891,
    0.9673, 0.8587, 0.7656, 0.6791, 0.5954, 0.5145, 0.4480, 0.4085, 0.3648, 0.2752,
    0.1969, 0.1508, 0.0953, 0.0479, 0.0225, 0.0039, 0.0110, 0.1100, 0.2626, 0.3652,
    0.4900, 0.7000, 0.9797, 1.3036, 1.6756, 2.2107, 2.9580, 3.7498, 4.3644, 5.1464,
    6.0790, 7.0554, 8.5252, 10.0263, 11.5072, 12.9872, 14.0052, 14.6528, 15.7657, 17.4655,
    18.7229, 19.5209, 20.1288, 20.6577, 21.0974, 21.4126, 21.5965, 21.6759, 21.6910, 21.6307,
    21.4610, 21.2161, 20.9516, 20.6747, 20.3753, 20.0199, 19.6147, 19.2757, 18.9988, 18.6649,
    18.3006, 18.0058, 17.6355, 17.2119, 16.9518, 16.7434, 16.4868, 16.2343, 16.0177, 15.7711,
    15.4289, 15.0314, 14.6514, 14.3247, 14.0410, 13.7596, 13.4451, 13.0706, 12.6584, 12.2603,
    11.9041, 11.5900, 11.2913, 10.9801, 10.6292, 10.2229, 9.7815, 9.4605, 9.2368, 8.6662,
    7.9443, 7.6494, 7.5697, 7.5807, 7.5794, 7.5783, 7.5772, 7.5758, 7.5741, 7.5721,
    7.5698, 7.5672, 7.5644, 7.5613, 7.5579, 7.5543, 7.5504, 7.5463, 7.5420, 7.5374,
    7.5326, 7.5276, 7.5224, 7.5170, 7.5113, 7.5056, 7.4996, 7.4935, 7.4872, 7.4808,
    7.4742, 7.4675, 7.4608, 7.4539, 7.4469, 7.4398, 7.4327, 7.4256, 7.4183, 7.4111,
    7.4038, 7.3965, 7.3893, 7.3820, 7.3748, 7.3676, 7.3604, 7.3533, 7.3463, 7.3394,
    7.3326, 7.3258, 7.3192, 7.3127, 7.3064, 7.3002, 7.2941, 7.2882, 7.2825, 7.2770,
    7.2717, 7.2666, 7.2617, 7.2570, 7.2525, 7.2483, 7.2443, 7.2405, 7.2371, 7.2338,
    7.2308, 7.2281, 7.2257, 7.2236, 7.2217, 7.2201, 7.2188, 7.2175, 7.2195, 7.2075
};

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
  
  // Actively hold the rest position while waiting for a command
  updatePID(getSetpoint(0));
}

void runSingleCycle() {
  unsigned long cycleStart = millis();
  
  // Run until the elapsed time exceeds the cycle duration
  while (millis() - cycleStart <= CYCLE_DURATION_MS) {
    unsigned long elapsedProfileTime = millis() - cycleStart;
    float currentTarget = getSetpoint(elapsedProfileTime);
    
    updatePID(currentTarget);
  }
}

void holdPosition(unsigned long durationMs) {
  unsigned long holdStart = millis();
  float restTarget = getSetpoint(0); // The position to hold
  
  // Continuously run the PID for the duration of the pause
  while (millis() - holdStart <= durationMs) {
    updatePID(restTarget);
  }
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

// =========================================================
// HELPER: LOOKUP TABLE READER
// =========================================================
float getSetpoint(unsigned long t_ms) {
  // Constrain time to avoid fmod errors when calculating the LUT
  float t_cycle = fmod((float)t_ms, CYCLE_DURATION_MS);
  
  float floatIndex = t_cycle / LUT_DT_MS;
  int index0 = (int)floatIndex;
  int index1 = (index0 + 1) % NUM_LUT_POINTS;
  
  float remainder = floatIndex - (float)index0;
  
  float val0 = pgm_read_float(&length_profile[index0]);
  float val1 = pgm_read_float(&length_profile[index1]);
  
  return val0 + remainder * (val1 - val0);
}
