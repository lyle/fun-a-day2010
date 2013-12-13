int mySize;

void setup(){
  size(640,640,P2D);
  stroke(100,100,0);
  strokeWeight(1);
  background(0);
  noFill();
  mySize = 10;
}

void draw(){
  ellipse(mouseX,mouseY,mySize,mySize);
  if (keyPressed) {
    background(0);
  }

}
void mouseClicked(){
 mySize = int(random(3,12)); 
}

void mouseDragged(){
  stroke(int(random(100,255)), int(random(100,255)), int(random(100,255)));

}


