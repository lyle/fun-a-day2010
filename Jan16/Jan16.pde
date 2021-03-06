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

// Number of links in chain
int numLinks = 3;

// Physics things we must store
Physics physics;
Body body, body2;

void setup() {
  size(640,640,P2D);
  //frameRate(60);
  sizeSet = false;

}

void draw() {
  background(0);
  noStroke();
  //This is a hack to make sure that the sketch size is
  //fully initialized before initializing the scene,
  //which depends on the width and height values.
  //Once Processing 1.0 is released, this should no longer
  //be necessary.
  ++count;
  if ( (!sizeSet && count > 10) ) {
    initScene();
  }

  if (mousePressed) {
    //Create a body
    float x0 = mouseX;
    float y0 = mouseY;
    Body randomBod = physics.createCircle(x0, y0, 10);//random(5.0f,15f));
    Vec2 vel = new Vec2(random(-30.0f,30.0f),random(-30.0f,30.0f));
    randomBod.setLinearVelocity(vel);
    randomBod.setUserData(new Style(color(int(random(200,255)),int(random(100,200)),200)));

  }

  if (keyPressed) {



    //Reset everything
    physics.destroy();
    body = body2 = null;
    initScene();
  }

}

void initScene() {
  physics = new Physics(this, width, height);

  physics.setDensity(1.0f);
  physics.setCustomRenderingMethod(this, "sketchBlocks");


  Body b1 = null;
  Body b2 = null;

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
        fill(255);
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




