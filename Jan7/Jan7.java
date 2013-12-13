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

public class Jan7 extends PApplet {


int ballCount = 7;
int dotCount = 2000;
int tmpColor;
Ball[] balls= new Ball[ballCount];
Ball[] dots = new Ball[dotCount];
int nextBall;
public void setup(){  
  size(800,800);
  smooth();
  noStroke();
  for (int i=0; i < ballCount;i++){
    //balls[i] = new Ball(i*10, height/2, color(255,random(255),random(255)), int(random(10)+10), i+0.1,20-i);
    balls[i] = new Ball(random(0,width-20), random(0,height-20), color(255,random(255),random(255),40), PApplet.parseInt(random(10)+10), random(-2,2),random(-2,2));
  }
  for (int i=0; i < dotCount;i++){

    dots[i] = new Ball(random(0,width-20), random(0,height-20), color(255,random(255),random(255)), 1, random(-2,2),random(-2,2));
  }
}
public void draw() {
  //
  // background(100);
  fill(0,10);
  rect(0,0,width,height);
  if(frameCount%10==0){
    float yV = random(-1,1);
    float xV = random(-1,1);

    for (int i=0; i < ballCount;i++){
      balls[i].xVel = balls[i].xVel + random(-1,1);
      balls[i].yVel = balls[i].yVel + random(-1,1);

      if(balls[i].xVel > 3){ 
        balls[i].xVel =3;
      }
      if(balls[i].xVel < -3){ 
        balls[i].xVel =-3;
      }
      if(balls[i].yVel > 3){ 
        balls[i].yVel =3;
      }
      if(balls[i].yVel < -3){ 
        balls[i].yVel =-3;
      }
    }
  }

  for (int i=0; i < ballCount;i++){
    if (i+1 == ballCount){
      nextBall = 0;
    }
    else{
      nextBall = i+1;
    }

    noStroke();
    balls[i].update();
    if(balls[i].x - balls[nextBall].x < 10){
      tmpColor = balls[i].myColor;
      
       balls[i].myColor = balls[nextBall].myColor; 
       balls[nextBall].myColor = tmpColor; 
    }
    stroke(balls[i].myColor,255);
    //line(balls[i].x+balls[i].size/2,balls[i].y+balls[i].size/2,balls[nextBall].x+balls[nextBall].size/2,balls[nextBall].y+balls[nextBall].size/2);

  }
  noStroke();
  for (int i=0; i < dotCount;i++){
    dots[i].xVel = dots[i].xVel + random(-1,1);
    dots[i].yVel = dots[i].yVel + random(-1,1);
    if(dots[i].xVel > 3){ 
      dots[i].xVel =3;
    }
    if(dots[i].xVel < -3){ 
      dots[i].xVel =-3;
    }
    if(dots[i].yVel > 3){ 
      dots[i].yVel =3;
    }
    if(dots[i].yVel < -3){ 
      dots[i].yVel =-3;
    }

    fill(dots[i].myColor);
    dots[i].update();
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
    fill(this.myColor);
    
    ellipseMode(CORNER);
    ellipse(x, y, size, size);
  }
}

  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#FFFFFF", "Jan7" });
  }
}
