const int potPin = A;
const int SGPin = A;
const int valvePin = 3;
const int lpotPin = A;
const int presPin = A;
int potVal = 0;
int SGVal = 0;
int valveVal = 0;
int lpotVal = 0;
int pressVal = 0;


void setup() {
  pinMode(valvePin, OUTPUT);
  Serial.begin(9600);
  // put your setup code here, to run once:

}

void loop() {
  potVal = analogRead(potPin);
  SGVal = analogRead(SGPin);
  lpotVal = analogRead(lpotPin);
  pressVal = analogRead(pressPin);
  valveVal = map(potVal, 0, 1023, 0, 255);

  Serial.print("pot: "); Serial.print(potVal);
  Serial.ptint("\t valve: "); Serial.print(valveVal);
  Serial.println("");

  delay(100);
  // put your main code here, to run repeatedly:

}
