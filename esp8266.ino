#include "ThingSpeak.h"
#include <ESP8266WiFi.h>
const char ssid[] = "Heisenberg";  
const char pass[] = "ByPass118";           
WiFiClient  client;

unsigned long counterChannelNumber = 919947; 
unsigned long channel2 = 924266; 
const char * key2= "ZZCZOC4T2564BI43";
const char * myCounterReadAPIKey = "JT5W7OOTW7CLHVHV";
const char * writeAPIKey= "UN6JZQ4042O8PAGA";
const int FieldNumber2 = 2;  
long value;
int num;

void setup()
{
  Serial.begin(115200);
  WiFi.mode(WIFI_STA);
  ThingSpeak.begin(client);
}

void loop()
{

  if (WiFi.status() != WL_CONNECTED)
  {
    while (WiFi.status() != WL_CONNECTED)
    {
      WiFi.begin(ssid, pass);
      delay(4000);
    }
  }


  long relay = ThingSpeak.readLongField(channel2, 1, key2);
  int statusCode = ThingSpeak.getLastReadStatus();
  if (statusCode == 200)
  {
    Serial.write(relay);
  }
  delay(100);

  if (Serial.available() > 0) {
    num = Serial.read();
    int x = ThingSpeak.writeField(counterChannelNumber, 1, num, writeAPIKey);
    delay(100);
  }

}
