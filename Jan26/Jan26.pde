import seltar.motion.*;
Motion m;

PFont font;
PVector location,velocity;

float userTimeOut = 0.25*60*60; //(15 seconds)
float userTickle = userTimeOut;
boolean userGone = false;
float targetX, targetY;

void setup(){
  size(640,640,P2D);
  font = loadFont("BodoniSvtyTwoITCTT-Book-96.vlw");
  textFont(font, 96);
  fill(0);
  m = new Motion(width/2,height/2);
  location = new PVector(width/2,height/2);

}
void mouseMoved(){
  userGone = false;
  userTickle = userTimeOut;
  
}

void draw(){


  colorMode(RGB,100);
  fill(100,10);
  rect(0,0,width,height);
  
  userTickle --;
  if (userTickle <0){
    userGone = true;
    targetX = random(width)-36;
    targetY = random(height)+36;
 
    userTickle = random(.01,.1)*60*60;
  }
  else if(!userGone){
    targetX = mouseX-36;
    targetY = mouseY+36;
  }
  m.springTo(int(targetX),int(targetY));
  //background(255);
  m.move();
  colorMode(HSB,100);

  fill(color((frameCount + 255)%100,100,100));
  //location.x -= (location.x - mouseX) *.8;
  //location.y -= (location.y - mouseY) *.8;
  text("26", m.getX(),m.getY());
}

