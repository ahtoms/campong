
import java.util.Vector;

public class Hall implements Intersectable, Drawable {
  
  public int hallWidth;
  public int hallHeight;
  public int hallDepth;
  
  private Vector<Block> blocks;
  
  public Hall(int hallWidth, int hallHeight, int hallDepth) {
    this.hallWidth = hallWidth;
    this.hallHeight = hallHeight;
    this.hallDepth = hallDepth;
    blocks = new Vector<Block>();
  } 
  
  public boolean removeBlock(Block block) {
    blocks.remove(block);
    return blocks.isEmpty(); 
  }
  
  public void addBlock(Block block) {
    blocks.add(block); 
  }
  
  public int getX() {
    return 0; 
  }
  
  public int getY() {
    return 0; 
  }
  
  public int getZ() {
    return 0;
  }
  
  public int getWidth() {
    return hallWidth;
  }
  
  public int getHeight() {
     return hallHeight;
  }
  
  public int getDepth() {
    return hallDepth;
  }
  
  public void drawMe() {
    pushMatrix();
    translate(width/2, height/2, 0);
    fill(51);
    stroke(255);
    rotateX(PI);
    
    //Bottom wall
    beginShape();
    vertex(-(width/2), -(height/2), 0); //Base
    vertex(width/2, -(height/2), 0);
    vertex(width/2, -(height/1.5), hallDepth);
    vertex(-(width/2), -(height/1.5), hallDepth);
    vertex(-(width/2), -(height/2), 0);
    endShape();
    
    //Top wall
    beginShape();
    vertex((width/2), (height/2), 0); //Base
    vertex(-(width/2), (height/2), 0);
    vertex(-(width/2), (height/1.5), hallDepth);
    vertex((width/2), (height/1.5), hallDepth);
    vertex((width/2), (height/2), 0);
    endShape();
    
    //Left wall
    beginShape();
    vertex(-(width/2), -(height/2), 0); //Base
    vertex(-(width/2), (height/2), 0);
    vertex(-(width/2), (height/1.5), hallDepth);
    vertex(-(width/2), -(height/1.5), hallDepth);
    vertex(-(width/2), -(height/2), 0);
    endShape();
    
    //Right wall
    beginShape();
    vertex((width/2), -(height/2), 0); //Base
    vertex((width/2), (height/2), 0);
    vertex((width/2), (height/1.5), hallDepth);
    vertex((width/2), -(height/1.5), hallDepth);
    vertex((width/2), -(height/2), 0);
    endShape();
    
    //End wall
    beginShape();
    fill(color(64, 128, 156));
    vertex(-(width/2), -(height/1.5), hallDepth); //Base
    vertex((width/2), -(height/1.5), hallDepth);
    vertex((width/2), (height/1.5), hallDepth);
    vertex(-(width/2), (height/1.5), hallDepth);
    vertex(-(width/2), -(height/1.5), hallDepth);
    endShape();
    
    popMatrix();
    
    for(int i = 0; i < blocks.size(); i++) {
      blocks.get(i).drawMe(); 
    }
  }
  
  public boolean intersect(Intersectable object) {
    Ball ball = null;
    if(object.getX() >= (getX() + getWidth()) || object.getX() <= getX()) {
      if(object instanceof Ball) {
         ball = (Ball) object;
         ball.setXVelocity(-ball.getXVelocity());
      }
    }
    else if(object.getY() >= (getY() + getHeight()) || object.getY() <= getY()) {
      if(object instanceof Ball) {
         ball = (Ball) object;
         ball.setYVelocity(-ball.getYVelocity());
      }
    }
    else if(-object.getZ() >= (getZ() + getDepth())) {
       if(object instanceof Ball) {
         ball = (Ball) object;
         ball.setZVelocity(-ball.getZVelocity());
       }
    }
    return false;
  }
  
