#include <LiquidCrystal.h>
#include <LCDKeypad.h>
LCDKeypad lcd;

//Define all the bomb states  
#define READY 0
#define ARMED 1
#define DISARMED 2 
#define DETONATED 3

int timer = 299;
char buf[12];
long previousMillis = 0; 
long interval = 10;   
int stato=ARMED;



void setup() {
  
Serial.begin(9600);
Serial.print("v");
delay(2000);

}
void loop() {

if(stato!=DISARMED && timer==0)
  timer=9999;


if(stato==ARMED){
contatore();
}

}



void contatore(){
unsigned long currentMillis = millis();

if(currentMillis - previousMillis > interval) {
    previousMillis = currentMillis;   
  
sprintf(buf, "%04d", timer);
Serial.print(buf);
if(timer>0) timer--;
  }
  
}
