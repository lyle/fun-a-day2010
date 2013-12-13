import seltar.motion.*;
int threadCount = 40;
Motion[] Threads = new Motion[threadCount];
color[] ThreadColors = new color[threadCount];
float[] ThreadAngles = new float[threadCount];
float[] ThreadWidth = new float[threadCount];
int      pixelPointer;
float tmpX, tmpY,tmpPX, tmpPY;
Motion NextThread;

void setup()
{
  size(800,800);
  for (int i=0; i < threadCount; i++){
    Threads[i] = new Motion(random(0,width), random(0,height));
    Threads[i].setConstant(1000);
    ThreadAngles[i] = radians(random(360));
    Threads[i].setVelocity(1);
    ThreadColors[i] = color(random(100,200),0,0);

  }  
  smooth();
  background(0);
  stroke(255);
} 
void mousePressed() {
  background(0);
}
void checkLocation(Motion item){
    if ( item.getX() > width ) item.setX(width-100);
    if ( item.getX() < 0 ) item.setX(100);
    if ( item.getY() > height ) item.setY(height-100);
    if ( item.getY() < 0 ) item.setY(100); 
}
void draw(){
    stroke(0,0);
    fill(0,4);
    rect(0,0,width,height);
  for (int i=0; i < threadCount; i++){
    Threads[i].setAngle(ThreadAngles[i] += radians(random(-1,1  )));
    Threads[i].wrap(0,0,width, height);
    //Threads[i].wrap(0,0,width,height);
    strokeWeight(2);
    
    if (i+1==threadCount) {
      NextThread = Threads[0];
    }else{
      NextThread = Threads[i+1];
    }
    
    ThreadWidth[i] = abs(ThreadWidth[i] + random(-0.5,0.5));
    if (ThreadWidth[i] > 6) ThreadWidth[i] = 6;
  //  line(width/2-100,height/2-100, width/2+100,height/2+100);
    if (Threads[i].getPX()>width/2-100 & Threads[i].getPX()<width/2+100 & Threads[i].getPY()>height/2-100 & Threads[i].getPY()<height/2+100 )
    {
      ThreadColors[i] = color(random(100,200),50,50);
      
      stroke(255,50);
      strokeWeight(1);
      if (Threads[i].getX()<=width/2-100) {
        //  line(Threads[i].getPX(),height/2-100,Threads[i].getPX(), height/2+100);
          Threads[i].setVelocity(-Threads[i].v.getVelocity());
      }
      if (Threads[i].getX()>=width/2+100) {

        //  line(Threads[i].getX()+Threads[i].v.getVelocity(),height/2-100,Threads[i].getX()+Threads[i].v.getVelocity(), height/2+100);
          Threads[i].setVelocity(-Threads[i].v.getVelocity());
      }
      
      if (Threads[i].getY()>=height/2+100) {

        //  line(width/2-100,Threads[i].getY()+Threads[i].v.getVelocity(),width/2+100, Threads[i].getY()+Threads[i].v.getVelocity());
          Threads[i].setVelocity(-Threads[i].v.getVelocity());
      }
      
    }else if (Threads[i].getDistanceTo(NextThread.getX(), NextThread.getY())   < 10  ) {
      ThreadWidth[i] = 6;
      ThreadColors[i] = color(255,255,255);
    }else {
      ThreadColors[i] = color(random(100,200),random(100,200),random(100,200));
    }
    
    Threads[i].move();
    
    tmpPX = Threads[i].getPX();
    tmpPY = Threads[i].getPY();
    tmpX = Threads[i].getX()+random(-15,15);
    tmpY = Threads[i].getY()+random(-15,15);
    
    
    strokeWeight(1);
    stroke(100,255,255,100);
    line(tmpPX, tmpPY, tmpX, tmpY);
    
    stroke(ThreadColors[i]);
    strokeWeight(ThreadWidth[i]);
    
    ellipse(tmpX,tmpY,ThreadWidth[i],ThreadWidth[i]);
    
  }
  //line(Threads[2].getPX(),Threads[2].getPY(),Threads[3].getX(),Threads[3].getY());
  //  stroke(0,0);
   // fill(0,200);
  // rect(width/2-100,height/2-100,200,200);
  //  rect(width/2-95,height/2-95,195,195);
   // rect(width/2-90,height/2-90,190,190);
}

