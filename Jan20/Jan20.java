import processing.core.*; 
import processing.xml.*; 

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

public class Jan20 extends PApplet {

int mySize;

public void setup(){
  size(640,640,P2D);
  stroke(100,100,0);
  strokeWeight(1);
  background(0);
  noFill();
  mySize = 10;
}

public void draw(){
  ellipse(mouseX,mouseY,mySize,mySize);
  if (keyPressed) {
    background(0);
  }

}
public void mouseClicked(){
 mySize = PApplet.parseInt(random(3,12)); 
}

public void mouseDragged(){
  stroke(PApplet.parseInt(random(100,255)), PApplet.parseInt(random(100,255)), PApplet.parseInt(random(100,255)));

}



  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#FFFFFF", "Jan20" });
  }
}
