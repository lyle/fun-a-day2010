import processing.core.*; 
import processing.xml.*; 

import seltar.motion.*; 

import java.applet.*; 
import java.awt.*; 
import java.awt.image.*; 
import java.awt.event.*; 
import java.io.*; 
import java.net.*; 
import java.text.*; 
import java.util.*; 
import java.util.zip.*; 
import java.util.regex.*; 

public class Jan1 extends PApplet {



Motion m, n;
float Angle, AngleN = random(TWO_PI), Strokeweight = 1;
int numberOfLines = 0;
  int startX, startY, stopX, stopY;
boolean  starting = true;
  PGraphics pg;
  
  
public void setup()
{
  size(800,800);  
  m = new Motion(width/2,height/2);
  n = new Motion(width/2,height/2);
  smooth();
  background(0);  
  stroke(255);
  pg = createGraphics(width, height, P2D);
}
public void mousePressed() {
  if (starting) {
   startX = mouseX;
   startY = mouseY;
   initLine();
  }
}
public void mouseReleased() {
  startDrawing();
  numberOfLines = PApplet.parseInt(random(1,400));
}
public void initLine () {
   m.setX(startX);
   m.setY(startY);
   starting = false;
}

public void startDrawing () {
  stopX = mouseX;
  stopY = mouseY;
}

public void draw()
{
  if ( numberOfLines > 0 ){
    if ( PApplet.parseInt(random(0,100)) == 42 ) {
       stopX = PApplet.parseInt(random(width));
       stopY = PApplet.parseInt(random(height));
    }
    if ( PApplet.parseInt(random(0,100)) == 42 ) {
      pg.beginDraw();
      pg.background(0,1);
      pg.endDraw();
      image(pg, 0, 0);
    }
    
    if ( PApplet.parseInt(random(0,1000)) == 42 ) {
      startX = PApplet.parseInt(random(width));
      startY = PApplet.parseInt(random(height));
      initLine();
    }
      
    m.followTo(stopX,stopY); 
    Angle = m.getAngle();
    if (m.getDistanceTo(stopX,stopY) > 30) {
      Angle += radians(random(-15,15));
    }
    m.setAngle(Angle);
  
    Strokeweight += random(-0.5f,0.5f);
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

  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#FFFFFF", "Jan1" });
  }
}
