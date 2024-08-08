//Real-time Length Sensing
//By: Rochelle Jubert
//MOLLY USE THIS ONE

//Use Linear Potentiometer to measure real-time displacement of pneumatic-actuated artifical muscle

//notes:
// -Tell the valve to stop opening and closing after a certian number of cycles. Use counter?
// -Write two separate codes for short term and long-term
// -Make sure the writing to the SDcard lines up with valve actuating
// -Address the delay 
// -There's a delay actuating the valve when the SDcard is writing 
// -Does the delay in the blink code delay the whole code?


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

// Establishing serial communication between Arduino and computer
  Serial.begin(9600);

//Establish the solenoid pin as an OUTPUT
  pinMode(solenoidPin, OUTPUT);
}
void loop() {

  //OPTION 1: Actuate the solenoid valve using the transistor (Binary ON/OFF Solenoid)
    // unsigned long currentMillis = millis();
    //   writeData();    

    //   if (currentMillis - previousMillis >= interval) {
    //     // save the last time you blinked the LED
    //       previousMillis = currentMillis;

    //     // if the LED is off turn it on and vice-versa:
    //       if (pinState == LOW) {
    //         pinState = HIGH;
    //       } else {
    //         pinState = LOW;
    //   }

    //   // set the LED with the ledState of the variable:
    //   digitalWrite(solenoidPin, pinState);
    // }

    //analogWrite(PWM_PIN, pwmValue);

  //OPTION 2: This is creating steps using the proportional solenoid valve
    // if (currentMillis - previousMillis >= interval) {
    //   previousMillis = currentMillis;
    
    //   // Increment the PWM value by 1024 (adjust as needed)
    //   pwmValue += 1024; //1024;

    //   // Ensure the PWM value stays within the acceptable range (0-4096)
    //   pwmValue = constrain(pwmValue, 0, 4096);

    //   analogWrite(PWM_PIN, pwmValue);
    // }
    

  //OPTION 3: Ramp code    
    // rampUp();
    // delay(20);  // Delay for 1 second between ramps
    // rampDown();
    // delay(20);

  //Option 4: Hold Up and Hold Down
    // holdup();
    // delay(1);
    // holddown();
    // delay(1);

  //Option 5: Ramp and Hold
    // rampUp();
    // delay(1);
    // holdup();
    // delay(1);
    // rampDown();
    // delay(1);
    // holddown();

  //OPTION 6: 2 valve configuration
    // unsigned long currentMillis = millis();
    // //writeData();

    //   if (currentMillis - previousMillis >= interval) {
    //     // save the last time you blinked the LED
    //       previousMillis = currentMillis;

    //     // if the LED is off turn it on and vice-versa:
    //       if (pinState == LOW) {
    //         pinState = HIGH;
    //         pwmValue = 0;
    //         // set the LED with the ledState of the variable:
    //           digitalWrite(solenoidPin, pinState);
    //           analogWrite(PWM_PIN, pwmValue);
    //       } else {
    //         pinState = LOW;
    //         pwmValue = 100;
    //         // set the LED with the ledState of the variable:
    //           digitalWrite(solenoidPin, pinState);
    //           analogWrite(PWM_PIN, pwmValue);
    


     //}

  //Option 7: Pulsing
    // unsigned long currentMillis = millis();
    // unsigned long timeSinceLastIntervalStart = currentMillis - previousMillis; // Time since the last interval start
    // writeData();

    // if (!continueRunning) {
    // return; // Exit the loop if the continueRunning flag is false
    // }

    // // Pulse control logic for the first pulse
    //   if (timeSinceLastIntervalStart < pulseWidth && !isPumpingFirst) {
    //     digitalWrite(solenoidPin, HIGH); // Activate the pump for the first pulse
    //     isPumpingFirst = true;
    //   } else if (timeSinceLastIntervalStart >= pulseWidth && isPumpingFirst) {
    //     digitalWrite(solenoidPin, LOW); // Deactivate the pump after the first pulse
    //     isPumpingFirst = false;
    //   }

    // // Pulse control logic for the second pulse
    //   if (timeSinceLastIntervalStart >= delayBetweenPulses && timeSinceLastIntervalStart < delayBetweenPulses + pulseWidth && !isPumpingSecond) {
    //     digitalWrite(solenoidPin, HIGH); // Activate the pump for the second pulse
    //     isPumpingSecond = true;
    //   } else if (timeSinceLastIntervalStart >= delayBetweenPulses + pulseWidth && isPumpingSecond) {
    //     digitalWrite(solenoidPin, LOW); // Deactivate the pump after the second pulse
    //     isPumpingSecond = false;
    //   }

    // // Adjust delay between pulses at the end of the interval
    //   if (timeSinceLastIntervalStart >= interval) {
    //     previousMillis = currentMillis; // Reset the interval timer for the next cycle

    // // Adjust delay between pulses at the end of the interval
    //   if (timeSinceLastIntervalStart >= interval) {
    //   previousMillis = currentMillis; // Reset the interval timer for the next cycle

    //   // Adjust delay between pulses according to the specified logic
    //     if (delayBetweenPulses >= 1000) {  //for range of > 1000 , reduce by 100ms per interval
    //       delayBetweenPulses -= 100;
    //     } else if (delayBetweenPulses >= 500) { //for range of 1000 to 500ms, reduce by 50ms per interval
    //       delayBetweenPulses -= 50;
    //     } else if (delayBetweenPulses >= 250) { //for range of 500 to 250ms, reduce by 25ms per interval
    //       delayBetweenPulses -= 25;
    //     } else if (delayBetweenPulses >= 100) { //for range of 250 to 100ms, reduce by 15ms per interval
    //       delayBetweenPulses -= 15;
    //     } else if (delayBetweenPulses > 0) {    //for range of 100 to 0ms, reduce by 10ms per interval
    //       delayBetweenPulses -= 10;
    //     }

    //   // Ensure delayBetweenPulses doesn't go below 0
    //     if (delayBetweenPulses < 0) {
    //       delayBetweenPulses = 0;
    //     }

    //   // Record the time when delay between pulses first reaches zero
    //     if (delayBetweenPulses <= 25 && delayZeroTime == 0) {
    //       delayZeroTime = currentMillis;
    //     }

    //   // Check if we should stop running after a certain time with zero delay
    //     if (delayZeroTime > 0 && (currentMillis - delayZeroTime >= 0)) {
    //       continueRunning = false; // Stops the loop after 4 seconds of zero delay
    //     }
    //   }
    
    //   }

  //Option 8: Random PWM Signal
    // unsigned long startTime = millis();
    // unsigned long currentTime;
    // int currentValue = 0;
    // int targetValue = 0;

    // while ((currentTime = millis()) - startTime < 40000) {
    //   // Generate a random target value
    //   targetValue = random(4095 + 1);
    
    //   // Ramp up or down to the target value
    //     while (currentValue != targetValue) {
    //       if (currentValue < targetValue) {
    //         currentValue +=120;
    //         if (currentValue > targetValue) {
    //           currentValue = targetValue;
    //         }
    //       } else {
    //         currentValue-=120;
    //         if (currentValue < targetValue){
    //           currentValue = targetValue;
    //         }
    //       }
    //       analogWrite(PWM_PIN, currentValue);
    //       writeData();
    //       delay(1); // adjust the speed of the ramp
    //     }
    
    //   // Wait for a random amount of time before changing the target value
    //     delay(random(10, 100)); // adjust the range of delay
    // }

  //Option 9: Ramp Air + Quick Release
  //Have proportional valve in line with solenoid to release
    // delay(1);
    // rampUp();
    // delay(1);
    // open();

  //Option 10: Quick Fill + Ramp Release
  //Have solenoid in line with proportional valve to release, change rampUp mapping to 200, 4095 (adjust as needed)
    open2();
    delay(1);    
    rampUp();
    delay(1);

}

