const int potPin = A3;
const int opotPin = A1;
const int valvePin = 3;
const int ovlavePin = 9;
const int SGPin = A4;
int valveVal = 0;
int ovalveVal = 255;



void setup() {
  pinMode(valvePin, OUTPUT);
  pinMode(ovlavePin, OUTPUT);
  analogWrite(valvePin, valveVal);
  analogWrite(ovlavePin, ovalveVal);
  Serial.begin(9600);
  // put your setup code here, to run once:

}

void loop() {
  int potVal = analogRead(potPin);
  int opotVal = analogRead(opotPin);
  valveVal = map(potVal, 0, 1023, 0, 255);
  ovalveVal = map(opotVal, 0, 1023, 0, 255);

  Serial.print("In: "); Serial.print(valveVal);
  Serial.print("\tOut: "); Serial.print(ovalveVal);
  Serial.print("\tSG: "); Serial.print(analogRead(SGPin));
  Serial.println("");

  analogWrite(valvePin, valveVal);
  analogWrite(ovlavePin, ovalveVal);
  // put your main code here, to run repeatedly:

}
