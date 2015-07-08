import javax.media.opengl.*;
import processing.opengl.*;

Hall hall;
Paddle paddle;
Ball ball;
CamProcessor camProcessor;
FrameProcessor frameProcessor;

PImage image = null;

void setup() {
  int x = 640, y = 360, z = -200;
  frameRate(48);
  size(1280, 720, OPENGL);
  
  hall = new Hall(width, height, 3000);
  paddle = new Paddle(x, y, color(255, 255, 255, 128), hall);
  ball = new Ball(40, -30, x, y, -500, color(255, 0, 0), hall);
  ball.setXVelocity(5);
  Capture cam = new Capture(this, Capture.list()[0]);
  frameProcessor = new FrameProcessor();
  camProcessor = new CamProcessor(cam, frameProcessor, 50);
  lights();
  createBlocks();
  camProcessor.start();
  frameProcessor.start();
}

void createBlocks() {
  hall.addBlock(new Block(500, 600, -1000, 200, 200, 100, color(0, 255, 0), hall));
  hall.addBlock(new Block(700, 500, -1500, 200, 200, 100, color(0, 255, 0), hall));
  hall.addBlock(new Block(800, 600, -1000, 200, 200, 100, color(0, 255, 0), hall));
  hall.addBlock(new Block(500, 0, -1300, 200, 200, 100, color(0, 255, 0), hall));
  hall.addBlock(new Block(300, 600, -1300, 200, 200, 100, color(0, 0, 255), hall));
  hall.addBlock(new Block(1000, 400, -1300, 200, 200, 100, color(0, 128, 128), hall));
  hall.addBlock(new Block(500, 100, -1300, 200, 200, 100, color(0, 192, 64), hall));
}

void draw() {
    background(color(75, 80, 105));
    //Retrieving the camera image has to be done here
    //Attach the image to the processor and start it
    //Notifies the frameprocessor to work on the image
    PImage image = camProcessor.scanCam();
    frameProcessor.attachImage(image);
    synchronized(frameProcessor) {
      frameProcessor.notify();
    }

    hall.drawMe();
    ball.drawMe();
    paddle.drawMe();
    
    hall.intersect(ball);
    hall.checkBallAndBlockOverlap(ball);
    if(paddle.intersect(ball)) {
      paddle.calculateRebound(ball);
    }
    image = frameProcessor.getCurrent();
    if(image != null) {
      paddle.setBasedOnImage(image);
      image(image, 0, 0);
    }
}
