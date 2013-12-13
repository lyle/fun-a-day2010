class Bar {
  int size;
  float x, y;
  color myColor;
  color currentColor;
  float xVel=2.0, yVel=2.8;
  int xDir=1, yDir=1;
  Ball ball;

  Bar(float x, float y, color myColor, int size){
    this.x = x;
    this.y = y;
    this.myColor = myColor;
    this.currentColor = myColor;
    this.size = size;
  }

  Bar(float x, float y, color myColor, int size, float xVel, float yVel, Ball _ball){
    this.xVel = xVel;
    this.yVel = yVel;
    this.x = x;
    this.y = y;
    this.myColor = myColor;
    this.currentColor = myColor;
    this.size = size;
    this.ball = _ball;
    this.ball.x = x + size/2;
  }


  void update() {
    x = x + (xVel * xDir);
    y = y + (yVel * yDir);

    if (x > width-size || x < 0) {
      xDir = xDir * -1;
    }
    if (y > height-size || y < 0) {
      yDir *= -1;
    }
    fill(this.currentColor);
    int a,r,g,b,az,rz,gz,bz;
    a = (this.myColor >> 24) & 0xFF;
    r = (this.myColor >> 16) & 0xFF;
    g = (this.myColor >> 8) & 0xFF;
    b = this.myColor & 0xFF;


    az = (this.currentColor >> 24) & 0xFF;
    rz = (this.currentColor >> 16) & 0xFF;
    gz = (this.currentColor >> 8) & 0xFF;
    bz = this.currentColor & 0xFF;

    if (az != 255) {
      az++;
    }

    if (rz > r){
      rz--;
    }
    else if (rz < r){
      rz++;
    } 
    else {

      if (gz > g){
        gz--;
      }
      else if (gz < g){
        gz++;
      }
      else{

        if (bz > b){
          bz--;
        }
        else if (bz < b){
          bz++;
        }
      }
    }
    this.currentColor = color (rz,gz,bz,az); 

    // ellipse(x, y, size, size);
    ball.myColor = this.currentColor;
    ball.setLeftBound(x);
    ball.setRightBound(x+size);
    
    
noFill();
    
    rect(x,0,this.size,height);
    ball.update();
  }
}





