

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

  bars = new ArrayList();
}

void mouseClicked(){
  mySize = int(random(4,30)); 
  bars.add(new Bar(mouseX,mouseY,color(int(random(100,255)), int(random(100,255)), int(random(100,255))),mySize));


  //  stroke(int(random(100,255)), int(random(100,255)), int(random(100,255)),140);
  //  strokeWeight(mySize);
  // line(mouseX,0,mouseX,height);

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
  }
}
void draw(){

  for(int i=0; i < bars.size();i++){
    Bar bar = (Bar) bars.get(i);
    bar.update(); 

  }
}



