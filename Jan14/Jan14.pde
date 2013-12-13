import seltar.motion.*;
int selected;
int a , r , g , b;

Ball[] Ghosts = new Ball[900];

void setup(){
  size(640,640, P2D);  
  smooth();
  for (int i=0; i < Ghosts.length; i++){
    float tmpX = random(0+50,width-50);
    float tmpY = random(0+50,height-50);
    float tmpYv = random(-2,2);
    float tmpXv = random(-2,2);
    Ghosts[i] = new Ball(tmpX,tmpY,color(0),10,tmpXv, tmpYv);

  }
  selected = int(random(0,Ghosts.length));
}
void mousePressed(){
  selected = int(random(0,Ghosts.length));
}
void draw(){
   selected = int(random(0,Ghosts.length));
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