  public boolean checkBallAndBlockOverlap(Ball ball) {
    int intersectionDepth = 3;
    for(int i = 0; i < blocks.size(); i++) {
      if(ball.intersect(blocks.get(i))) {
        //Decide the face
        //faces
        
        if(ball.getX() - (ball.getWidth()/2) < (blocks.get(i).getX() + blocks.get(i).getWidth()/2) &&
           (ball.getX() + ball.getWidth()/2) >  (blocks.get(i).getX() - (blocks.get(i).getWidth()/2)) &&
           ball.getY() - (ball.getHeight()/2) < (blocks.get(i).getY() + (blocks.get(i).getHeight()/2)) &&
           (ball.getY() + (ball.getHeight()/2)) > blocks.get(i).getY() - (blocks.get(i).getHeight()/2) &&
           ball.getZ() - (ball.getDepth()/2) < (blocks.get(i).getZ() - blocks.get(i).getDepth()/2)+intersectionDepth &&
           (ball.getZ() + ball.getDepth()/2) > (blocks.get(i).getZ() - (blocks.get(i).getDepth()/2))) {
              
               ball.setZVelocity(-ball.getZVelocity()); 
              
            }
        if(ball.getX() - (ball.getWidth()/2) < (blocks.get(i).getX() + blocks.get(i).getWidth()/2) &&
           (ball.getX() + ball.getWidth()/2) >  (blocks.get(i).getX() - (blocks.get(i).getWidth()/2)) &&
           ball.getY() - (ball.getHeight()/2) < (blocks.get(i).getY() + (blocks.get(i).getHeight()/2)) &&
           (ball.getY() + (ball.getHeight()/2)) > blocks.get(i).getY() - (blocks.get(i).getHeight()/2) &&
           ball.getZ() - (ball.getDepth()/2) < (blocks.get(i).getZ() + blocks.get(i).getDepth()/2) &&
           (ball.getZ() + ball.getDepth()/2) > (blocks.get(i).getZ() + (blocks.get(i).getDepth()/2))-intersectionDepth) {
              
               ball.setZVelocity(-ball.getZVelocity()); 
              
            }
        if(ball.getX() - (ball.getWidth()/2) < (blocks.get(i).getX() + blocks.get(i).getWidth()/2) &&
           (ball.getX() + ball.getWidth()/2) >  (blocks.get(i).getX() - (blocks.get(i).getWidth()/2)) &&
           ball.getY() - (ball.getHeight()/2) < (blocks.get(i).getY() - (blocks.get(i).getHeight()/2)+intersectionDepth) &&
           (ball.getY() + (ball.getHeight()/2)) > blocks.get(i).getY() - (blocks.get(i).getHeight()/2) &&
           ball.getZ() - (ball.getDepth()/2) < (blocks.get(i).getZ() + blocks.get(i).getDepth()/2) &&
           (ball.getZ() + ball.getDepth()/2) > (blocks.get(i).getZ() - (blocks.get(i).getDepth()/2))) {
              
               ball.setYVelocity(-ball.getYVelocity()); 
              
            }
        if(ball.getX() - (ball.getWidth()/2) < (blocks.get(i).getX() + blocks.get(i).getWidth()/2) &&
           (ball.getX() + ball.getWidth()/2) >  (blocks.get(i).getX() - (blocks.get(i).getWidth()/2)) &&
           ball.getY() - (ball.getHeight()/2) < (blocks.get(i).getY() + (blocks.get(i).getHeight()/2)) &&
           (ball.getY() + (ball.getHeight()/2)) > (blocks.get(i).getY() + (blocks.get(i).getHeight()/2)-intersectionDepth) &&
           ball.getZ() - (ball.getDepth()/2) < (blocks.get(i).getZ() + blocks.get(i).getDepth()/2) &&
           (ball.getZ() + ball.getDepth()/2) > (blocks.get(i).getZ() - (blocks.get(i).getDepth()/2))) {
              
               ball.setYVelocity(-ball.getYVelocity()); 
              
            }
            
        if(ball.getX() - (ball.getWidth()/2) < ((blocks.get(i).getX() - blocks.get(i).getWidth()/2)+intersectionDepth) &&
           (ball.getX() + ball.getWidth()/2) >  (blocks.get(i).getX() - (blocks.get(i).getWidth()/2)) &&
           ball.getY() - (ball.getHeight()/2) < (blocks.get(i).getY() + (blocks.get(i).getHeight()/2)) &&
           (ball.getY() + (ball.getHeight()/2)) > (blocks.get(i).getY() - (blocks.get(i).getHeight()/2)) &&
           ball.getZ() - (ball.getDepth()/2) < (blocks.get(i).getZ() + blocks.get(i).getDepth()/2) &&
           (ball.getZ() + ball.getDepth()/2) > (blocks.get(i).getZ() - (blocks.get(i).getDepth()/2))) {
              
               ball.setXVelocity(-ball.getXVelocity()); 
              
            }
        if(ball.getX() - (ball.getWidth()/2) < (blocks.get(i).getX() + blocks.get(i).getWidth()/2) &&
           (ball.getX() + ball.getWidth()/2) >  (blocks.get(i).getX() + (blocks.get(i).getWidth()/2)-intersectionDepth) &&
           ball.getY() - (ball.getHeight()/2) < (blocks.get(i).getY() + (blocks.get(i).getHeight()/2)) &&
           (ball.getY() + (ball.getHeight()/2)) > (blocks.get(i).getY() - (blocks.get(i).getHeight()/2)) &&
           ball.getZ() - (ball.getDepth()/2) < (blocks.get(i).getZ() + blocks.get(i).getDepth()/2) &&
           (ball.getZ() + ball.getDepth()/2) > (blocks.get(i).getZ() - (blocks.get(i).getDepth()/2))) {
              
               ball.setXVelocity(-ball.getXVelocity()); 
              
            }
        blocks.remove(i);
        i--;
      }
    } 
    return false;
    
  }
}
