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

public class Jan10 extends PApplet {



int lineCount = 1000;
Motion[] Lines = new Motion[lineCount];
Motion focus;
int yummyColor;
int[] Strokecolor = new int[lineCount];
float[] Angles = new float[lineCount];
float[] Strokeweights = new float[lineCount];
int[] CurrentTarget = new int[lineCount];
//random(TWO_PI)
float focusAngle;
float Strokeweight = 1;
int numberOfLines = 0;
int startX, startY, stopX, stopY;
boolean  starting = true;
PGraphics pg;
int yummyDeath, yummyX, yummyY;
boolean  yummyExistis = false;
int yummyDeathAge = 400;
int targetCount = 4;
Ball[] Targets = new Ball[targetCount];

public void setup()
{
  size(640,640);  
  for (int i=0; i < lineCount; i++){
    Lines[i] = new Motion(random(0,width), random(0,height));
    Lines[i].wrap(0,0,width,height);
    Angles[i] = radians(random(360));
    Lines[i].setVelocity(random(1,3));
    Strokecolor[i] = color(200);
    CurrentTarget[i] = PApplet.parseInt(random(0,targetCount));
    Lines[i].setDamping(0.3f);
  }
  for (int i=0; i < targetCount; i++){
    
    Targets[i] = new Ball(random(0,width), random(0,height),  color(random(100,200), random(100,200), random(0,200)), 2, random(-1,1), random(-1,1));
    //Targets[i].setVelocity(random(1,3));
    //Targets[i].springTo(random(0,width),random(0,height));
    //Targets[i].wrap(0,0,width,height);
  }
  focus = new Motion(random(0,width), random(0,height));
  smooth();
  background(0);  
  stroke(255);
  pg = createGraphics(width, height, P2D);
}
public void mousePressed() {

  yummyX = mouseX;
  yummyY = mouseY;
    for (int i=0; i < lineCount; i++){
      CurrentTarget[i] = PApplet.parseInt(random(0,targetCount));
      
    }
    for (int i=0; i < targetCount; i++){
       Targets[i].myColor = color(random(100,200), random(100,200), random(0,200));
    }
  //Targets[int(random(0,targetCount))].springTo(mouseX,mouseY);

}
public void mouseReleased() {
}
public void initYummy () {
  if (starting & !yummyExistis) {
    yummyExistis = true;
    yummyColor = color(random(100,200), random(100,200), random(0,200));
    yummyDeathAge = 400;
    if (random(1,100) >= 95) {
      yummyColor = color(0); 
      yummyDeathAge = 1000;
    }


  }
}

public void startDrawing () {



}

public void draw()
{

  //pg.beginDraw();
  fill(0,10);
  rect(0,0,height,width);

  //pg.background(0,1);
  //pg.endDraw();
  //image(pg, 0, 0);
  //if (! (frameCount % 100 == 0)) {
  strokeWeight(5);
  fill(yummyColor);
  stroke(yummyColor);
  focus.followTo(yummyX,yummyY);
  if (random(0,100) > 90) {
    focus.setAngle(focusAngle += radians(random(-2,2  )));
  }
  //   focus.wrap(0,0,width,height);
  focus.move();
  if(focus.getX() > width || focus.getY() > height || focus.getY()<0 || focus.getX()<0) {
    //focus.springTo(height/2,width/2);
    //focus.move();
    yummyX=height/2;
    yummyY=width/2;
    //       focus.setX(width/2);
  }
  // ellipse(focus.getX(),focus.getY(), 10,10);
  yummyDeath ++;
  if (random(0,100) > 99) {
    yummyColor = color(random(100,200), random(100,200), random(0,200));
    yummyX = PApplet.parseInt(random(0, width));
    yummyY = PApplet.parseInt(random(0, height));
    initYummy();
  }
  //  if (yummyDeath > yummyDeathAge) {
  //    yummyDeath = 0;
  //    yummyExistis = false; 
  //  }


  for (int i=0; i < targetCount; i++){
//    Targets[i].wrap(0,0,width,height);
    noStroke();
    Targets[i].update();
//    ellipse(Targets[i].getX(),Targets[i].getY(),2,2);
      
  }
  for (int i=0; i < lineCount; i++){
    Strokeweights[i] += random(-.5f,.5f);
    Strokeweights[i] = abs(Strokeweights[i]);
    if (Strokeweights[i] >= 2) {
      Strokeweights[i] = 2;
    }
    Lines[i].setDamping(random(0,1));
    Lines[i].setSpring(random(0,1));
    Lines[i].setAngle(Angles[i] += radians(random(-20,20  )));
    Lines[i].wrap(-100,-100,width+100,height+100);
    //   if (yummyExistis & Strokecolor[i] != yummyColor) {
    //     Lines[i].springTo(focus.getX(), focus.getY());
         if (Lines[i].getDistanceTo(Targets[CurrentTarget[i]].x,Targets[CurrentTarget[i]].y) < 50 ) {
           Strokecolor[i] = Targets[CurrentTarget[i]].myColor;
         }
    //   }
    Lines[i].springTo(PApplet.parseInt(Targets[CurrentTarget[i]].x),PApplet.parseInt(Targets[CurrentTarget[i]].y));
    noStroke();
    fill(Strokecolor[i]);
    Lines[i].move();
    ellipse(Lines[i].getPX(),Lines[i].getPY(),Strokeweights[i],Strokeweights[i]);
    //line(Lines[i].getPX(),Lines[i].getPY(),Lines[i].getX(),Lines[i].getY());
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
    
   // ellipseMode(CORNER);
   // ellipse(x, y, size, size);
  }
}

  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#FFFFFF", "Jan10" });
  }
}
