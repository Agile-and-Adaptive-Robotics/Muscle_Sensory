const int potPin = A3;
const int SGPin = A0;
const int valvePin = 3;
const int lpotPin = A5;
const int pressPin = A2;
const int ovalvePin = 9;
int potVal = 0;
double SGVal = 0;
int valveVal = 0;
int lpotVal = 0;
double pressVal = 0;
int ovalveVal = 0;
int temp = 0;

int testVals[] = {};
double testPress[] = { 4, 14, 28, 42, 57, 71, 86, 98, 99, 100 };


void setup() {
  pinMode(valvePin, OUTPUT);
  Serial.begin(9600);
  analogWrite(ovalvePin, 255);

  // put your setup code here, to run once:
}

void loop() {
  potVal = analogRead(potPin);
  SGVal = map(analogRead(SGPin), 109.5, 125, 0.0, 100.0);
  lpotVal = map(analogRead(lpotPin), 1023, 0, 0, 100);
  pressVal = map(analogRead(pressPin), 37, 905, 0.0, 100.0);
  valveVal = map(potVal, 0, 1023, 0, 255);


  //analogWrite(valvePin, valveVal);
  /*
  Serial.print("pot: "); Serial.print(potVal);
  Serial.print("\t valve: "); Serial.print(testVals[temp]);
  Serial.print("\t SG:"); Serial.print(SGVal);
  Serial.print("\t Pressure: "); Serial.print(pressVal);
  Serial.print("\t Length: "); Serial.print(lpotVal);
  
  Serial.println("");
  */
  if (Serial.available() > 0) {
    unsigned long start;
    unsigned long end;
    int Slen;
    int Elen;

    if (Serial.read() == 'a') {
      Serial.println("TEST,TIME,DISTANCE,SG,");
      temp = 0;
      while (temp < 9) {
        analogWrite(ovalvePin, 0);
        if (temp > 9) {
          temp = 0;
        }
        //Serial.println(pressVal);
        start = millis();
        Slen = lpotVal = map(analogRead(lpotPin), 1023, 0, 0, 100);
        analogWrite(valvePin, testVals[temp]);

        while (pressVal < testPress[temp]) {
          pressVal = map(analogRead(pressPin), 37, 905, 0.0, 100.0);
          //Serial.print("Inflating...");
          //Serial.println(pressVal);
        }
        end = millis();
        Elen = lpotVal = map(analogRead(lpotPin), 1023, 0, 0, 100);
        analogWrite(valvePin, 0);
        //Serial.print("done: ");
        Serial.print(temp);
        Serial.print(",");
        //Serial.print("\t time:");
        Serial.print(end - start);
        Serial.print(",");
        //Serial.print("\t distnace: ");
        Serial.print(-(Elen - Slen));
        Serial.print(",");
        //Serial.print("\t SG: ");
        Serial.print(analogRead(SGPin));
        Serial.println(",");
        analogWrite(ovalvePin, 255);
        temp++;
        while (pressVal > 2) {
          pressVal = map(analogRead(pressPin), 37, 905, 0.0, 100.0);
          //Serial.print(pressVal);
          //Serial.println("deflate");
        }
        delay(100);
        //Serial.print(temp);
      }
    }

    if (Serial.read() == 'e') {
      analogWrite(valvePin, 0);
    }
  }

  delay(100);
  // put your main code here, to run repeatedly:
}
