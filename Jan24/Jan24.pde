import seltar.motion.*;
Motion m;

//automated draw parts
float userTimeOut = 0.25*60*60; //(15 seconds)
float userTickle = userTimeOut;
float targetX, targetY, targetXmod, targetYmod;
boolean userGone = false;
int makeRound = 0;

void setup(){
  size(640,640,P2D);
  m = new Motion(width/2,height/2);
  fill(230,230,255);
  noStroke();
  background(0);
}

void mouseMoved(){
  userTickle = userTimeOut;
  userGone = false;
}

void mouseClicked(){
  background(0); 
}

void draw(){

  userTickle --;
  if (userTickle <1){
    targetX = random(40,width-40);
    targetY = random(40,height-40);
    userGone = true;
    makeRound = 60;
    userTickle = random(.01,.25)*60*60;
    targetXmod = targetX + random(-30,30);
    targetYmod = targetY + random(-30,30);
  } 
  else if(!userGone){
    targetX = mouseX;
    targetY = mouseY;
  } 
  if(makeRound > 0){
    makeRound --;
    if(makeRound<1) {
      targetX = targetXmod;
      targetY = targetYmod;
      makeRound = 60;
    }
  }

  m.springTo(targetX,targetY);


  m.move();
  ellipse(m.getX(),m.getY(),2,2);
}


