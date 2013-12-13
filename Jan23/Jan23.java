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

public class Jan23 extends PApplet {



ArrayList bars;
int mySize;

public void setup(){
  size(640,640,P2D);
  stroke(100,100,0);
  strokeWeight(1);
  background(0);
  noStroke();
  noFill();
  mySize = 10;
  smooth();
  bars = new ArrayList();
}

public void mouseClicked(){
  mySize = PApplet.parseInt(random(8,30)); 
  Ball _ball = new Ball(random(0,width), random(0,height-20), color(255), mySize/3, random(-2,2),random(-2,2));
  bars.add(new Bar(mouseX,mouseY,
  color(PApplet.parseInt(random(100,255)), PApplet.parseInt(random(100,255)), PApplet.parseInt(random(100,255))),
  mySize, random(-0.4f,0.4f) , 0.0f, _ball));


  //  stroke(int(random(100,255)), int(random(100,255)), int(random(100,255)),140);
  //  strokeWeight(mySize);
  // line(mouseX,0,mouseX,height);

}
public void mouseReleased() {
  noStroke();
}
public void mouseDragged(){
  for(int i=0; i < bars.size();i++){
    int a,r,g,b,change;
    Bar bar = (Bar) bars.get(i);
    a = (bar.myColor >> 24) & 0xFF;
    r = (bar.myColor >> 16) & 0xFF;
    g = (bar.myColor >> 8) & 0xFF;
    b = bar.myColor & 0xFF;

    change = PApplet.parseInt( (mouseX/10) % 4 );
    a = 255 * mouseX/width;
    //a += change;
    //r += change;
    //g += change;
    //b -= change;

    if (b>254 & r>254 & g>254){
      a=0;
    }
    switch(change) {
    case 1: 
      bar.currentColor = color (r,g,b,a); 
          break;

    case 2: 
      bar.currentColor = color (g,b,r,a); 
          break;

    case 3: 
      bar.currentColor = color (b,r,g,a); 
          break;

    case 4: 
      bar.currentColor = color (g,r,b,a); 
          break;

    }
    
    
      stroke(bar.currentColor,40); 


  }
}
public void draw(){
  fill(0,10);
  rect(0,0,width,height);
  for(int i=0; i < bars.size();i++){
    Bar bar = (Bar) bars.get(i);
    bar.update(); 

  }
}






class Ball {
  int size;
  float x, y;
  int myColor;
  float xVel=2.0f, yVel=2.8f;
  int xDir=1, yDir=1;
  float leftBound, rightBound;

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
    this.leftBound = 0;
    this.rightBound = width;
  }
  public void setLeftBound(float lft) {
    this.leftBound = lft;
  }
  
  public void setRightBound(float rgt) {
    this.rightBound = rgt;
  }

  public void update() {
    x = x + (xVel * xDir);
    y = y + (yVel * yDir);
    if (x > this.rightBound-size) {
      x = this.rightBound-size;
      xDir = xDir * -1;
    }
    if (x < this.leftBound) {
      x = this.leftBound;
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
class Bar {
  int size;
  float x, y;
  int myColor;
  int currentColor;
  float xVel=2.0f, yVel=2.8f;
  int xDir=1, yDir=1;
  Ball ball;

  Bar(float x, float y, int myColor, int size){
    this.x = x;
    this.y = y;
    this.myColor = myColor;
    this.currentColor = myColor;
    this.size = size;
  }

  Bar(float x, float y, int myColor, int size, float xVel, float yVel, Ball _ball){
    this.xVel = xVel;
    this.yVel = yVel;
    this.x = x;
    this.y = y;
    this.myColor = myColor;
    this.currentColor = myColor;
    this.size = size;
    this.ball = _ball;
    this.ball.x = x + size/2;
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
    fill(this.currentColor);
    int a,r,g,b,az,rz,gz,bz;
    a = (this.myColor >> 24) & 0xFF;
    r = (this.myColor >> 16) & 0xFF;
    g = (this.myColor >> 8) & 0xFF;
    b = this.myColor & 0xFF;


    az = (this.currentColor >> 24) & 0xFF;
    rz = (this.currentColor >> 16) & 0xFF;
    gz = (this.currentColor >> 8) & 0xFF;
    bz = this.currentColor & 0xFF;

    if (az != 255) {
      az++;
    }

    if (rz > r){
      rz--;
    }
    else if (rz < r){
      rz++;
    } 
    else {

      if (gz > g){
        gz--;
      }
      else if (gz < g){
        gz++;
      }
      else{

        if (bz > b){
          bz--;
        }
        else if (bz < b){
          bz++;
        }
      }
    }
    this.currentColor = color (rz,gz,bz,az); 

    // ellipse(x, y, size, size);
    ball.myColor = this.currentColor;
    ball.setLeftBound(x);
    ball.setRightBound(x+size);
    
    
noFill();
    
    rect(x,0,this.size,height);
    ball.update();
  }
}






  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#FFFFFF", "Jan23" });
  }
}
