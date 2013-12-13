

ArrayList bars;
int mySize;

void setup(){
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

void mouseClicked(){
  mySize = int(random(8,30)); 
  Ball _ball = new Ball(random(0,width), random(0,height-20), color(255), mySize/3, random(-2,2),random(-2,2));
  bars.add(new Bar(mouseX,mouseY,
  color(int(random(100,255)), int(random(100,255)), int(random(100,255))),
  mySize, random(-0.4,0.4) , 0.0, _ball));


  //  stroke(int(random(100,255)), int(random(100,255)), int(random(100,255)),140);
  //  strokeWeight(mySize);
  // line(mouseX,0,mouseX,height);

}
void mouseReleased() {
  noStroke();
}
void mouseDragged(){
  for(int i=0; i < bars.size();i++){
    int a,r,g,b,change;
    Bar bar = (Bar) bars.get(i);
    a = (bar.myColor >> 24) & 0xFF;
    r = (bar.myColor >> 16) & 0xFF;
    g = (bar.myColor >> 8) & 0xFF;
    b = bar.myColor & 0xFF;

    change = int( (mouseX/10) % 4 );
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
void draw(){
  fill(0,10);
  rect(0,0,width,height);
  for(int i=0; i < bars.size();i++){
    Bar bar = (Bar) bars.get(i);
    bar.update(); 

  }
}






