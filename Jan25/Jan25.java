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

public class Jan25 extends PApplet {





float userTimeOut = 0.25f*60*60; //(15 seconds)
float userTickle = userTimeOut;
float endTargetX, endTargetY;
boolean userGone = false;

Motion m;
int numSegments = 80;
float[] x = new float[numSegments];
float[] y = new float[numSegments];
float[] angle = new float[numSegments];
float segLength = 20;
float targetX, targetY;

public void setup() {
  size(640, 640);
  smooth(); 
  strokeWeight(20.0f);
  m = new Motion(width/2,height/2);
  x[x.length-1] = 0;     // Set base x-coordinate
  y[x.length-1] = 0;  // Set base y-coordinate
}



public void mouseMoved(){
  userTickle = userTimeOut;
  userGone = false;
}
public void mouseClicked(){
 targetX=mouseX;
 targetY=mouseY; 
}
public void draw() {
  
    userTickle --;
  if (userTickle <0){
    endTargetX = random(width);
    endTargetY = random(height);
    userGone = true;
  } else if(!userGone){
    endTargetX = mouseX;
    endTargetY = mouseY;
  }
  noStroke();
  fill(0,10);
  rect(0,0,width,height);
  stroke(255);
  
  m.springTo(endTargetX,endTargetY);
  m.move();
  //ellipse(m.getX(),m.getY(),2,20);
  
  reachSegment(0, m.getX(), m.getY());
  for(int i=1; i<numSegments; i++) {
    reachSegment(i, targetX, targetY);
  }
  for(int i=x.length-1; i>=1; i--) {
    positionSegment(i, i-1);  
  } 
  for(int i=0; i<x.length; i++) {
    stroke(0,100,100+i*20);
    segment(x[i], y[i], angle[i], (i+1)); 
  }
}

public void positionSegment(int a, int b) {
  x[b] = x[a] + cos(angle[a]) * segLength;
  y[b] = y[a] + sin(angle[a]) * segLength; 
}

public void reachSegment(int i, float xin, float yin) {
  float dx = xin - x[i];
  float dy = yin - y[i];
  angle[i] = atan2(dy, dx);  
  targetX = xin - cos(angle[i]) * segLength;
  targetY = yin - sin(angle[i]) * segLength;
}

public void segment(float x, float y, float a, float sw) {
  strokeWeight(sw);
  pushMatrix();
  translate(x, y);
  rotate(a);
  line(0, 0, segLength, 0);
  popMatrix();
}


  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#FFFFFF", "Jan25" });
  }
}
