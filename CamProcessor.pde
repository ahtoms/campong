import processing.video.*;

public class CamProcessor implements Runnable {
  public Thread camThread;
  private FrameProcessor frameProcessor;
  private Capture cam;
  private int delay;
  
  public boolean running;
  
  public CamProcessor(Capture cam, FrameProcessor processor, int delay) {
    running = false;
    camThread = new Thread(this);
    frameProcessor = processor;
    this.cam = cam;
    this.delay = delay;
    cam.start();
  } 
  
  void start() {
    running = true;
    camThread.start();
  }
  
  void run() {
    scanCam();
  }
  
  PImage scanCam() {
    if(cam.available()) {
      cam.read();
      return cam.get();
    }
    return null;
  }
  
  void stop() {
    running = false;
    //camThread.stop();
  }
  
}
