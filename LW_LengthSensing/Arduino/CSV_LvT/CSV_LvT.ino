const int potPin = A3;
const int opotPin = A1;
const int valvePin = 3;
const int ovalvePin = 9;
const int SGPin = A4;
const int LpotPin = A5;
int valveVal = 0;
int ovalveVal = 255;
int outVal = 0;
int inc = 3;
int inVal = 100;
int SG = 0;
double Len[50];

void setup() {
  // put your setup code here, to run once:
  pinMode(valvePin, OUTPUT);
  pinMode(ovalvePin, OUTPUT);
  analogWrite(valvePin, valveVal);
  analogWrite(ovalvePin, ovalveVal);
  Serial.begin(9600);
}

void loop() {
  if (Serial.available() > 0) {
    //Serial.println(Serial.read());

    if (Serial.read() == 'a') {
      while (inVal <= 255) {
        analogWrite(ovalvePin, 0);
        Serial.print(String(inVal) + ",");
        int start = millis();
        int now = millis();
        double lastLpot = map(analogRead(LpotPin), 0, 1023, 10000.00, 0.00) / 100.0;
        int last = now;
        int temp = 0;
        int lastTime = millis();
        int time = (now - start);
        double dt = 0;
        analogWrite(valvePin, inVal);
        while ((now - start) <= 5000 && temp <= 50) {
          double lpotVal = map(analogRead(LpotPin), 0, 1023, 10000.000, 0.000) / 100.000;
          now = millis();
          time = now - lastTime;
          dt = abs(lpotVal - lastLpot);
          //Serial.println(dt);
          if (dt >= 0.5) {
            lastTime = millis();
            double velo = (dt / time) * 1000.0;
            Serial.println(String(velo,4) + ",");
            if(inVal == 255){
              Len[temp] = lpotVal;
            }
            temp++;

            lastLpot = lpotVal;
          }
        }
        analogWrite(valvePin, 0);
        analogWrite(ovalvePin, 255);
        delay(3000);
        Serial.println("");

        inVal += inc;
      }
      analogWrite(ovalvePin, 255);
      Serial.print("PWM,");
      for(int i = 0; i < 50; i++){
        Serial.print(String(Len[i]) + ",");
      }
    }


  }


  // put your main code here, to run repeatedly:
}
