//Attempt to make te linear calibration process more automatic

// Assigning Linear Potentiometer to Analog Input A0, pressure sensor to A2, and solenoid valve to 7
  const int pot = A0;
  const int psensor = A2; 
  const int straingauge = A5;
  //float strainval[2];
  //float strainfiltval;
 // int solenoidPin = 10;
  #define PWM_PIN 6
  #define solenoidPin 10
  int pwmValue = 0 ;
  int pinState = LOW;
  unsigned long previousMillis = 0;
  const long interval = 1000;
  const long rampDuration = 4000;

//Pulse Information

  int delayBetweenPulses = 1000; // Initial delay between pulses in milliseconds, starting at 500ms
  const int pulseWidth = 35;    // Width of each pulse in milliseconds
  bool isPumpingFirst = false;  // Flag indicating whether the pump is currently active for the first pulse
  bool isPumpingSecond = false; // Flag indicating whether the pump is currently active for the second pulse
  unsigned long delayZeroTime = 0; // Timestamp when delay between pulses first reaches zero
  bool continueRunning = true; // Flag to control the execution of the main loop


void setup() {

  //Set PWM resolution to 12 bits (0-4095)
  analogWriteResolution(12);
  pinMode(PWM_PIN,OUTPUT);

  //Establish the solenoid pin as an OUTPUT
  pinMode(solenoidPin, OUTPUT);

  // Start serial communication
  Serial.begin(9600);
}

void loop() {

  unsigned long currentMillis = millis();
  // Check if data is available to read from serial port
  if (Serial.available() > 0) {
    // Read the incoming character
    char command = Serial.read();

    // Check if the command is 'R'
    if (command == 'R') {
     // if (currentMillis - previousMillis >= interval) {
       // previousMillis = currentMillis;
       if (pwmValue == 0);

        writeData();
        pwmValue = 1500; //Hop from 0 to 1500
        analogWrite(PWM_PIN, pwmValue);
        
    } else {
        // Increment the PWM value by 500 (adjust as needed)

        writeData();
        pwmValue += 500; 

        // Ensure the PWM value stays within the acceptable range (0-4096)
        pwmValue = constrain(pwmValue, 0, 4096);

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

      float displacement = potValue*0.1013782991; //new calibration
      float pressure = pValue*0.1084 - 2.1067;

      
      // Send the measurement back to MATLAB
      Serial.println(displacement);
      Serial.println(strainvoltage);

}