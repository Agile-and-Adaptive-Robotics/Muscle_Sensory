// Pin assignments
int inflatepin1 = 13;  // Inflation pin
int deflatepin1 = 10;  // Deflation pin
int p_sensor = A1;     // Pressure sensor pin
int f_sensor = A3;     // Force sensor pin

// Timing variables
unsigned long previousMillis = 0;  // Tracks the timer
const long interval = 5000;        // Interval of inflation
const long total_time = 25000;     // Total test time

// Sensor reading variables
float p_value = 0;  // Pressure sensor reading
float f_value = 0;  // Force sensor reading

// Pumping state variables
int pump1 = HIGH;
int pump2 = LOW;

// Buffer for storing last 4 force sensor readings
float f_values_buffer[8] = {0, 0, 0, 0, 0, 0, 0, 0};
float true_avg_f_value = 0;

void setup() {
  // Start serial communications
  Serial.begin(9600);

  // Configure pins as outputs
  pinMode(inflatepin1, OUTPUT);
  pinMode(deflatepin1, OUTPUT);
}

void loop() {
  // Control the pumps
  digitalWrite(inflatepin1, pump1);  // Inflation
  digitalWrite(deflatepin1, pump2);  // Deflation

  // Read sensor values
  f_value = analogRead(f_sensor);  // Force sensor
  p_value = analogRead(p_sensor);  // Pressure sensor

  // Calibrate sensor readings
  float true_p_value = (p_value * 0.7538 - 11.583);  // Convert to kPa
  float true_f_value = (f_value * 157 / 146);        // Convert to N

  // Update the buffer with the new reading
  for (int i = 7; i > 0; i--) {
    f_values_buffer[i] = f_values_buffer[i - 1];  // Shift buffer
  }
  f_values_buffer[0] = true_f_value;  // Store new reading

  // Calculate the average force value
  true_avg_f_value = 0;
  for (int i = 0; i < 8; i++) {
    true_avg_f_value += f_values_buffer[i];
  }
  true_avg_f_value /= 8;  // Compute average

  // Print the average and pressure values
  // Serial.print("Average Force (N): ");
  Serial.println(true_avg_f_value);
    Serial.print(" ");
   Serial.println(true_p_value);

  // Implement any additional functionality here...
}
