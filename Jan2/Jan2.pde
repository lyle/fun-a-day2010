
import seltar.motion.*;
Motion m, n;
float Angle, AngleN = random(TWO_PI), Strokeweight = 1;
int numberOfLines = 0;
  int startX, startY, stopX, stopY;
boolean  starting, weLeft = true;
  PGraphics pg;
  int inMiddle = 0;
  
void setup()
{
  size(800,800);  
  m = new Motion(width/2,height/2);
  n = new Motion(width/2,height/2);
  smooth();
  background(0);  
  stroke(255);
  pg = createGraphics(width, height, P2D);
}
void mousePressed() {
  if (starting) {
   startX = mouseX;
   startY = mouseY;
   initLine();
  }
}
void mouseReleased() {
  startDrawing();
  numberOfLines = int(random(1,400));
}
void initLine () {
   m.setX(startX);
   m.setY(startY);
   starting = false;
}

void startDrawing () {
  stopX = mouseX;
  stopY = mouseY;
}

void draw()
{
  if ( numberOfLines > 0 ){
    if ( int(random(0,100)) == 42 ) {
      pg.beginDraw();
      pg.background(0,1);
      pg.endDraw();
      image(pg, 0, 0);
    }
    
    Angle = m.getAngle();
    Angle += radians(random(-30,30));
    m.setAngle(Angle);
  
    Strokeweight += random(-0.5,0.5);
    Strokeweight = abs(Strokeweight);
    if (Strokeweight >= 2) {
      Strokeweight = 2;
    }
    if (weLeft & inMiddle < 100) {
      m.springTo(400,400);
    }

    if (m.getDistanceTo(width/2, height/2) < 30 ) {
       inMiddle ++; 
    } 
    
    if (m.getX() > width | m.getX() < 0 | m.getY() > height | m.getY() < 0) {
      inMiddle = 0;
      weLeft = true;
    }
//    m.wrap(0,0,width,height);
    
    stroke(200);
    strokeWeight(Strokeweight);
    m.setVelocity(random(1,4));
  
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
}
