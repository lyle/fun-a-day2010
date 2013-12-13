class Ball {
  int size;
  float x, y;
  color myColor;
  float xVel=2.0, yVel=2.8;
  int xDir=1, yDir=1;
  float leftBound, rightBound;

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
    this.leftBound = 0;
    this.rightBound = width;
  }
  void setLeftBound(float lft) {
    this.leftBound = lft;
  }
  
  void setRightBound(float rgt) {
    this.rightBound = rgt;
  }

  void update() {
    x = x + (xVel * xDir);
    y = y + (yVel * yDir);
    if (x > this.rightBound-size) {
      x = this.rightBound-size;
      xDir = xDir * -1;
    }
    if (x < this.leftBound) {
      x = this.leftBound;
      xDir = xDir * -1;
    }
    if (y > height-size || y < 0) {
      yDir *= -1;
    }
    fill(this.myColor);
    
    ellipseMode(CORNER);
    ellipse(x, y, size, size);
  }
}
