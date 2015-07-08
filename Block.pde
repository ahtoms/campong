public class Block implements Intersectable, Drawable {
  
  
  public Hall hall;
  
  public int x;
  public int y;
  public int z;
  public int blockWidth;
  public int blockHeight;
  public int blockDepth;
  public color col;
  public int hit;
  
  public Block(int x, int y, int z, int blockWidth, int blockHeight, int blockDepth, color col, Hall hall) {
    this.x = x;
    this.y = y;
    this.z = z;
    this.blockWidth = blockWidth;
    this.blockHeight = blockHeight;
    this.blockDepth = blockDepth;
    this.col = col;
    this.hall = hall;
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
    return blockWidth;
  }
  
  public int getHeight() {
     return blockHeight;
  }
  
  public int getDepth() {
    return blockDepth;
  }
  
  public boolean intersect(Intersectable object) {
    return false;
  }
  
  public void drawMe() {
    pushMatrix();
    
    translate(x, y, z);
    fill(col);
    box(blockWidth, blockHeight, blockDepth);
    popMatrix();
  }
}
