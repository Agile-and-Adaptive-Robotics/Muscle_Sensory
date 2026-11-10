// Arduino sketch: measure actuator extension velocity with positive PWM values

const int LpotPin     = A5;     // position sensor pin (linear pot)
const int valvePin    = 3;      // PWM pin for contraction
const int ovalvePin   = 9;      // PWM pin for extension

const int PWM_start   = 105;    // starting PWM magnitude for sweep
const int PWM_max     = 255;    // max PWM magnitude
const int PWM_inc     = 3;      // PWM increment
const int numPoints   = 100;    // percentage thresholds (1% increments)
const uint32_t fallbackTimeout = 3000;  // ms to wait per point
const uint32_t contractTime    = 2000;  // ms to fully contract before each test

double Len[numPoints];     // calibrated extension thresholds

double posMax = 0;         // raw at fully contracted
double posMin = 0;         // raw at fully extended

void setup() {
  Serial.begin(9600);
  pinMode(valvePin, OUTPUT);
  pinMode(ovalvePin, OUTPUT);
  // ensure actuator starts fully contracted
  fullContract();
}

void loop() {
  if (Serial.available()) {
    char c = Serial.read();
    if (c == 'a') {
      // calibrate endpoints (contract then extend) and thresholds
      calibrateEndpoints();
      buildThresholds();

      // print CSV header: PWM and percent columns
      Serial.print("PWM");
      for (int i = 0; i < numPoints; i++) {
        Serial.print(",Pct"); Serial.print(i+1);
      }
      Serial.println();

      // sweep extension (positive PWM on extension valve)
      for (int pwm = PWM_start; pwm <= PWM_max; pwm += PWM_inc) {
        // ensure start at fully contracted
        fullContract();
        double velocities[numPoints];
        measureExtensionVelocities(pwm, velocities);
        printResults(pwm, velocities);
        delay(2000);
      }

      Serial.println("Sweep complete.");
    }
  }
}

//---------------- Helper Functions ----------------

// drive to fully contracted position
void fullContract() {
  analogWrite(ovalvePin, 0);
  analogWrite(valvePin, PWM_max);
  delay(contractTime);
  analogWrite(valvePin, 0);
}

//---------------- Calibration & Thresholds ----------------
void calibrateEndpoints() {
  // fully contract
  fullContract();
  posMax = readRaw();

  // fully extend
  analogWrite(valvePin, 0);
  analogWrite(ovalvePin, PWM_max);
  delay(contractTime);
  posMin = readRaw();

  // stop motion
  analogWrite(ovalvePin, 0);
}

void buildThresholds() {
  // thresholds from contracted (0%) to extended (100%)
  for (int i = 0; i < numPoints; i++) {
    double frac = double(i+1) / numPoints;  // 0.01..1.0
    Len[i] = posMax + (posMin - posMax) * frac;
  }
}

//---------------- Velocity Measurement ----------------
void measureExtensionVelocities(int pwmVal, double *vel) {
  // apply PWM to extension valve
  analogWrite(ovalvePin, pwmVal);

  unsigned long t_prev = millis();
  double pos_prev = readRaw();

  for (int i = 0; i < numPoints; i++) {
    bool hit = false;
    unsigned long t_start = millis();
    while (millis() - t_start < fallbackTimeout) {
      double pos = readRaw();
      if (pos >= Len[i]) {
        unsigned long t_now = millis();
        double dt = (t_now - t_prev) / 1000.0;  // seconds
        vel[i] = fabs(pos - pos_prev) / dt;
        t_prev = t_now;
        pos_prev = pos;
        hit = true;
        break;
      }
    }
    if (!hit) {
      // Timeout fallback
      vel[i] = 0.0;
      t_prev = millis();
      pos_prev = readRaw();
    }
  }

  // stop extension
  analogWrite(ovalvePin, 0);
}

//---------------- Utilities ----------------
void printResults(int pwm, double *vel) {
  Serial.print(pwm);
  for (int i = 0; i < numPoints; i++) {
    Serial.print(",");
    Serial.print(vel[i], 4);
  }
  Serial.println();
}

// raw ADC reading
int readRaw() {
  return analogRead(LpotPin);
}
