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

public class Jan21 extends PApplet {



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

  bars = new ArrayList();
}

public void mouseClicked(){
  mySize = PApplet.parseInt(random(4,30)); 
  bars.add(new Bar(mouseX,mouseY,color(PApplet.parseInt(random(100,255)), PApplet.parseInt(random(100,255)), PApplet.parseInt(random(100,255))),mySize));


  //  stroke(int(random(100,255)), int(random(100,255)), int(random(100,255)),140);
  //  strokeWeight(mySize);
  // line(mouseX,0,mouseX,height);

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
  }
}
public void draw(){

  for(int i=0; i < bars.size();i++){
    Bar bar = (Bar) bars.get(i);
    bar.update(); 

  }
}



class Bar {
  int size;
  float x, y;
  int myColor;
  int currentColor;
  float xVel=2.0f, yVel=2.8f;
  int xDir=1, yDir=1;

  Bar(float x, float y, int myColor, int size){
    this.x = x;
    this.y = y;
    this.myColor = myColor;
    this.currentColor = myColor;
    this.size = size;
  }


  public void update() {

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



    rect(x,0,this.size,height);
    // ellipse(x, y, size, size);
  }
}





  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#FFFFFF", "Jan21" });
  }
}
