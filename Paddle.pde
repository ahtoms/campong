import java.util.Collections;
import java.util.ArrayList;

public class Paddle extends Thread implements Intersectable, Drawable {
  
  public int x;
  public int y;
  public color col;
  public int size;
  public Hall hall;
  private PImage image;
  
  private color[][] kernel = {
     { color(255, 0, 0), color(255, 0, 0), color(255, 0, 0), color(255, 0, 0), color(255, 0, 0) },
     { color(255, 0, 0), color(255, 0, 0), color(255, 0, 0), color(255, 0, 0), color(255, 0, 0) },
     { color(255, 0, 0), color(255, 0, 0), color(255, 0, 0), color(255, 0, 0), color(255, 0, 0) },
     { color(255, 0, 0), color(255, 0, 0), color(255, 0, 0), color(255, 0, 0), color(255, 0, 0) },
     { color(255, 0, 0), color(255, 0, 0), color(255, 0, 0), color(255, 0, 0), color(255, 0, 0) },
   };
  
  public Paddle(int x, int y, color col, Hall hall) {
    this.x = x;
    this.y = y;
    this.col = col;
    size = 200;
    this.hall = hall;
  }
  
  public int getX() {
    return x; 
  }
  
  public int getY() {
    return y; 
  }
  
  public int getZ() {
    return 0;
  }
  
  public int getWidth() {
    return size;
  }
  
  public int getHeight() {
     return size;
  }
  
  public int getDepth() {
    return 1;
  }
  
  public void setSize(int size) {
    this.size = size; 
  }
  
  public void setCoordinates(int x, int y) {
    this.x = x;
    this.y = y;
  }
  
  public void setBasedOnImage(PImage image) {
    ArrayList<Integer> xPositions = new ArrayList<Integer>();
    ArrayList<Integer> yPositions = new ArrayList<Integer>();
    boolean check = true;
    int potential = 0;
    if(image.width > 0 && image.height > 0) {
      for(int posX = 2; posX < image.width; posX++) {
        for(int posY = 2; posY < image.height; posY++) {
          check = true;
          for(int kx = -2; kx < 3; kx++) {
            for(int ky = -2; ky < 3; ky++) {
              if((posY+ky)*image.width + (posX+kx) < image.height*image.width) {
                if(color(image.pixels[(posY+ky)*image.width + (posX+kx)]) 
                != kernel[ky+2][kx+2]) {
                   check = false;
                }
              }
            } 
          }
          if(check) {
            potential++;
            xPositions.add(posX);
            yPositions.add(posY);
          }
        } 
      }
    }
    if(potential > 0) {
      processCoordinates(xPositions, yPositions);
    }
  }
  
  private void processCoordinates(ArrayList<Integer> xPositions, ArrayList<Integer> yPositions) {
    int sumX = 0;
    int sumY = 0; 
    int avgX = 0;
    int avgY = 0;
    for(int i = 0; i < xPositions.size(); i++) {
       sumX += xPositions.get(i);
       sumY += yPositions.get(i);
    }
    avgX = sumX/xPositions.size();
    avgY = sumY/yPositions.size();
    //println(xPositions.size());
    setCoordinates(avgX*8, avgY*8);
     
  }
  
  public boolean intersect(Intersectable object) {
    return getX()-(getWidth()/2) < (object.getX() + object.getWidth()/2) &&
           (getX() + getWidth()/2) >  (object.getX()-(object.getWidth()/2)) &&
           getY()-(getHeight()/2) < (object.getY() + (object.getHeight()/2)) &&
           (getY() + (getHeight()/2)) > object.getY()-(object.getHeight()/2) &&
           getZ()-(getDepth()/2) < (object.getZ() + object.getDepth()/2) &&
           (getZ() + getDepth()/2) > object.getZ()-(object.getDepth()/2);
  }
  
  public void calculateRebound(Ball ball) {
    //derive the rebound of how centre it is, the further away the greater the angle
    int xCalc = (getX() - ball.getX());
    int yCalc = (getY() - ball.getY());
    ball.setZVelocity(-ball.getZVelocity());
    ball.setXVelocity(-(xCalc/4));
    ball.setYVelocity(-(yCalc/4));
  }
  
  public void drawMe() {
    pushMatrix();
    fill(col);
    noStroke();
    ellipse(x, y, size, size);
    popMatrix();
  }
  
}
