// Arduino sketch: measure actuator velocity across percentages of travel

const int LpotPin     = A5;     // position sensor pin (linear pot)
const int valvePin    = 3;      // PWM pin for contraction
const int ovalvePin   = 9;      // PWM pin for extension

const int PWM_start   = 105;    // starting PWM for sweep
const int PWM_max     = 255;    // max PWM
const int PWM_inc     = 3;      // PWM increment
const int numPoints   = 100;    // number of percentage thresholds (1% increments)
const uint32_t fallbackTimeout = 3000;  // ms to wait per point before fallback

double Len[numPoints];     // actual position thresholds

double posMax = 0;         // sensor value at fully contracted
double posMin = 0;         // sensor value at fully extended

void setup() {
  Serial.begin(9600);
  pinMode(valvePin, OUTPUT);
  pinMode(ovalvePin, OUTPUT);

  // ensure actuator fully extended at start
  analogWrite(valvePin, 0);
  analogWrite(ovalvePin, 255);
}

void loop() {
  if (Serial.available()) {
    char c = Serial.read();
    if (c == 'a') {
      // 1) Calibrate endpoints and build Len[] based on percentage
      calibrateEndpoints();
      buildThresholds();

      // 2) Print CSV header: PWM + percent labels
      Serial.print("PWM");
      for (int i = 0; i < numPoints; i++) {
        Serial.print(",Pct"); Serial.print(i+1);
      }
      Serial.println();

      // 3) Sweep PWM
      for (int pwm = PWM_start; pwm <= PWM_max; pwm += PWM_inc) {
        double velocities[numPoints];
        measureVelocities(pwm, velocities);
        // print results
        Serial.print(pwm);
        for (int i = 0; i < numPoints; i++) {
          Serial.print(",");
          Serial.print(velocities[i], 4);
        }
        Serial.println();
        delay(2000);
      }
      Serial.println("Sweep complete.");
    }
  }
}

//------------------------------------------------------------------------------

void calibrateEndpoints() {
  // move to fully contracted
  analogWrite(ovalvePin, 0);
  analogWrite(valvePin, PWM_max);
  delay(2000);
  posMax = readRaw();

  // move to fully extended
  analogWrite(valvePin, 0);
  analogWrite(ovalvePin, 255);
  delay(2000);
  posMin = readRaw();

  // stop motion
  analogWrite(ovalvePin, 0);
}

void buildThresholds() {
  // thresholds evenly spaced from 1% to 100%
  for (int i = 0; i < numPoints; i++) {
    double frac = double(i+1) / numPoints;  // 0.01 to 1.0
    Len[i] = posMax - (posMax - posMin) * frac;
  }
}

void measureVelocities(int pwmVal, double *vel) {
  // start contraction
  analogWrite(ovalvePin, 0);
  analogWrite(valvePin, pwmVal);

  unsigned long t_prev = millis();
  double pos_prev = readRaw();

  for (int idx = 0; idx < numPoints; idx++) {
    bool hit = false;
    unsigned long t_start = millis();
    while ((millis() - t_start) < fallbackTimeout) {
      double pos = readRaw();
      if (pos <= Len[idx]) {
        unsigned long t_now = millis();
        double dt = (t_now - t_prev) / 1000.0;  // s
        vel[idx] = fabs(pos - pos_prev) / dt;
        t_prev = t_now;
        pos_prev = pos;
        hit = true;
        break;
      }
    }
    if (!hit) {
      // fallback
      vel[idx] = 0.0;
      t_prev = millis();
      pos_prev = readRaw();
    }
  }
  analogWrite(valvePin, 0);
}

// return raw analog reading (0-1023)
double readRaw() {
  return analogRead(LpotPin);
}
