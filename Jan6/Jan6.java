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

public class Jan6 extends PApplet {


int threadCount = 40;
Motion[] Threads = new Motion[threadCount];
int[] ThreadColors = new int[threadCount];
float[] ThreadAngles = new float[threadCount];
float[] ThreadWidth = new float[threadCount];
int      pixelPointer;
float tmpX, tmpY,tmpPX, tmpPY;
Motion NextThread;

public void setup()
{
  size(800,800);
  frameRate(60); 
  for (int i=0; i < threadCount; i++){
    Threads[i] = new Motion(random(0,width), random(0,height));
    Threads[i].setConstant(1000);
    ThreadAngles[i] = radians(random(360));
    Threads[i].setVelocity(1);
    ThreadColors[i] = color(random(100,200),0,0);

  }  
  smooth();
  background(0);
  stroke(255);
} 
public void mousePressed() {
  background(0);
}
public void checkLocation(Motion item){
  if ( item.getX() > width ) item.setX(width-100);
  if ( item.getX() < 0 ) item.setX(100);
  if ( item.getY() > height ) item.setY(height-100);
  if ( item.getY() < 0 ) item.setY(100); 
}
public void draw(){
  stroke(0);
  fill(0,10);
  if (frameCount % 10 == 0){
  rect(0,0,width,height);
  }
  for (int i=0; i < threadCount; i++){
    Threads[i].setAngle(ThreadAngles[i] += radians(random(-1,1  )));
    Threads[i].wrap(0,0,width, height);
    //Threads[i].wrap(0,0,width,height);
    strokeWeight(2);

    if (i+1==threadCount) {
      NextThread = Threads[0];
    }
    else{
      NextThread = Threads[i+1];
    }

    ThreadWidth[i] = 1;//abs(ThreadWidth[i] + random(-0.5,0.5));

    //ThreadWidth[i] = abs(ThreadWidth[i] + noise(-0.5,0.5));


    ThreadColors[i] = color(random(100,200),random(100,200),random(100,200));


    Threads[i].move();
    float noiseScale = 2;
    tmpPX = Threads[i].getPX();
    tmpPY = Threads[i].getPY();
 float noiseVal = noise(mouseX*noiseScale, 
                            mouseY*noiseScale);
    tmpX = Threads[i].getX()+noiseVal;
    tmpY = Threads[i].getY()+random(-15,15);


    strokeWeight(1);
    stroke(100,255,255,100);
    line(tmpPX, tmpPY, tmpX, tmpY);

    stroke(ThreadColors[i]);
    strokeWeight(ThreadWidth[i]);

    //ellipse(tmpX,tmpY,ThreadWidth[i],ThreadWidth[i]);

  }
}



  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#FFFFFF", "Jan6" });
  }
}
