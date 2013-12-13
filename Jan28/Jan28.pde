
import seltar.motion.*;
Motion m, n;
float Angle, AngleN = random(TWO_PI), Strokeweight = 1;
int numberOfLines = 0;
  int startX, startY, stopX, stopY;
boolean  starting = true;
  PGraphics pg;
  
float userTimeOut = 0.25*60*60; //(15 seconds)
float userTickle = userTimeOut;
  
void setup()
{
  size(640,640);  
  m = new Motion(width/2,height/2);
  n = new Motion(width/2,height/2);
  smooth();
  background(0);  
  stroke(255);
  pg = createGraphics(width, height, P2D);
}

void mouseMoved(){
  userTickle = userTimeOut;
}

void emulateUser(){

   m.setX(int(random(width)));
   m.setY(int(random(height)));
  startDrawing(int(random(width)),int(random(height)));
  userTickle = random(.01,.25)*60*60;
}
void mousePressed() {
  if (starting) {
   startX = mouseX;
   startY = mouseY;
   initLine();
  }
}
void mouseReleased() {
  startDrawing(mouseX,mouseY);
}
void initLine () {
   m.setX(startX);
   m.setY(startY);
   starting = false;
}

void startDrawing (int _stopX,int _stopY) {
  stopX = _stopX;
  stopY = _stopY;
  numberOfLines = int(random(1,400));
}

void draw()
{
  
  
  userTickle --;
  if (userTickle <0){
    emulateUser();
  }
  if ( numberOfLines > 0 ){

    m.followTo(stopX,stopY); 
    Angle = m.getAngle();
    if (m.getDistanceTo(stopX,stopY) > 30) {
      Angle += radians(random(-35,35));
    }
    m.setAngle(Angle);
  
    Strokeweight += random(-0.5,0.5);
    Strokeweight = abs(Strokeweight);
    if (Strokeweight >= 1) {
      Strokeweight = 1;
    }
    m.wrap(0,0,width,height);
    
    stroke(200);
    strokeWeight(Strokeweight);
    m.setVelocity(random(4,10));
  
   if (m.getDistanceTo(stopX,stopY) > 5) {
     m.move();
     line(m.getPX(),m.getPY(),m.getX(),m.getY());
   } else {
    // numberOfLines --;
     starting = true;
     m.setX(startX);
     m.setY(startY);
     m.followTo(stopX,stopY); 
     m.move();
   }
  }
  startX += 1;
}
