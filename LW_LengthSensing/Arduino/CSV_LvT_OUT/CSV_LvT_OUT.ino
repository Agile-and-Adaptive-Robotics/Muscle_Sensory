const int potPin = A3;
const int opotPin = A1;
const int valvePin = 3;
const int ovalvePin = 9;
const int SGPin = A4;
const int LpotPin = A5;
int valveVal = 0;
int ovalveVal = 255;
int outVal = 255;
int inc = 5;
int inVal = 105;
int SG = 0;
double Len[40];
bool first = true;

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
      //delay(3000);
      first = true;
      inVal = 255;
      outVal = 255;
      while (outVal >= 105) {
        analogWrite(ovalvePin, 0);
        if(!first){
        Serial.print(String(outVal) + ",");
        analogWrite(valvePin, 0);
        }
        int start = millis();
        int now = millis();
        double lastLpot = map(analogRead(LpotPin), 0, 1023, 10000.00, 0.00) / 100.0;
        int last = now;
        int temp = 0;
        int lastTime = millis();
        int time = (now - start);
        double dt = 0;
        analogWrite(ovalvePin, outVal);
        if(first){
          analogWrite(valvePin, 255);
          analogWrite(ovalvePin, 0);
        }
        while ((now - start) <= 5000 && temp <= 40) {
          double lpotVal = map(analogRead(LpotPin), 0, 1023, 10000.000, 0.000) / 100.000;
          now = millis();
          time = now - lastTime;
          dt = abs(lpotVal - lastLpot);
          //Serial.println(dt);
          if (dt >= 0.5) {
            lastTime = millis();
            double velo = (dt / time) * 1000.0;
            if(!first){
            Serial.print(String(velo,4) + ",");
            }
            if(inVal == 255 && first){
              Len[temp] = lpotVal;
              //Serial.println(temp);
            }
            temp++;

            lastLpot = lpotVal;
          }
        }
        analogWrite(valvePin, 255);
        analogWrite(ovalvePin, 0);
        delay(3000);
        Serial.println("");
        if(!first){
        outVal -= inc;
      }
        analogWrite(valvePin, 0);
        analogWrite(ovalvePin, 255);
      if(first){
        inVal = 105;
        Serial.print("PWM,");
        for(int i = 0; i < 40; i++){
          Serial.print("L"+String(i)+",");
        }
        Serial.println("");
        Serial.print("-1,");
        for(int i = 0; i < 40; i++){
        Serial.print(String(Len[i]) + ",");
      }
      first = false;
      Serial.println("");
      }
      }
      analogWrite(ovalvePin, 255);
      

    }


  }


  // put your main code here, to run repeatedly:
}
