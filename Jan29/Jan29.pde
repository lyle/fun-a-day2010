import org.jbox2d.util.nonconvex.*;
import org.jbox2d.dynamics.contacts.*;
import org.jbox2d.testbed.*;
import org.jbox2d.collision.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.p5.*;
import org.jbox2d.dynamics.*;

// To work around threading problems with size
boolean sizeSet;
int count = 0;
int numberOfObjects=0;

float userTimeOut = 0.15*60*60; //(?? seconds)
float userTickle = userTimeOut;

// Number of links in chain
int numLinks = 3;

// Physics things we must store
Physics physics;
Body body, body2;

ArrayList toDelete;

void setup() {
  size(640,640,P2D);
  frameRate(60);
  sizeSet = false;
  toDelete = new ArrayList();
  numberOfObjects = 0;
}

void mouseMoved(){
  userTickle = userTimeOut;
}

void emulateUser(){
  for ( Body bdy = physics.getWorld().getBodyList(); bdy != null; bdy = bdy.getNext()) 
  { 
    bdy.setLinearVelocity(new Vec2(-1,1));
  }
  checkHit(random(width),random(height),100);
  userTickle = random(.01,.25)*60*60;
}
void checkHit(float x,float y,int circleSize){
  for ( Body bdy = physics.getWorld().getBodyList(); bdy != null; bdy = bdy.getNext()) 
  { 
    org.jbox2d.collision.Shape shape; 
    for (shape = bdy.getShapeList(); shape != null; shape = shape.getNext()) { 
      if (shape.getType() == ShapeType.CIRCLE_SHAPE){
        if (dist(x,y,physics.getCMPosition(bdy).x,physics.getCMPosition(bdy).y) < circleSize){
          toDelete.add(bdy); 
          physics.getWorld().setGravity(new Vec2(random(-20,20),random(-20,20)));
          break;
        }
      }
    }
  }
}
void mouseClicked(){
  checkHit(mouseX,mouseY,30);
}
void draw() {
  background(0);
  noStroke();
  
  userTickle --;
  if (userTickle <0){
    emulateUser();
  }
  ++count;
  if ( (!sizeSet && count > 10) ) {
    initScene();
  }
  
    if(toDelete.size() > 0){
      for (int i = toDelete.size()-1; i >= 0; i--) { 
        physics.removeBody((Body) toDelete.get(i));
        toDelete.remove(i);
        numberOfObjects --;
      }
    }
if (sizeSet & numberOfObjects < 2 | sizeSet & mouseY < 10 & numberOfObjects < 70 ) {
 // if ( numberOfObjects < 200 & sizeSet) {
    //Create a body
    float x0 = mouseX;
    float y0 = mouseY;
    Body randomBod = physics.createCircle(x0, y0, 30);//random(5,15));
    numberOfObjects++;
    //Body randomBod = physics.createCircle(x0, y0, random(5,15));//random(5,15));
    Vec2 vel = new Vec2(random(-30.0f,30.0f),random(-30.0f,30.0f));
    randomBod.setLinearVelocity(vel);
    
  colorMode(HSB,100);
    randomBod.setUserData(new Style(color((frameCount + 255)%100,100,100)));
 // }
}
  if (keyPressed) {

    //else{

    for ( Body bdy = physics.getWorld().getBodyList(); bdy != null; bdy = bdy.getNext()) 
    { 
      org.jbox2d.collision.Shape shape; 
      for (shape = bdy.getShapeList(); shape != null; shape = shape.getNext()) { 

        if (shape.getType() == ShapeType.CIRCLE_SHAPE){


          //print(physics.getCMPosition(bdy).x);
          if( physics.getCMPosition(bdy).x > width/2 - 150 & 
            physics.getCMPosition(bdy).x < width/2 + 150 &
            physics.getCMPosition(bdy).y > height ){
            toDelete.add(bdy); 

          }
        }
      }
    }
    // }
    //Reset everything
    //physics.destroy();
    //body = body2 = null;
    //initScene();
  }

}

void initScene() {
  physics = new Physics(this, width, height+40);

  physics.setDensity(5.0f);
  physics.setCustomRenderingMethod(this, "sketchBlocks");
  physics.createPolygon(width-150,height,width,height,width,height-30);

  physics.createPolygon(0,height,150,height,0,height-30);

  Body b1 = null;
  Body b2 = null;

  // Make a chain of bod

  sizeSet = true;
}






void sketchBlocks(World w) { 
  // if (frameCount%10 != 0) return; 
  background(0); 
  noFill(); 
  noStroke(); 

  for ( Body bdy = physics.getWorld().getBodyList(); bdy != null; bdy = bdy.getNext()) 
  { 
    org.jbox2d.collision.Shape shape; 

    for (shape = bdy.getShapeList(); shape != null; shape = shape.getNext()) { 

      if (shape.getType() == ShapeType.POLYGON_SHAPE) { 
        //print(shape.getUserData());
        fill(0);
        polyDraw(bdy, shape);
      }

      if (shape.getType() == ShapeType.CIRCLE_SHAPE){
        Style style = (Style) bdy.getUserData(); 
        if (style!=null) style.begin(); 
        noStroke();
        circleDraw(bdy, shape);
        if (style!=null) style.end(); 
      }
    } 
  } 
  //if (mousePressed && mouseButton == LEFT) { 
  //  rect(x1, y1, x2-x1, y2-y1); 
  //} 
} 

void circleDraw(Body body, org.jbox2d.collision.Shape shape) {

  //convert the shape to a circleshape
  CircleShape circle = (CircleShape) shape;

  //get position of circle within body
  Vec2 center = circle.getLocalPosition();

  //get position of body within world and convert to pixel coordinates
  Vec2 wpoint = physics.worldToScreen(body.getWorldPoint(center));

  //get the radius of the circleshape in pixel format
  float radius = physics.worldToScreen(circle.getRadius());

  //draw the circle with radius converted to diameter
  ellipse(wpoint.x,wpoint.y,radius*2,radius*2);
}

void polyDraw(Body body, org.jbox2d.collision.Shape shape) {

  beginShape();

  PolygonShape poly = (PolygonShape) shape;

  //get the number of vertex points that make up the shape
  int count = poly.getVertexCount();

  //convert the polygon into points
  Vec2[] verts = poly.getVertices();

  //make a vertex for each point of the polygon and convert for pixel coordinates
  for(int i = 0; i < count; i++) {

    //get the position of the vertex of the shape within the body in the world (whew!!)
    Vec2 vert = physics.worldToScreen(body.getWorldPoint(verts[i]));
    vertex(vert.x, vert.y);
  }

  //connect the last point with the first point and stop
  Vec2 firstVert = physics.worldToScreen(body.getWorldPoint(verts[0])); 
  vertex(firstVert.x, firstVert.y);
  endShape();
}


class Style { 
  color fillColor; 
  Style(color c) { 
    fillColor = c; 
  } 
  void begin() { 
    pushStyle(); 
    fill(fillColor); 
  } 
  void end() { 
    popStyle(); 
  } 
} 








