/* This example reads the sensor output at a fixed interval 
controlled sensor API

The range readings are in units of mm. */

#include <Wire.h>
#include <VL53L0X.h>

VL53L0X sensor;

void setup()
{
  Serial.begin(9600);
  Wire.begin();

  pinMode(12, OUTPUT);  // timing pin to check sampling frequency

  sensor.setTimeout(500);
  if (!sensor.init())
  {
    Serial.println("Failed to detect and initialize sensor!");
    while (1) {}
  }

  // Start continuous back-to-back mode (take readings as
  // fast as possible).  To use continuous timed mode
  // instead, provide a desired inter-measurement period in
  // ms (e.g. sensor.startContinuous(100)).
  sensor.startContinuous(20);
}

void loop()
{
  Serial.print(sensor.readRangeContinuousMillimeters());
  digitalWrite(12, !digitalRead(12));  // toggle the pin to check frequency
  if (sensor.timeoutOccurred()) { Serial.print(" TIMEOUT"); }

  Serial.println();
}