import seltar.motion.*;
int ballCount = 7;
int dotCount = 2000;
color tmpColor;
Ball[] balls= new Ball[ballCount];
Ball[] dots = new Ball[dotCount];
int nextBall;
void setup(){  
  size(800,800);
  smooth();
  noStroke();
  for (int i=0; i < ballCount;i++){
    //balls[i] = new Ball(i*10, height/2, color(255,random(255),random(255)), int(random(10)+10), i+0.1,20-i);
    balls[i] = new Ball(random(0,width-20), random(0,height-20), color(255,random(255),random(255),40), int(random(10)+10), random(-2,2),random(-2,2));
  }
  for (int i=0; i < dotCount;i++){

    dots[i] = new Ball(random(0,width-20), random(0,height-20), color(255,random(255),random(255)), 1, random(-2,2),random(-2,2));
  }
}
void draw() {
  //
  // background(100);
  fill(0,10);
  rect(0,0,width,height);
  if(frameCount%10==0){
    float yV = random(-1,1);
    float xV = random(-1,1);

    for (int i=0; i < ballCount;i++){
      balls[i].xVel = balls[i].xVel + random(-1,1);
      balls[i].yVel = balls[i].yVel + random(-1,1);

      if(balls[i].xVel > 3){ 
        balls[i].xVel =3;
      }
      if(balls[i].xVel < -3){ 
        balls[i].xVel =-3;
      }
      if(balls[i].yVel > 3){ 
        balls[i].yVel =3;
      }
      if(balls[i].yVel < -3){ 
        balls[i].yVel =-3;
      }
    }
  }

  for (int i=0; i < ballCount;i++){
    if (i+1 == ballCount){
      nextBall = 0;
    }
    else{
      nextBall = i+1;
    }

    noStroke();
    balls[i].update();
    if(balls[i].x - balls[nextBall].x < 10){
      tmpColor = balls[i].myColor;
      
       balls[i].myColor = balls[nextBall].myColor; 
       balls[nextBall].myColor = tmpColor; 
    }
    stroke(balls[i].myColor,255);
    //line(balls[i].x+balls[i].size/2,balls[i].y+balls[i].size/2,balls[nextBall].x+balls[nextBall].size/2,balls[nextBall].y+balls[nextBall].size/2);

  }
  noStroke();
  for (int i=0; i < dotCount;i++){
    dots[i].xVel = dots[i].xVel + random(-1,1);
    dots[i].yVel = dots[i].yVel + random(-1,1);
    if(dots[i].xVel > 3){ 
      dots[i].xVel =3;
    }
    if(dots[i].xVel < -3){ 
      dots[i].xVel =-3;
    }
    if(dots[i].yVel > 3){ 
      dots[i].yVel =3;
    }
    if(dots[i].yVel < -3){ 
      dots[i].yVel =-3;
    }

    fill(dots[i].myColor);
    dots[i].update();
  }

}


