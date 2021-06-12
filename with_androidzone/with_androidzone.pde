import processing.serial.*;

Serial myPort;

float prev_x;
int prev_zone;
float rectSize = 80;
PFont f;
float y = 2;
int mul=1;
float flag = 0;
float x = 0;
int score;
String final_statement;
String data;
int swipe;
int zone;
int zch;
PImage i1;
PImage i2;
PImage i3;

void setup(){
  i1 = loadImage("Desert.jpg");
  i2 = loadImage("Dungeon.jpg");
  i3 = loadImage("Forest.jpg");
  score = 0;
  background(190);
  size(1280,720);
  f = createFont("Bahnschrift",20);
  randomSeed(millis());
  x = int(random(0,3));
  mul=1;
  
  zch=int(random(0,3));      
  prev_x = -1;
  prev_zone=-1;

  flag = 0;
  String portName = "COM3"; 
  myPort = new Serial(this, portName, 9600);
  textSize(10);
  zcheck();
}

void zcheck(){
  if(zch==0){
    //text("ZONE 1",50,80);
    image(i1,0,0,1280,720);
    fill(#EDD64F);
  }
  else if(zch==1){
    //text("Zone 2",50,80);
    image(i2,0,0,1280,720);
    fill(#312C0F);
  }
  else if(zch==2){
    //text("Zone 3",50,80);
    image(i3,0,0,1280,720); 
    fill(#2E5A28);
  }
}

void reset(){
  background(190);
  flag = 0;
  rectSize = 80;
  while(prev_x == x || x==swipe)
  x = int(random(0,3));
  if (mul==2){
    zch = int(random(0,3));
  }
  else if (mul==1)
    if (score%50==0)
  {
      while(zch==prev_zone)  
      zch = int(random(0,3));
  }
  
  zcheck();
}

void increaseSize(){
    stroke(0);
    rectMode(CENTER);
    fill(255);
    rect(640,360,rectSize,rectSize,20,20,20,20);
    if (score/10<10)
    
    rectSize = rectSize+1;
    else
    rectSize = rectSize + 2;
    if (rectSize > 450) {
      flag = 2;
    }
}

void draw(){
    if(myPort.available()>0)
    serialEvent(myPort);
    prev_x = x;
    prev_zone=zch;
    if (flag==3){
      delay(3000);
      reset();
      score = 0;
    }
    
    if(flag==2){
     background(190);
     fill(0, 102, 153);
     text("SAXON WARLORDS HAVE OVERPOWERED YOU!", 240,360);
     flag = 3;
     final_statement = "SCORE: "+(score);
     text(final_statement,570,400);
     text("STARTING NEW GAME...",450,440);
    }
    
    else if (flag == 1){
      background(150);
      reset();
    }
    
    else {
      increaseSize();
    }
    
    if (flag != 2 && flag!=3){
    textFont(f,35);
    fill(255);
    textSize(70);
    text("SCORE: "+score, 70, 80);
    text("MOVE TO ZONE: " + (zch+1),700,80);
    fill(0, 102, 153);
    textSize(40);
    if(x==1){
      text("UP",620,360);
    }
    else if(x==2){
      text("RIGHT",588,360);
    }
    else{
    text("LEFT",605,360);
    }}
}
  
void keyPressed(){
  if(keyCode==RIGHT)
  mul = 2;
  if(keyCode==DOWN)
  exit();
  if(keyCode==LEFT)
  mul = 1;
}

void serialEvent(Serial myPort){
    data = myPort.readStringUntil('\n');
    if (data!=null)
    {
    swipe = data.charAt(0)-48;
    zone = data.charAt(1)-48;
  if (x==1){
    if (swipe == 1){
      if((zch+1)==zone){
      flag = 1;
      score += 10;
    }}
          
    else {
      flag = 2;
    }
  }
  else if (x==2){
    if (swipe == 2){
      if((zch+1)==zone){
      flag = 1;
      score += 10;
    }}
    else {
      flag = 2;
    }
  }
  else if (x==0){
    if (swipe == 0){
      if((zch+1)==zone){
      flag = 1;
      score += 10;
  }}
    else {
      flag = 2;
    }
}
}
}
