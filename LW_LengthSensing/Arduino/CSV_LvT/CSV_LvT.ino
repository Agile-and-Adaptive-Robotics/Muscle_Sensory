// Arduino sketch: measure actuator contraction velocity with positive PWM values, thresholds in mm, velocity in mm/s using high-resolution timing

const int LpotPin            = A5;       // position sensor pin (linear pot)
const int valvePin           = 3;        // PWM pin for contraction
const int ovalvePin          = 9;        // PWM pin for extension

const int PWM_start          = 105;      // starting PWM magnitude for sweep
const int PWM_max            = 255;      // max PWM magnitude
const int PWM_inc            = 3;        // PWM increment
const int numSections        = 50;       // number of length sections (e.g., 2 mm each)
const double totalTravelMm   = 100.0;    // actuator stroke in mm
const uint32_t fallbackTimeoutUs = 1000000ULL; // 1 s timeout per section in microseconds
const uint32_t extendTimeMs     = 2000;   // ms to fully extend before each test
const double minDtSec           = 0.001;  // minimum delta time in seconds to avoid overflow

double Len[numSections];               // calibrated contraction thresholds in mm

double posExtended   = 0.0;            // mm at fully extended
double posContracted = 0.0;            // mm at fully contracted

void setup() {
  Serial.begin(9600);
  pinMode(valvePin, OUTPUT);
  pinMode(ovalvePin, OUTPUT);
  fullExtend();
}

void loop() {
  if (Serial.available() && Serial.read() == 'a') {
    calibrateEndpoints();
    buildThresholds();

    // CSV header
    Serial.print("PWM");
    for (int i = 0; i < numSections; i++) {
      Serial.print(",L"); Serial.print(Len[i], 1); Serial.print("mm");
    }
    Serial.println();

    // calibration row
    Serial.print("-1");
    for (int i = 0; i < numSections; i++) {
      Serial.print(","); Serial.print(Len[i], 1);
    }
    Serial.println();

    // sweep contraction
    for (int pwm = PWM_start; pwm <= PWM_max; pwm += PWM_inc) {
      fullExtend();
      double velocities[numSections];
      for(int i = 0; i < numSections; i++){
        velocities[i] = -1.0;
      }
      measureContractionVelocities(pwm, velocities);
      printResults(pwm, velocities);
      delay(2000);
    }
    //Serial.println("Sweep complete.");
    fullExtend();
  }
}

// drive to fully extended position before contraction run
void fullExtend() {
  analogWrite(valvePin, 0);
  analogWrite(ovalvePin, PWM_max);
  delay(extendTimeMs);
  analogWrite(ovalvePin, 0);
}

// calibrate endpoints
void calibrateEndpoints() {
  fullExtend();
  posExtended = readPositionMm();

  // fully contract
  analogWrite(ovalvePin, 0);
  analogWrite(valvePin, PWM_max);
  delay(extendTimeMs);
  posContracted = readPositionMm();
  analogWrite(valvePin, 0);
}

// build length thresholds
void buildThresholds() {
  double travel = posExtended - posContracted;
  for (int i = 0; i < numSections; i++) {
    double frac = double(i + 1) / numSections;
    Len[i] = posExtended - travel * frac;
  }
}

// measure velocities between thresholds using micros() for timing
void measureContractionVelocities(int pwmVal, double *vel) {
  analogWrite(ovalvePin, 0);
  analogWrite(valvePin, pwmVal);

  unsigned long t_prev = micros();
  double pos_prev = readPositionMm();

  for (int i = 0; i < numSections; i++) {
    bool hit = false;
    unsigned long start_us = micros();
    while (micros() - start_us < fallbackTimeoutUs) {
      double pos = readPositionMm();
      if (pos <= Len[i]) {
        unsigned long t_now = micros();
        unsigned long delta_us = t_now - t_prev;
        double dt = delta_us / 1e6;
        if (dt < minDtSec) dt = minDtSec;
        vel[i] = (pos_prev - pos) / dt;  // mm/s
        t_prev = t_now;
        pos_prev = pos;
        hit = true;
        break;
      }
    }
    if (!hit) {
      // Timeout fallback
      vel[i] = -1.0;
      t_prev = micros();
      pos_prev = readPositionMm();
      break;
    }
  }
  analogWrite(valvePin, 0);

}

// print CSV results
void printResults(int pwm, double *vel) {
  Serial.print(pwm);
  for (int i = 0; i < numSections; i++) {
    Serial.print(","); Serial.print(vel[i], 2);
  }
  Serial.println();
}

// map raw ADC to mm (1023→0 mm, 0→totalTravelMm mm)
double readPositionMm() {
  double raw = analogRead(LpotPin);
  return (1023.0 - raw) * (totalTravelMm / 1023.0);
}
