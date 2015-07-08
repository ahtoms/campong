public class Ball implements Intersectable, Drawable {
  
  private Hall hall;
  
  public int diameter;
  public int velocityX;
  public int velocityY;
  public int velocityZ;
  public int x;
  public int y;
  public int z;
  public color col;
  
  public Ball(int diameter, int startVelocity, int x, int y, int z, color col, Hall hall) {
     this.diameter = diameter;
     this.velocityX = 0;
     this.velocityY = 0;
     this.velocityZ = startVelocity;
     this.x = x;
     this.y = x;
     this.z = z;
     this.col = col;
     this.hall = hall;
  }

  public void setXVelocity(int velocity) {
     this.velocityX = velocity;
  }
  
  public void setYVelocity(int velocity) {
     this.velocityY = velocity;
  }
  
  public void setZVelocity(int velocity) {
     this.velocityZ = velocity;
  }
  
  public int getXVelocity() {
    return velocityX;
  }
  
  public int getYVelocity() {
    return velocityY;
  }
  
  public int getZVelocity() {
    return velocityZ;
  }

  public int getX() {
    return x; 
  }
  
  public int getY() {
    return y; 
  }
  
  public int getZ() {
    return z;
  }
  
  public int getWidth() {
    return diameter;
  }
  
  public int getHeight() {
     return diameter;
  }
  
  public int getDepth() {
    return diameter;
  }
  
  public boolean intersect(Intersectable object) {
    return getX()-(getWidth()/2) < (object.getX() + object.getWidth()/2) &&
           (getX() + getWidth()/2) >  (object.getX()-(object.getWidth()/2)) &&
           getY()-(getHeight()/2) < (object.getY() + (object.getHeight()/2)) &&
           (getY() + (getHeight()/2)) > object.getY()-(object.getHeight()/2) &&
           getZ()-(getDepth()/2) < (object.getZ() + object.getDepth()/2) &&
           (getZ() + getDepth()/2) > object.getZ()-(object.getDepth()/2);
  } 
  
  public void drawMe() {
    pushMatrix();
    noStroke();
    x += velocityX;
    y += velocityY;
    z += velocityZ;
    translate(x, y, z);
    fill(col);
    sphere(diameter);
    popMatrix();
  }
  
}
