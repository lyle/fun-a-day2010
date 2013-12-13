
import seltar.motion.*;
Motion m, n;
float Angle, AngleN = random(TWO_PI), Strokeweight = 1;
int numberOfLines = 0;
  int startX, startY, stopX, stopY;
boolean  starting = true;
  PGraphics pg;
  
  
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
       stopX = int(random(width));
       stopY = int(random(height));
    }
    if ( int(random(0,100)) == 42 ) {
      pg.beginDraw();
      pg.background(0,1);
      pg.endDraw();
      image(pg, 0, 0);
    }
    
    if ( int(random(0,1000)) == 42 ) {
      startX = int(random(width));
      startY = int(random(height));
      initLine();
    }
      
    m.followTo(stopX,stopY); 
    Angle = m.getAngle();
    if (m.getDistanceTo(stopX,stopY) > 30) {
      Angle += radians(random(-15,15));
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
}
