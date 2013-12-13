class Ball {
  int size;
  float x, y;
  color myColor;
  float xVel=2.0, yVel=2.8;
  int xDir=1, yDir=1;

  Ball(float x, float y, color myColor, int size){
    this.x = x;
    this.y = y;
    this.myColor = myColor;
    this.size = size;
  }
  Ball(float x, float y, color myColor, int size, float xVel, float yVel){
    this.xVel = xVel;
    this.yVel = yVel;
    this.x = x;
    this.y = y;
    this.myColor = myColor;
    this.size = size;
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
    fill(this.myColor);
    
   // ellipseMode(CORNER);
   // ellipse(x, y, size, size);
  }
}
