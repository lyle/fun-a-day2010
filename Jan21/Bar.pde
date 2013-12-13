class Bar {
  int size;
  float x, y;
  color myColor;
  color currentColor;
  float xVel=2.0, yVel=2.8;
  int xDir=1, yDir=1;

  Bar(float x, float y, color myColor, int size){
    this.x = x;
    this.y = y;
    this.myColor = myColor;
    this.currentColor = myColor;
    this.size = size;
  }


  void update() {

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



    rect(x,0,this.size,height);
    // ellipse(x, y, size, size);
  }
}




