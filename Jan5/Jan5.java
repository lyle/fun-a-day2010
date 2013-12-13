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

public class Jan5 extends PApplet {



int lineCount = 30;
Motion[] Lines = new Motion[lineCount];
int yummyColor;
int[] Strokecolor = new int[lineCount];
float[] Angles = new float[lineCount];
float[] Strokeweights = new float[lineCount];
//random(TWO_PI)
int modVal;
float Strokeweight = 1;
int numberOfLines = 0;
int startX, startY, stopX, stopY;
boolean  starting = true;

int yummyDeath, yummyX, yummyY;
boolean  yummyExistis = false;
int yummyDeathAge = 400;
Motion NextLine;
public void setup()
{
  size(640,640);  
  for (int i=0; i < lineCount; i++){
    Lines[i] = new Motion(random(0,width), random(0,height));
    Lines[i].wrap(0,0,width,height);
    Angles[i] = radians(random(360));
    Lines[i].setVelocity(random(8,10));
    Strokecolor[i] = color(200);
    Lines[i].setConstant(100);
    Lines[i].setSpring(.3f);
  }  
  smooth();
  //background(50,0,0);  
  stroke(255);
}
public void mousePressed() {
  if ( !yummyExistis ){
    yummyX = mouseX;
    yummyY = mouseY;
    initYummy();
  }

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


  noStroke();
  fill(0,10);
  rect(0,0,height,width);


  Strokecolor[1] = color(255,0,0);

  for (int i=0; i < lineCount; i++){

    if (i+1==lineCount) {
      NextLine = Lines[0];
    }
    else{
      NextLine = Lines[i+1];
    }

    Strokeweights[i] += random(-1.5f,1.5f);
    Strokeweights[i] = abs(Strokeweights[i]);
    if (Strokeweights[i] >= 3) {
      Strokeweights[i] = 3;
    }
    strokeWeight(Strokeweights[i]);
    modVal = PApplet.parseInt(5-(Lines[i].v.getVelocity()));
    if (modVal ==0) modVal = 1;
    if (frameCount%PApplet.parseInt(modVal)==0) {
      Lines[i].setAngle(Angles[i] += radians(random(-30,30  )));
    }
    Lines[i].wrap(0,0,width,height);
    Lines[i].springTo(NextLine.getX(), NextLine.getY());


    //    if (yummyExistis & Strokecolor[i] != yummyColor) {
    //     Lines[i].springTo(yummyX, yummyY);
    //      if (Lines[i].getDistanceTo(yummyX,yummyY) < 10 ) {
    //      Strokecolor[i] = yummyColor;
    //     }
    //   }
    strokeWeight(Strokeweights[i]);
    stroke(Strokecolor[i]);
    Lines[i].move();
    if (Lines[i].getDistanceTo(NextLine.getX(), NextLine.getY()) < 10 ){
      if (i+1 ==lineCount ) {
        Strokecolor[i] = Strokecolor[0];
      }
      else{
        Strokecolor[i] = Strokecolor[i+1];
      }
    }
    stroke(Strokecolor[i]);
    line(Lines[i].getPX(),Lines[i].getPY(),Lines[i].getX(),Lines[i].getY());
  }  
}


  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#FFFFFF", "Jan5" });
  }
}
