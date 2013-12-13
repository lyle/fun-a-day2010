import seltar.motion.*;
PVector startTree;
int a, r,g,b;
Branch[] trees = new Branch[1];


void setup(){
  size(640,640);
  startTree = new PVector(random(20,600),height);
  trees[0] = new Branch(startTree,60,color(255,0,0,40),3);
  stroke(0);
  smooth();
  noFill();
  background(0);
}

void mousePressed(){
  fill(0,90);
  noStroke();
  rect(0,0,width,height);
  startTree = new PVector(mouseX,height);
  trees = (Branch[]) append(trees,  new Branch(startTree,60,color(random(155,255),random(155,255),random(155,255),40),3));

  //  trees[trees.length] =

}

void draw(){

  for(int i=0;i<trees.length;i++){
     trees[i].update();
  }
}


