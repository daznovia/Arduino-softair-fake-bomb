#include <LiquidCrystal.h>
#include <LCDKeypad.h>
LCDKeypad lcd;

//Define all the bomb states  
#define READY 0
#define ARMED 1
#define DISARMED 2 
#define DETONATED 3

int timer = 1199;
char buf[12];
long previousMillis = 0; 
long interval = 10;   
int stato=0;
int prova=0;
int chiave= 0;


void setup() {
//inizializzo la seriale e pulisco il display a 7 segmenti
Serial.begin(9600);
Serial.print("v");

//inizializzo il pin di stato
pinMode(13,OUTPUT);
pinMode(10,OUTPUT);


//inizializzo l'lcd e stampo un messaggio di benvenuto
lcd.begin(16, 2);
lcd.clear();
lcd.print("NOCS CLUB");
delay(2000);
lcd.clear();
lcd.setCursor(0,0);
lcd.print("Immetti il");
lcd.setCursor(0,1);
lcd.print("Codice: ");




chiave = digitalRead(12);
}



void loop() {
  

  
  
if(prova==4)
disarmaBomba();

if (lcd.button()==KEYPAD_UP && 1) {
  armaBomba(); 
//waitReleaseButton();
    }
    
if (lcd.button()==KEYPAD_LEFT && stato==ARMED) {
waitReleaseButton();
  lcd.print("1");
  prova++;
  
    }
    
if (lcd.button()== KEYPAD_SELECT) {
  disarmaBomba();
    }


if(stato!=DISARMED && timer==1)
  esplosioneBomba();
  //timer=9999;





if(stato==ARMED){
contatore();

}


}

void armaBomba() {
     stato=ARMED;
     previousMillis = millis();
 digitalWrite(10, HIGH);
 digitalWrite(13, LOW);
   }
   
 void disarmaBomba() {
   stato=DISARMED;
   digitalWrite(10, LOW);
    digitalWrite(13, HIGH);
 }
   
   
void contatore(){
  
unsigned long currentMillis = millis();

if(currentMillis - previousMillis > interval) {
    previousMillis = currentMillis;   
  
sprintf(buf, "%04d", timer);
Serial.print(buf);
if(timer>0 && stato==ARMED) timer--;
  }
  
}

void waitReleaseButton()
{
  delay(10);
  while(lcd.button()!=KEYPAD_NONE)
  {
  }
  delay(10);
}

void esplosioneBomba(){
int i;
lcd.clear();
lcd.setCursor(0,0);
lcd.print("     BOOM!!!");
for(i=0;i<25;i++){
   digitalWrite(10, LOW);
   digitalWrite(13, HIGH);
   delay(100);
   digitalWrite(13, LOW);
   digitalWrite(10, HIGH);
  delay(100);
}
}
