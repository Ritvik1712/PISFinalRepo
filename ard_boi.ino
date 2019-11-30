#include <SoftwareSerial.h>
SoftwareSerial espSerial(2,3);

long l;
int num;
int trigPin = 9;
int echoPin = 10;
long duration;
int distance;
int average;
double time1;

void setup() {
  Serial.begin(115200);
  espSerial.begin(115200);
  pinMode(12, OUTPUT);
  digitalWrite(12, LOW);
  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);
  average = 0;
  time1 = millis();
}


void loop() {
  digitalWrite(trigPin, LOW);
  delayMicroseconds(10);
  
  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);
  
  digitalWrite(trigPin, LOW);
  duration = pulseIn(echoPin, HIGH);
  distance= duration*0.034/2;

  if (distance > 0 and distance < 200) {
    average = distance;
  }

  if (millis() - time1 > 15500) {
  espSerial.write(average);
  time1 = millis();
  }
  if (espSerial.available() > 0) {
    l = espSerial.read();
    if (l == 1) {
      digitalWrite(12, HIGH);
    }

    if (l == 0) {
      digitalWrite(12, LOW);
    }
  }
  delay(500);  
}
