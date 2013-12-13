class Branch {
  color myColor;
  PVector start;
  PVector end;
  Motion[] Lines = new Motion[1];
  float[] Thickness = new float[Lines.length];
  float startWidth, endWidth;
  float angle;
  boolean hasEnded = false;
  int numberOfBranches;
  Branch[] Children = new Branch[3];

  Branch(PVector _start, int _startWidth, int _myColor, int _numberOfBranches){
    this.numberOfBranches = _numberOfBranches;
    this.myColor = _myColor;
    this.start = _start;
    this.startWidth = _startWidth;
    this.angle = startWidth * 30;

    this.end = new PVector( start.x + random(-200,200),
    start.y - 120 + random(-startWidth,startWidth) );

    for (int i=0; i < Lines.length; i++){
      Lines[i] = new Motion(start.x + random(- startWidth, startWidth),start.y);
      Thickness[i] = 3;
      //Lines[i].setConstant(9);
    }
    if (numberOfBranches > 0) {
      for (int i=0; i < Children.length; i++)
      {
          Children[i] = new Branch(end,int(startWidth/3),myColor,numberOfBranches - 1);
      }
    }
  } 

  void display() {


  }
  void update() {
    if (hasEnded){
      if (numberOfBranches > 0) {
        for (int i=0; i < Children.length; i++)
        {
          Children[i].update();
        }
      }
    }
    else{

      //ellipse(end.x,end.y,5,5);
      //ellipse(width/2, height/2, 30,30);
      for (int i=0; i < Lines.length; i++){
        //Lines[i] = new Motion(start.x,start.y);
        Lines[i].followTo(end.x+random(-startWidth/3,startWidth/3), end.y);
        Lines[i].setVelocity(2);

        float Angle = Lines[i].getAngle();
        if (Lines[i].getDistanceTo(end.x, end.y)>10){
          if(Lines[i].getX() < width/2) {
          Angle += radians(random(-60,10));
          }else{
          Angle += radians(random(-10,90));
            
          }
        }
        Lines[i].setAngle(Angle);
        stroke(this.myColor);
        Lines[i].move();
        Thickness[i] += random(-.2,.2);
        Thickness[i] = abs(Thickness[i]);
        if (Thickness[i] > 3) { 
          Thickness[i] = 3;
        }else if(Thickness[i]<1){
          Thickness[i] = 1;
        }
        //strokeWeight(Thickness[i]*(numberOfBranches+1));
        //line(Lines[i].getX(), Lines[i].getY(), Lines[i].getPX(), Lines[i].getPY());
        ellipse(Lines[i].getX()+random(-3,3), Lines[i].getY()+random(-3,3),Thickness[i]*(numberOfBranches+1),Thickness[i]*(numberOfBranches+1));
        if (Lines[i].getDistanceTo(end.x,end.y) < 30 ) {
          fill(0,200,255,76);
          noStroke();
          ellipse(Lines[i].getX()+random(-30,30), Lines[i].getY()+random(-30,30),Thickness[i]*(numberOfBranches+1),Thickness[i]*(numberOfBranches+1));
          noFill();
        }
        
      }
      if (Lines[0].getDistanceTo(end.x,end.y) < 1) {
      //  line(0,Lines[0].getY(),width,Lines[0].getY());
        hasEnded = true;
      }

    }
  }
}







