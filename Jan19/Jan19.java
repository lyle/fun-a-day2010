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

public class Jan19 extends PApplet {


int ballCount = 11;
int tmpColor;
Ball[] balls= new Ball[ballCount];
Palette p;
int myColor;

public void setup(){
  size(640,640, P2D);
  p=new Palette("poetry.cs");
  int cl=p.colors[0];

    background(p.colors[PApplet.parseInt(random(0,p.colors.length))]);
  for (int i=0; i < ballCount;i++){
    //balls[i] = new Ball(i*10, height/2, color(255,random(255),random(255)), int(random(10)+10), i+0.1,20-i);
    balls[i] = new Ball(random(0,width-20), random(0,height-20), color(255,random(255),random(255),40),
    PApplet.parseInt(random(5,35)), random(-20,20),random(-20,20));
  }
}

public void draw(){
  if(  mousePressed ){
    background(p.colors[PApplet.parseInt(random(0,p.colors.length))]);
  }


  for (int i=0; i < ballCount;i++){


    noStroke();
    balls[i].update();
  }
}


class Ball {
  int size;
  float x, y;
  int myColor;
  float xVel=2.0f, yVel=2.8f;
  int xDir=1, yDir=1;

  Ball(float x, float y, int myColor, int size){
    this.x = x;
    this.y = y;
    this.myColor = myColor;
    this.size = size;
  }
  Ball(float x, float y, int myColor, int size, float xVel, float yVel){
    this.xVel = xVel;
    this.yVel = yVel;
    this.x = x;
    this.y = y;
    this.myColor = myColor;
    this.size = size;
  }
  

  public void update() {
    x = x + (xVel * xDir);
    y = y + (yVel * yDir);
    if (x > width-size || x < 0) {
      xDir = xDir * -1;
    }
    if (y > height-size || y < 0) {
      yDir *= -1;
    }
   // fill(this.myColor);
    noFill();
    strokeWeight(1);
    stroke(this.myColor);
    ellipseMode(CORNER);
    ellipse(x, y, size, size);
    noStroke();
   
    
  }
}
class Palette{
  int[] colors;
  Palette(String file){
    byte[] b=loadBytes(file);
    if(file.endsWith(".cs")){
      createPalette(b,8,26,b[2]&0xff);
    }
    else if (file.endsWith(".act")){
      createPalette(b,0,3,255);
    }
  }
  Palette(String file, int length){
    byte[] b=loadBytes(file);
    if(file.endsWith(".cs")){
      createPalette(b,8,26,length);
    }
    else if (file.endsWith(".act")){
      createPalette(b,0,3,length);
    }
  }
  public void createPalette(byte[] b, int start, int steps, int length){
    colors=new int[length];
    int cnt=0;
    for(int i=0 ;i<length;i++){
      colors[i]=0xff<<24|b[start+i*steps]<<16|b[start+i*steps+1]<<8|b[start+i*steps+2];
    }
  }
}

  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#FFFFFF", "Jan19" });
  }
}
