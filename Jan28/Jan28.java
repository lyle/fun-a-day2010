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

public class Jan28 extends PApplet {



Motion m, n;
float Angle, AngleN = random(TWO_PI), Strokeweight = 1;
int numberOfLines = 0;
  int startX, startY, stopX, stopY;
boolean  starting = true;
  PGraphics pg;
  
float userTimeOut = 0.25f*60*60; //(15 seconds)
float userTickle = userTimeOut;
  
public void setup()
{
  size(640,640);  
  m = new Motion(width/2,height/2);
  n = new Motion(width/2,height/2);
  smooth();
  background(0);  
  stroke(255);
  pg = createGraphics(width, height, P2D);
}

public void mouseMoved(){
  userTickle = userTimeOut;
}

public void emulateUser(){

   m.setX(PApplet.parseInt(random(width)));
   m.setY(PApplet.parseInt(random(height)));
  startDrawing(PApplet.parseInt(random(width)),PApplet.parseInt(random(height)));
  userTickle = random(.01f,.25f)*60*60;
}
public void mousePressed() {
  if (starting) {
   startX = mouseX;
   startY = mouseY;
   initLine();
  }
}
public void mouseReleased() {
  startDrawing(mouseX,mouseY);
}
public void initLine () {
   m.setX(startX);
   m.setY(startY);
   starting = false;
}

public void startDrawing (int _stopX,int _stopY) {
  stopX = _stopX;
  stopY = _stopY;
  numberOfLines = PApplet.parseInt(random(1,400));
}

public void draw()
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
  startX += 1;
}

  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#FFFFFF", "Jan28" });
  }
}
