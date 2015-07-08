
import java.util.Vector;

public class FrameProcessor extends Thread {
   
   private Thread thread;
   private Thread coThread;
   private PImage inputImage;
   private PImage lastOutput;
   private int[] coordinates = { width/2, height/2 };
   private PImage output;
   private boolean running;
   int delay = 0;
  
   public FrameProcessor() {
     thread = this;
     running = false;
     output = null;
     lastOutput = null;
   }
   
   public void setDelay(int delay) {
     this.delay = delay; 
   }
   
   public PImage getCurrent() {
     if(output == null) {
        return output; 
     }
     return lastOutput;
   }
   
   public void attachImage(PImage image) {
     if(inputImage == null)
       inputImage = image;
       running = true;
   }
   
   //Causing flickering, just an overloaded processor
   public void process() {
     if(inputImage != null) {
       //println("Processing");
       inputImage.resize(inputImage.width/8, inputImage.height/8);
       lastOutput = output;
       output = null;
       PImage temp = new PImage(inputImage.width, inputImage.height, ARGB);
       temp.loadPixels();
        for (int y = 0; y < inputImage.height; y++) {
          for (int x = 0; x < inputImage.width; x++) {
            float sum = 0;
            int pos = y*inputImage.width + x;
            if(red(inputImage.pixels[pos])+32 >= (blue(inputImage.pixels[pos])/1.39 + green(inputImage.pixels[pos])/1.41)
              && red(inputImage.pixels[pos]) > 200 || red(inputImage.pixels[pos]) == 255) {
              sum = 255;
            } else {
              sum = color(0, 0, 0, 0);
            }
            temp.pixels[y*inputImage.width +(inputImage.width -1 - x)] = color(sum, 0, 0);//color(sum, 0, 0);//color(sum, sum, sum);
          }
        }
        inputImage = null;
        output = temp;
        running = false;
      }
    }
    
    public void run() {
      while(true) {
        synchronized(this) {
          try{
             //println("Waiting");
             this.wait();
             process();
          } catch(InterruptedException e) {
            e.printStackTrace(); 
          }
        }
      }
    }
}
