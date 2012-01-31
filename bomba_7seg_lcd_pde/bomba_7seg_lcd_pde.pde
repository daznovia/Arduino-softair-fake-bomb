#include <LiquidCrystal.h>
#include <LCDKeypad.h>
LCDKeypad lcd;

//Define all the bomb states  
#define READY 0
#define ARMED 1
#define DISARMED 2 
#define DETONATED 3

int timer = 9999;
char buf[12];
long previousMillis = 0; 
long interval = 10;   
int stato=0;



void setup() {
  
Serial.begin(9600);
Serial.print("v");
delay(2000);


}
void loop() {
  

   if (lcd.button()==KEYPAD_UP)
    {
     stato=ARMED;
     previousMillis = millis();
    }

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

int waitButton()
{
  int buttonPressed; 
  waitReleaseButton();
  lcd.blink();
  while((buttonPressed=lcd.button())==KEYPAD_NONE)
  {
  }
  //delay(50);  
  lcd.noBlink();
  return buttonPressed;
}

void waitReleaseButton()
{
  //delay(50);
  while(lcd.button()!=KEYPAD_NONE)
  {
  }
 // delay(50);
}

