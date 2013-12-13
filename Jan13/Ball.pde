class Ball extends Motion {
  float mySize;
  color myColor;
  int bounceXmin;
  int bounceYmin;
  int bounceXmax;
  int bounceYmax;
  float _x;
  float _y;
  boolean beInvisible;
  

  Ball(color myColor, int _size){
    super(random((_size)/2, width - (_size/2)),random((_size)/2, height - (_size/2)));
    //  _x = 
    //  _y =  ;
    this.mySize = _size;
    this.myColor = myColor;
    this.bounceXmin = this.bounceYmin = 0;
    this.bounceXmax = width;
    this.bounceYmax = height;


  }

  Ball(float _x, float _y, color myColor, int _size){
    super(_x,_y);
    this.myColor = myColor;
    this.mySize = _size;
    this.bounceXmin = this.bounceYmin = 0;
    this.bounceXmax = width;
    this.bounceYmax = height;
  }

  Ball(color myColor, int _size, float _xVel, float _yVel){
    super(random(_size/2, width-_size/2)  ,random(_size/2, height-_size/2));
    this.mySize = _size;
    this.setVX(_xVel);
    this.setVY(_yVel);
    this.myColor = myColor;
    this.bounceXmin = this.bounceYmin = 0;
    this.bounceXmax = width;
    this.bounceYmax = height;
  }

  Ball(float x, float y, color myColor, int _size, float _xVel, float _yVel){
    super(x,y);
    this.setVX(_xVel);
    this.setVY(_yVel);
    this.myColor = myColor;
    this.mySize = _size;
    this.bounceXmin = this.bounceYmin = 0;
    this.bounceXmax = width;
    this.bounceYmax = height;
  }
  void setBounds(int _bounceXmin, int _bounceYmin, int _bounceXmax, int _bounceYmax, boolean _randomize){

    this.bounceXmin = _bounceXmin;
    this.bounceYmin = _bounceYmin;
    this.bounceXmax = _bounceXmax;
    this.bounceYmax = _bounceYmax;
    if (_randomize) {
      this.setX(random(this.bounceXmin + this.mySize/2,this.bounceXmax - this.mySize/2));
      this.setY(random(this.bounceYmin + this.mySize/2,this.bounceYmax - this.mySize/2));

    }

  }
  void update() {
    this.move();
    if (this.getX()+mySize/2 > this.bounceXmax || this.getX()-mySize/2 < this.bounceXmin) {
      this.setVX(this.v.getVX() * -1);
    }
    if (this.getY()+mySize/2 >  this.bounceYmax || this.getY()-mySize/2 < this.bounceYmin) {
      this.setVY(this.v.getVY() * -1);
    }
      fill(this.myColor);
    if (! this.beInvisible) {
    ellipseMode(CENTER);
    ellipse(this.getX(), this.getY(), mySize, mySize);
    }
  }
}


