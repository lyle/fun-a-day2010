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

ArrayList toDelete;

void setup() {
  size(640,640,P2D);
  

 // frameRate(60);
  sizeSet = false;
  toDelete = new ArrayList();

  
}

void draw() {
  //background(0);
  noStroke();
  ++count;
  if ( (!sizeSet && count > 10) ) {
    initScene();
  }

  if (mousePressed) {
    //Create a body
    float x0 = mouseX;
    float y0 = mouseY;
    float px = mouseX;
    float x,y;

    y = x = random(15,20); 
    float depth = mouseY;
    //Body randomBod = physics.createPolygon(30,30,20,20,30,10,30,30);
    //(x0, y0, random(5,15));//random(5,15));
    //Body randomBod = physics.createCircle(x0, y0, random(5,15));//random(5,15));
    Body randomBod = physics.createPolygon(px-x,depth, px+x,depth, px,-2*y+depth); 

    Vec2 vel = new Vec2(random(-30.0f,30.0f),random(-30.0f,30.0f));
    randomBod.setLinearVelocity(vel);
    randomBod.setUserData(new Style(color(int(random(100,255)),0,int(random(200,255)))));
  }

  if (keyPressed) {
    if(toDelete.size() > 0){
      for (int i = toDelete.size()-1; i >= 0; i--) { 
        physics.removeBody((Body) toDelete.get(i));
        toDelete.remove(i);
      }
    }
    //else{

    for ( Body bdy = physics.getWorld().getBodyList(); bdy != null; bdy = bdy.getNext()) 
    { 
      org.jbox2d.collision.Shape shape; 
      if(bdy.getUserData() != null){
        if( (physics.getCMPosition(bdy).x > 0 & 
          physics.getCMPosition(bdy).x < 150 &
          physics.getCMPosition(bdy).y > height) || 
          (physics.getCMPosition(bdy).x > width-150 & 
          physics.getCMPosition(bdy).x < width &
          physics.getCMPosition(bdy).y > height)
          ){
          toDelete.add(bdy); 

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
  physics = new Physics(this, width, height+50);

  physics.setDensity(5.0f);
  physics.setCustomRenderingMethod(this, "sketchBlocks");


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
        if(bdy.getUserData() != null){
          Style style = (Style) bdy.getUserData(); 
          if (style!=null) style.begin(); 
          noStroke();
          polyDraw(bdy, shape);
          if (style!=null) style.end(); 
        }
        else{
          fill(0);
          polyDraw(bdy, shape);
        }
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









