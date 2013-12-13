//import processing.opengl.*;
import seltar.motion.*;

int lineCount = 2000;
Motion[] Lines = new Motion[lineCount];
color[] Strokecolor = new color[lineCount];
float[] Angles = new float[lineCount];
float[] Strokeweights = new float[lineCount];
int[] CurrentTarget = new int[lineCount];
float Strokeweight = 1;
boolean backgroundInverted = false;


int targetCount = 3;
Ball[] Targets = new Ball[targetCount];

void setup()
{
  size(640,640, P2D);  
  for (int i=0; i < lineCount; i++){
    Lines[i] = new Motion(random(0,width), random(0,height));
    Lines[i].wrap(0,0,width,height);
    Angles[i] = radians(random(360));
    Lines[i].setVelocity(random(3,6));
    Strokecolor[i] = color(200);
    CurrentTarget[i] = int(random(0,targetCount));
    Lines[i].setDamping(0.3);
  }
  for (int i=0; i < targetCount; i++){
    Targets[i] = new Ball(color(random(100,200), random(100,200), random(0,200)), 20, random(-3,3), random(-3,3));
    Targets[i].setBounds(50,50,width-50,height-50,true);
    Targets[i].beInvisible = true;
  }

  smooth();
  background(0);  

}
void mousePressed() {

  for (int i=0; i < lineCount; i++){
    CurrentTarget[i] = int(random(0,targetCount));
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

void draw()
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
    Lines[i].springTo(int(Targets[CurrentTarget[i]].getX()),int(Targets[CurrentTarget[i]].getY()));
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







