
int ballCount = 11;
color tmpColor;
Ball[] balls= new Ball[ballCount];
Palette p;
int myColor;

void setup(){
  size(640,640, P2D);
  p=new Palette("poetry.cs");
  color cl=p.colors[0];

    background(p.colors[int(random(0,p.colors.length))]);
  for (int i=0; i < ballCount;i++){
    //balls[i] = new Ball(i*10, height/2, color(255,random(255),random(255)), int(random(10)+10), i+0.1,20-i);
    balls[i] = new Ball(random(0,width-20), random(0,height-20), color(255,random(255),random(255),40),
    int(random(5,35)), random(-20,20),random(-20,20));
  }
}

void draw(){
  if(  mousePressed ){
    background(p.colors[int(random(0,p.colors.length))]);
  }


  for (int i=0; i < ballCount;i++){


    noStroke();
    balls[i].update();
  }
}


