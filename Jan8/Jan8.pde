
import seltar.motion.*;
int lineCount = 600;
Motion[] Lines = new Motion[lineCount];
Motion myYummy;
color yummyColor;
color[] Strokecolor = new color[lineCount];
float[] Angles = new float[lineCount];
float[] Strokeweights = new float[lineCount];
//random(TWO_PI)

float Strokeweight = 1;
int numberOfLines = 0;
  int startX, startY, stopX, stopY;
boolean  starting = true;
  PGraphics pg;
int yummyDeath, yummyX, yummyY;
boolean  yummyExistis = false;
int yummyDeathAge = 400;
  
void setup()
{
  size(800,800);  
  for (int i=0; i < lineCount; i++){
     Lines[i] = new Motion(random(0,width), random(0,height));
     Lines[i].wrap(0,0,width,height);
     Angles[i] = radians(random(360));
     Lines[i].setVelocity(random(1,3));
     Strokecolor[i] = color(200);
  }
  myYummy = new Motion(random(0,width), random(0,height));
  smooth();
  background(0);  
  stroke(255);
  pg = createGraphics(width, height, P2D);
}
void mousePressed() {
 if ( !yummyExistis ){
   yummyX = mouseX;
   yummyY = mouseY;
   initYummy();
 }

}
void mouseReleased() {
}
void initYummy () {
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

void startDrawing () {


  
}

void draw()
{

    //pg.beginDraw();
    fill(0,10);
    rect(0,0,height,width);
    
    //pg.background(0,1);
    //pg.endDraw();
    //image(pg, 0, 0);
    if (yummyExistis) {
      strokeWeight(5);
      fill(yummyColor);
      stroke(yummyColor);
      myYummy.followTo(yummyX,yummyY);
      myYummy.move();
    //  ellipse(yummyX, yummyY, 10,10);
      yummyDeath ++;
    }else if (random(0,100) > 95) {
      yummyX = int(random(0, width));
      yummyY = int(random(0, height));
      myYummy.springTo(yummyX,yummyY);
      myYummy.move();
      initYummy();
    }
    if (yummyDeath > yummyDeathAge) {
      yummyDeath = 0;
      yummyExistis = false; 
    }
    

  for (int i=0; i < lineCount; i++){
    

    Strokeweights[i] += random(-0.5,0.5);
    Strokeweights[i] = abs(Strokeweight);
    if (Strokeweights[i] >= 7) {
      Strokeweights[i] = 7;
    }
    strokeWeight(Strokeweights[i]);
        
     Lines[i].setAngle(Angles[i] += radians(random(-20,20  )));
     Lines[i].wrap(-100,-100,width+100,height+100);
     if (yummyExistis & Strokecolor[i] != yummyColor) {
       Lines[i].springTo(myYummy.getX(), myYummy.getY());
       if (Lines[i].getDistanceTo(yummyX,yummyY) < 10 ) {
        Strokecolor[i] = yummyColor;
       }
     }
     noStroke();
     fill(Strokecolor[i]);
     Lines[i].move();
     ellipse(Lines[i].getPX(),Lines[i].getPY(),Strokeweights[i],Strokeweights[i]);
     //line(Lines[i].getPX(),Lines[i].getPY(),Lines[i].getX(),Lines[i].getY());
  }  
}
