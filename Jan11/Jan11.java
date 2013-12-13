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

public class Jan11 extends PApplet {

//import processing.opengl.*;


int lineCount = 2000;
Motion[] Lines = new Motion[lineCount];
int[] Strokecolor = new int[lineCount];
float[] Angles = new float[lineCount];
float[] Strokeweights = new float[lineCount];
int[] CurrentTarget = new int[lineCount];
float Strokeweight = 1;
boolean backgroundInverted = false;


int targetCount = 3;
Ball[] Targets = new Ball[targetCount];

public void setup()
{
  size(640,640, P2D);  
  for (int i=0; i < lineCount; i++){
    Lines[i] = new Motion(random(0,width), random(0,height));
    Lines[i].wrap(0,0,width,height);
    Angles[i] = radians(random(360));
    Lines[i].setVelocity(random(3,6));
    Strokecolor[i] = color(200);
    CurrentTarget[i] = PApplet.parseInt(random(0,targetCount));
    Lines[i].setDamping(0.3f);
  }
  for (int i=0; i < targetCount; i++){
    Targets[i] = new Ball(color(random(100,200), random(100,200), random(0,200)), 20, random(-3,3), random(-3,3));
    Targets[i].setBounds(50,50,width-50,height-50,true);
    Targets[i].beInvisible = true;
  }

  smooth();
  background(0);  

}
public void mousePressed() {

  for (int i=0; i < lineCount; i++){
    CurrentTarget[i] = PApplet.parseInt(random(0,targetCount));
  }
  for (int i=0; i < targetCount; i++){
    Targets[i].setVelocity(random(2,4));
    Targets[i].myColor = color(random(100,255), random(100,255), random(100,255));
  }
  if (backgroundInverted)
  { 
    backgroundInverted = false;
  }
  else{
    backgroundInverted = true;
  }
}

public void draw()
{
  if (backgroundInverted) {
    background(255);
  }else{
    background(0);
  }


  for (int i=0; i < targetCount; i++){
    noStroke();
    Targets[i].update();
  }
  for (int i=0; i < lineCount; i++){
    Strokeweights[i] += random(-1,1);
    Strokeweights[i] = abs(Strokeweights[i]);
    if (Strokeweights[i] >= 10) {
      Strokeweights[i] = 10;
    }
    Lines[i].setDamping(random(1,1));
    Lines[i].setSpring(random(4,4));
    Lines[i].setAngle(Angles[i] += radians(random(-30,30  )));
    //Lines[i].wrap(-100,-100,width+100,height+100);
    if (Lines[i].getDistanceTo(Targets[CurrentTarget[i]].getX(),Targets[CurrentTarget[i]].getY()) < 50 ) {
      Strokecolor[i] = Targets[CurrentTarget[i]].myColor;
    }
    Lines[i].springTo(PApplet.parseInt(Targets[CurrentTarget[i]].getX()),PApplet.parseInt(Targets[CurrentTarget[i]].getY()));
    noStroke();
    strokeWeight(1);
    fill(Strokecolor[i],100);
    Lines[i].move();
    ellipse(Lines[i].getPX(),Lines[i].getPY(),Strokeweights[i],Strokeweights[i]);
    stroke(Strokecolor[i],100);
    if (Lines[i].v.getVelocity() > 2) {
      line(Lines[i].getPX(),Lines[i].getPY(),Lines[i].getX(),Lines[i].getY());
    }
    noStroke();
  }  
}







class Ball extends Motion {
  float mySize;
  int myColor;
  int bounceXmin;
  int bounceYmin;
  int bounceXmax;
  int bounceYmax;
  float _x;
  float _y;
  boolean beInvisible;
  

  Ball(int myColor, int _size){
    super(random((_size)/2, width - (_size/2)),random((_size)/2, height - (_size/2)));
    //  _x = 
    //  _y =  ;
    this.mySize = _size;
    this.myColor = myColor;
    this.bounceXmin = this.bounceYmin = 0;
    this.bounceXmax = width;
    this.bounceYmax = height;


  }

  Ball(float _x, float _y, int myColor, int _size){
    super(_x,_y);
    this.myColor = myColor;
    this.mySize = _size;
    this.bounceXmin = this.bounceYmin = 0;
    this.bounceXmax = width;
    this.bounceYmax = height;
  }

  Ball(int myColor, int _size, float _xVel, float _yVel){
    super(random(_size/2, width-_size/2)  ,random(_size/2, height-_size/2));
    this.mySize = _size;
    this.setVX(_xVel);
    this.setVY(_yVel);
    this.myColor = myColor;
    this.bounceXmin = this.bounceYmin = 0;
    this.bounceXmax = width;
    this.bounceYmax = height;
  }

  Ball(float x, float y, int myColor, int _size, float _xVel, float _yVel){
    super(x,y);
    this.setVX(_xVel);
    this.setVY(_yVel);
    this.myColor = myColor;
    this.mySize = _size;
    this.bounceXmin = this.bounceYmin = 0;
    this.bounceXmax = width;
    this.bounceYmax = height;
  }
  public void setBounds(int _bounceXmin, int _bounceYmin, int _bounceXmax, int _bounceYmax, boolean _randomize){

    this.bounceXmin = _bounceXmin;
    this.bounceYmin = _bounceYmin;
    this.bounceXmax = _bounceXmax;
    this.bounceYmax = _bounceYmax;
    if (_randomize) {
      this.setX(random(this.bounceXmin + this.mySize/2,this.bounceXmax - this.mySize/2));
      this.setY(random(this.bounceYmin + this.mySize/2,this.bounceYmax - this.mySize/2));

    }

  }
  public void update() {
    this.move();
    if (this.getX()+mySize/2 > this.bounceXmax || this.getX()-mySize/2 < this.bounceXmin) {
      this.setVX(this.v.getVX() * -1);
    }
    if (this.getY()+mySize/2 >  this.bounceYmax || this.getY()-mySize/2 < this.bounceYmin) {
      this.setVY(this.v.getVY() * -1);
    }
      fill(this.myColor);
    if (! this.beInvisible) {
    ellipseMode(CENTER);
    ellipse(this.getX(), this.getY(), mySize, mySize);
    }
  }
}



  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#FFFFFF", "Jan11" });
  }
}