void open() {
  unsigned long startTime = millis();
  unsigned long currentTime;
  int pwmValue;

  while ((currentTime = millis()) - startTime <= interval) {
    pwmValue = 0;
    digitalWrite(solenoidPin, HIGH); 
    writeData(pwmValue);
    delay(10);  // Adjust delay as needed for smoother ramp
    
  }
    digitalWrite(solenoidPin, LOW);  // Ensure PWM is off at the end
}

void open2() {
  unsigned long startTime = millis();
  unsigned long currentTime;
  int pwmValue;

  while ((currentTime = millis()) - startTime <= interval) {
    digitalWrite(PWM_PIN, 0);
    digitalWrite(solenoidPin, HIGH); 
    writeData(pwmValue);
    delay(10);  // Adjust delay as needed for smoother ramp
    
  }
   digitalWrite(solenoidPin, LOW);  // Ensure PWM is off at the end
}

void rampUp() {
  unsigned long startTime = millis();
  unsigned long currentTime;
  int pwmValue;

  while ((currentTime = millis()) - startTime <= rampDuration) {
    pwmValue = map(currentTime - startTime, 0, rampDuration, 200, 4095);
    analogWrite(PWM_PIN, pwmValue);
    writeData(pwmValue);
    delay(10);  // Adjust delay as needed for smoother ramp
  }

  analogWrite(PWM_PIN, 0);  // Ensure PWM is off at the end
}

