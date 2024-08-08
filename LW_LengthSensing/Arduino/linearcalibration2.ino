const int pot = A0;
const int psensor = A2; 
const int straingauge = A5;
#define PWM_PIN 6
#define solenoidPin 10
int pwmValue = 0 ;
int pinState = LOW;
unsigned long previousMillis = 0;
const long interval = 1000;
char command;

void setup() {
  // Set PWM resolution to 12 bits (0-4095)
  analogWriteResolution(12);
  pinMode(PWM_PIN, OUTPUT);
  pinMode(solenoidPin, OUTPUT);
  // Start serial communication
  Serial.begin(9600);
}

void loop() {
  unsigned long currentMillis = millis();
  // Check if data is available to read from serial port
  if (Serial.available() > 0) {
    // Read the incoming character
    command = Serial.read();
    // Check if the command is 'R'
    if (command == 'R' && pwmValue == 0) {
      writeData();
      pwmValue = 1500; // Set PWM value to 1500
      analogWrite(PWM_PIN, pwmValue);
    } else {
      // Increment the PWM value by 500 (adjust as needed)
      writeData();
      pwmValue += 500; 
      // Ensure the PWM value stays within the acceptable range (0-4095)
      pwmValue = constrain(pwmValue, 0, 4095);
      analogWrite(PWM_PIN, pwmValue);
    }
  }

  // Add any other code needed for your application
  // For example, additional sensors reading or control logic
}

void writeData() {
  float potValue = analogRead(pot);
  float pValue = analogRead(psensor);
  float strainvoltage = analogRead(straingauge);

  float straindisp = strainvoltage * 0.066573 + 41.652;
  float displacement = potValue * 0.1013782991; // Adjusted calibration
  float pressure = pValue * 0.1084 - 2.1067;

  // Send the measurement back to MATLAB
  Serial.print(displacement);
  Serial.print(",");
  Serial.print(strainvoltage);
  Serial.print(",");
  Serial.println(pwmValue); // Use println to end the line
}