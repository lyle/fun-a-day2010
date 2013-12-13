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

public class Jan26 extends PApplet {


Motion m;

PFont font;
PVector location,velocity;

float userTimeOut = 0.25f*60*60; //(15 seconds)
float userTickle = userTimeOut;
boolean userGone = false;
float targetX, targetY;

public void setup(){
  size(640,640,P2D);
  font = loadFont("BodoniSvtyTwoITCTT-Book-96.vlw");
  textFont(font, 96);
  fill(0);
  m = new Motion(width/2,height/2);
  location = new PVector(width/2,height/2);

}
public void mouseMoved(){
  userGone = false;
  userTickle = userTimeOut;
  
}

public void draw(){


  colorMode(RGB,100);
  fill(100,10);
  rect(0,0,width,height);
  
  userTickle --;
  if (userTickle <0){
    userGone = true;
    targetX = random(width)-36;
    targetY = random(height)+36;
 
    userTickle = random(.01f,.1f)*60*60;
  }
  else if(!userGone){
    targetX = mouseX-36;
    targetY = mouseY+36;
  }
  m.springTo(PApplet.parseInt(targetX),PApplet.parseInt(targetY));
  //background(255);
  m.move();
  colorMode(HSB,100);

  fill(color((frameCount + 255)%100,100,100));
  //location.x -= (location.x - mouseX) *.8;
  //location.y -= (location.y - mouseY) *.8;
  text("26", m.getX(),m.getY());
}


  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#FFFFFF", "Jan26" });
  }
}