void rampDown() {
  unsigned long startTime = millis();
  unsigned long currentTime;
  int pwmValue;

  while ((currentTime = millis()) - startTime <= rampDuration) {
    pwmValue = map(currentTime - startTime, 0, rampDuration, 4095, 0);
    analogWrite(PWM_PIN, pwmValue);
    writeData(pwmValue);
    delay(10);  // Adjust delay as needed for smoother ramp
  }

  analogWrite(PWM_PIN, 0);  // Ensure PWM is off at the end
}

void holdup() {
  unsigned long startTime = millis();
  unsigned long currentTime;
  int pwmValue;

  while ((currentTime = millis()) - startTime <= interval) {
    pwmValue = 4095;
    analogWrite(PWM_PIN, pwmValue);
    writeData(pwmValue);
    delay(10);  // Adjust delay as needed for smoother ramp
  }

  analogWrite(PWM_PIN, 0);  // Ensure PWM is off at the end
}

void holddown() {
  unsigned long startTime = millis();
  unsigned long currentTime;
  int pwmValue;

  while ((currentTime = millis()) - startTime <= interval) {
    pwmValue = 0;
    analogWrite(PWM_PIN, pwmValue);
    writeData(pwmValue);
    delay(10);  // Adjust delay as needed for smoother ramp
  }

  analogWrite(PWM_PIN, 0);  // Ensure PWM is off at the end
}

void writeData(int pwmValue) {

  //Generate timestamp
    long timestamp = millis();

  // Assign read potentiometer value to variable analogValue and pressure value to pValue
    float potValue = analogRead(pot);
    float pValue = analogRead(psensor);

  // Use H-diagram to interpolate and establish ratio between displacement and potentiometer reading
    //float displacement = potValue*0.0993157; old calibration
    float displacement = potValue*0.1013782991; //new calibration
    float pressure = pValue*0.1084 - 2.1067;

  //Calibrate strain gauge reading
    float strainvoltage = analogRead(straingauge);

  //Calculate strain gauge values
    //strainval[0] = strainval[1];
    //strainval[1] = strainval[2];
		//strainval[1] = (2.452372752527856026e-1 * strainvoltage) + (0.50952544949442879485 * strainval[0]); //+ (-0.95099351006330667957 * strainval[1]);

    //strainfiltval = (strainval[0] + strainval[1]); //+ 2.000000 * strainval[1];
    //float straindisp = strainvoltage * 0.25547 - 159.203; old calibration before adding table top power supply
    float straindisp = strainvoltage * 0.066573 + 41.652;
    //float straindisp2 = straindisp * 0.973 + 1.856;

    
    if (timestamp<40000) {
      
      Serial.print(displacement);
      Serial.print(", ");
      Serial.print(strainvoltage);
      Serial.print(", ");
      Serial.print(straindisp);
      Serial.print(", ");
      Serial.print(pwmValue);
      Serial.print(", ");
      Serial.print(pressure);
      Serial.print(", ");
      Serial.println(timestamp);
      
      //Serial.println("   done.");

    // Logs data every 10 milliseconds 
      delay(10);}


}
