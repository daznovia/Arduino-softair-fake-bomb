#include <LiquidCrystal.h>
#include <LCDKeypad.h>
LCDKeypad lcd;

//Define all the bomb states  
#define READY 0
#define ARMED 1
#define DISARMED 2 
#define DETONATED 3

int timer = 99;   // questo è il timer in decimi di secondo
char buf[12];
long previousMillis = 0; 

long buzzpreMillis = 0; 

long interval = 100;   
int stato=0;
int prova=0;
int LedVerde = 11;
int LedRosso= 10;
int buzzPin=19;


void setup() {
//inizializzo la seriale e pulisco il display a 7 segmenti
Serial.begin(9600);
Serial.print("v");

//inizializzo il pin di stato
pinMode(LedVerde,OUTPUT);
pinMode(LedRosso,OUTPUT);


//inizializzo l'lcd e stampo un messaggio di benvenuto
lcd.begin(16, 2);
lcd.clear();
lcd.print("NOCS CLUB");
delay(2000);
lcd.clear();
lcd.setCursor(0,0);
lcd.print("Avvia il Timer:");
}



void loop() {
  
  
if(prova==4)
disarmaBomba();

if (lcd.button()==KEYPAD_UP && stato==0) {
  armaBomba(); 
lcd.clear();
lcd.setCursor(0,0);
lcd.print("Immetti il");
lcd.setCursor(0,1);
lcd.print("Codice: ");
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


if(stato!=DISARMED && timer<0){
  esplosioneBomba();
  stato=DISARMED;
}


if(stato==ARMED){
contatore();
buzz();
}


}

void armaBomba() {
     stato=ARMED;
     previousMillis = millis();
 digitalWrite(LedRosso, HIGH);
 digitalWrite(LedVerde, LOW);
   }
   
 void disarmaBomba() {
   stato=DISARMED;
   digitalWrite(LedRosso, LOW);
    digitalWrite(LedVerde, HIGH);
 }
   
   
void contatore(){
  
unsigned long currentMillis = millis();


if(currentMillis - previousMillis > interval) {
    previousMillis = currentMillis;   
  
sprintf(buf, "%04d", timer);
Serial.print(buf);
if(timer>=0 && stato==ARMED){
  timer--; 
}
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
timer=0;
lcd.clear();
lcd.setCursor(0,0);
lcd.print("     BOOM!!!");
for(i=0;i<30;i++){
  
   digitalWrite(LedRosso, LOW);
   digitalWrite(LedVerde, HIGH);
   tone(buzzPin, 4000, 100);
   delay(100);
   digitalWrite(LedVerde, LOW);
   digitalWrite(LedRosso, HIGH);
   tone(buzzPin, 3000, 100);
  delay(100);
}
}



void buzz(){
  
unsigned long currentMillis = millis();


if(currentMillis - buzzpreMillis > 1010) {
    buzzpreMillis = currentMillis;   

if(timer>0 && stato==ARMED){
  tone(buzzPin, 4000, 200);
}
  }
  
}
