const int potPin = A3;
const int SGPin = A0;
const int valvePin = 3;
const int lpotPin = A5;
const int pressPin = A2;
int potVal = 0;
double SGVal = 0;
int valveVal = 0;
int lpotVal = 0;
double pressVal = 0;
int temp = 0;

int testVals[] = {0,16,32,48,64,80,96,112,128,144,160,176,192,208,224,240,255};


void setup() {
  pinMode(valvePin, OUTPUT);
  Serial.begin(9600);

  // put your setup code here, to run once:

}

void loop() {
  potVal = analogRead(potPin);
  SGVal = map(analogRead(SGPin), 109.5, 125, 0.0, 100.0);
  lpotVal = analogRead(lpotPin);
  pressVal = map(analogRead(pressPin), 37, 905, 0.0, 100.0);
  valveVal = map(potVal, 0, 1023, 0, 255);


  //analogWrite(valvePin, valveVal);

  Serial.print("pot: "); Serial.print(potVal);
  Serial.print("\t valve: "); Serial.print(testVals[temp]);
  Serial.print("\t SG:"); Serial.print(SGVal);
  Serial.print("\t Pressure: "); Serial.print(pressVal);
  
  Serial.println("");
if(Serial.available() > 0){

  if(Serial.read() == 'a'){
    temp++;
    if(temp > 16){
      temp = 0;
    }
    analogWrite(valvePin, testVals[temp]);
  }
}
  delay(100);
  // put your main code here, to run repeatedly:

}
