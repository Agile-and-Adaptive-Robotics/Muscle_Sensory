/* Created by Josh Mak, Cody Schwarzenberg, and David Pleshakov for use in Agile and Adaptive Robotics Laboratory, Portland State University, Portland, OR
 *  Use for testing and characterizing BPA's 
 *  
 *  This program starts at a pre-defined frequency and tests the BPA Muscles using a pressure sensor and a Load cell connected to 
 *  HX711 microcontroller. When the first set-frequency is done being tested, the program moves on
 *  to test other frequencies up until the desired frequency is tested. 
 *  
 *  The Serial monitor outputs the data- raw pressure, raw force
 *  the calibration of the sensor and meter should be done in excel after the raw data has been transfered there because including the calibration in the code slows it down to much
 *  
 */

//FORCE METER
#include "HX711.h"
// HX711 circuit wiring
const int LOADCELL_DOUT_PIN = 2;
const int LOADCELL_SCK_PIN = 3;
HX711 scale;

//Timing
unsigned long spikeMillis = 0;
unsigned long ResetTime = 0;           //Timer for Resetting the Pulsing period
unsigned long DataTime = 0;            //Timer for data collection

//Frequency and Pulse Width
  // Period = Pulse_width_on + Pulse_width_off

float frequency = 30;                       //CHANGE: What Frequency to start at? Spike X times per second. This is in Hz (1/sec). ***********************************************************************
float pulse_width = 25;            //CHANGE: What is your desired pulse width (in milliseconds) make sure to input in milliseconds. Pulse with will be 10 ms, 15 ms, 20 ms *******************************
float period = (1/frequency)*1000;         // This will be the period in milliseconds

//float spiketime = (1/(2*frequency))*1000;      //frequency turned to milliseconds. The frequency is half the period.
float data_collection_frequency = 80;                 //frequency at which to collect data, needs to be at least 2x the spiketime and can't be greater than 80 because of the HX711 microconroller
float data_collection_period = 1/data_collection_frequency * 1000; //spike frequency turned into milliseconds
const int spikePin = 13;                   //what pin the festo is connected to
int spikeState = LOW;                    
//int n = 0;                                 //counters used to see how many times the BPA was spiked and compared to what the program was set to
int k = 0;                                 //counters used to see how many times data was collected to ensure at least 2 data collections per spike

unsigned long previousMillis = 0;


//________________________________________________________________________________________________
void setup() {
  pinMode(spikePin, OUTPUT);
  pinMode(A0,INPUT);
  digitalWrite(spikePin, spikeState);   //make sure the BPA is not on in the beginning
  scale.begin(LOADCELL_DOUT_PIN, LOADCELL_SCK_PIN); //initialize the force meter
  Serial.begin(9600);
   Serial.print("Frequency = "); Serial.println(frequency); 
   Serial.print("Pulse Width = "); Serial.println(pulse_width);
  // Serial.print("Test time for each Frequency: "); Serial.println(testTime); Serial.println(" ");
   //Serial.print("Start Frequency: "); Serial.println(frequency); 
}

//________________________________________________________________________________________________
void loop() {
  
  //Pulsing and timing
  unsigned long currentMillis = millis();

//______________________________________________________________________________________________
//  if (currentMillis - spikeMillis >= spiketime) { //Spike the bpa at the frequency set
//    spikeMillis = currentMillis;
//    if (spikeState == HIGH) {
//      spikeState = LOW;
//    }
//    else {
//      spikeState = HIGH;
//    }
//    digitalWrite(spikePin, spikeState);
//    n = n + 1;
//  }
//______________________________________________________________________________________________
  unsigned long dt = currentMillis - previousMillis;

  if ((dt > pulse_width) && (spikeState == HIGH))
  {
    digitalWrite(spikePin, LOW);
    spikeState = LOW;
    previousMillis = currentMillis;
  }
  else if ((dt > (period - pulse_width)) && (spikeState == LOW))
  {
    digitalWrite(spikePin, HIGH);
    spikeState = HIGH;
    previousMillis = currentMillis;  
  }
  

  if (currentMillis - DataTime >= data_collection_period){ //collect data to the serial monitor at the frequency set
    //***Max frequecny that the HX711 can run at is about 80 Hz, we need at lease 2 readinds per spike, so we need x to be at least 2
    DataTime = currentMillis;
    float arduino_pressure = analogRead(A0); // pressure reading from arduino
    float psi_pressure = (0.1100533983*arduino_pressure)-1.32438491; // Conversion based on calibrating
    float kilo_pascal_pressure = psi_pressure * 6894.76; // Conversion rate from google
    float arduino_force = scale.read(); // force reading from arduino
    float newton_force = (-0.0002215943*arduino_force) + 0.5136191769; // Conversion based on calibrating
    Serial.print(kilo_pascal_pressure); // Print the pressure value in kPa
    Serial.print(" , "); // space comma space
    Serial.print(psi_pressure); // Print the pressure value in psi
    Serial.print(" , ");// space comma space
    Serial.println(newton_force); // Print the force values in Newtons
//    Serial.print(analogRead(A0)); Serial.print(","); //pressure
//    Serial.println(scale.read());                   //ForceReading
    k = k + 1;
  }
//______________________________________________________________________________________________

//_______________________________________________________________________________________________
}
