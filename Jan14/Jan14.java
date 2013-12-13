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

public class Jan14 extends PApplet {


int selected;
int a , r , g , b;

Ball[] Ghosts = new Ball[900];

public void setup(){
  size(640,640, P2D);  
  smooth();
  for (int i=0; i < Ghosts.length; i++){
    float tmpX = random(0+50,width-50);
    float tmpY = random(0+50,height-50);
    float tmpYv = random(-2,2);
    float tmpXv = random(-2,2);
    Ghosts[i] = new Ball(tmpX,tmpY,color(0),10,tmpXv, tmpYv);

  }
  selected = PApplet.parseInt(random(0,Ghosts.length));
}
public void mousePressed(){
  selected = PApplet.parseInt(random(0,Ghosts.length));
}
public void draw(){
   selected = PApplet.parseInt(random(0,Ghosts.length));
  noStroke();
  background(255);
  Ghosts[selected].myColor = color(0,255);
  for (int i=0; i < Ghosts.length; i++){
    
    Ghosts[i].update();
     a = (Ghosts[i].myColor >> 24) & 0xFF;
     r = (Ghosts[i].myColor >> 16) & 0xFF;
     g = (Ghosts[i].myColor >> 8) & 0xFF;
     b = Ghosts[i].myColor & 0xFF;
    r += random(0,(width+1)/(Ghosts[i].getX()+1));
    g += random(0,(height+1)/(Ghosts[i].getY()+1));
    b += random(0,(Ghosts[i].getX()+1)/(Ghosts[i].getY()+1));
    if (b>254 & r>254 & g>254){
      a=0;
    }
    Ghosts[i].myColor = color (r,g,b,a);
  }
//  for (int i=0; i < Ghosts.length; i++){
//
//
//     a = (Ghosts[i].myColor >> 24) & 0xFF;
//     r = (Ghosts[i].myColor >> 16) & 0xFF;
//     g = (Ghosts[i].myColor >> 8) & 0xFF;
//     b = Ghosts[i].myColor & 0xFF;
//    fill(b,r,g,a);

  //  ellipse(Ghosts[i].getX(),Ghosts[i].getY(),80,80);
//  }

  fill(255,4,4);
  //ellipse(Ghosts[selected].getX(),Ghosts[selected].getY(),90,90);
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
    PApplet.main(new String[] { "--bgcolor=#FFFFFF", "Jan14" });
  }
}
