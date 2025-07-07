// Arduino sketch: measure actuator extension velocity with positive PWM values, thresholds in mm, velocity in mm/s

const int LpotPin        = A5;       // position sensor pin (linear pot)
const int valvePin       = 3;        // PWM pin for contraction
const int ovalvePin      = 9;        // PWM pin for extension

const int PWM_start      = 105;      // starting PWM magnitude for sweep
const int PWM_max        = 255;      // max PWM magnitude
const int PWM_inc        = 3;        // PWM increment
const int numSections    = 50;      // number of length sections (e.g., 1 mm each)
const double totalTravelMm = 100.0;  // actuator stroke in mm
const uint32_t fallbackTimeout =990;   // ms to wait per section
const uint32_t contractTime    = 2000;
const uint32_t extendTimeMs     = 2000;   // ms to fully contract before each test

double Len[numSections];              // calibrated extension thresholds in mm

double posContracted = 0.0;           // mm at fully contracted
double posExtended   = 0.0;           // mm at fully extended

void setup() {
  Serial.begin(9600);
  pinMode(valvePin, OUTPUT);
  pinMode(ovalvePin, OUTPUT);
  fullExtend();
}

void loop() {
  if (Serial.available()) {
    if (Serial.read() == 'a') {
      // calibrate endpoints (contract then extend) and build thresholds
      calibrateEndpoints();
      buildThresholds();

      // print CSV header: PWM and section lengths
      Serial.print("PWM");
      for (int i = 0; i < numSections; i++) {
        Serial.print(",L"); Serial.print(Len[i], 1); Serial.print("mm");
      }
      Serial.println();

      // print calibration row (-1) of raw thresholds
      Serial.print("-1");
      for (int i = 0; i < numSections; i++) {
        Serial.print(","); Serial.print(Len[i], 1);
      }
      Serial.println();

      // sweep extension (positive PWM)
      for (int pwm = PWM_start; pwm <= PWM_max; pwm += PWM_inc) {
        // ensure starting fully contracted
        fullContract();
        double velocities[numSections];
        for(int i = 0; i < numSections; i++){
        velocities[i] = -1.0;
        }
        measureExtensionVelocities(pwm, velocities);
        printResults(pwm, velocities);
        delay(2000);
      }

      //Serial.println("Sweep complete.");
    }
  }
}

// drive to fully contracted position
void fullContract() {
  analogWrite(ovalvePin, 0);
  analogWrite(valvePin, PWM_max);
  delay(contractTime);
  analogWrite(valvePin, 0);
}

// calibrate endpoints
void calibrateEndpoints() {
  fullContract();
  posContracted = readPositionMm();

  // fully extend
  analogWrite(valvePin, 0);
  analogWrite(ovalvePin, PWM_max);
  delay(contractTime);
  posExtended = readPositionMm();

  analogWrite(ovalvePin, 0);
}

// build length thresholds in mm
void buildThresholds() {
  double travel = posExtended - posContracted;
  for (int i = 0; i < numSections; i++) {
    double frac = double(i + 1) / numSections;
    Len[i] = posContracted + travel * frac;
  }
}

// measure velocities between thresholds
void measureExtensionVelocities(int pwmVal, double *vel) {
  analogWrite(ovalvePin, pwmVal);

  unsigned long t_prev = millis();
  double pos_prev = readPositionMm();

  for (int i = 0; i < numSections; i++) {
    bool hit = false;
    unsigned long start = millis();
    while (millis() - start < fallbackTimeout) {
      double pos = readPositionMm();
      if (pos >= Len[i]) {
        unsigned long t_now = millis();
        double dt = (t_now - t_prev) / 1000.0;  // seconds
        vel[i] = (pos - pos_prev) / dt;         // mm/s
        t_prev = t_now;
        pos_prev = pos;
        hit = true;
        break;
      }
    }
    if (!hit) {
      // Timeout fallback
      vel[i] = -1.0;
      t_prev = millis();
      pos_prev = readPositionMm();
      break;
    }
  }

  analogWrite(ovalvePin, 0);
}

// print results
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

void fullExtend() {
  analogWrite(valvePin, 0);
  analogWrite(ovalvePin, PWM_max);
  delay(extendTimeMs);
  analogWrite(ovalvePin, 0);
}
