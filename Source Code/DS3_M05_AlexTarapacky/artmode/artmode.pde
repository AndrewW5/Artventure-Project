// DS3 Milestone 5
// Alex Tarapacky
// March 7, 2014
// JRAA Studios


import com.onformative.leap.LeapMotionP5;
import com.leapmotion.leap.Finger;
import com.leapmotion.leap.Hand;
import com.leapmotion.leap.Gesture.State;
import com.leapmotion.leap.Gesture.Type;
import com.leapmotion.leap.ScreenTapGesture;
//import com.leapmotion.leap.CircleGesture;
//import com.leapmotion.leap.KeyTapGesture;
//import com.leapmotion.leap.SwipeGesture;

LeapMotionP5 leap;

// Art assets 
PImage bannerTop, newButton, redColorImg;
PImage brushIncrease, brushDecrease, regularBrush, pawShape, caligBrush;
// Brush attributes
float bW = 10; // brush width for ellipse
float bH = 10; // brush height for ellipse
float bAngle = 0; // brush angle

ResourceLoader resourceLoader;
colorPicker cp;

PVector lastFingerPos = new PVector(-1000, 1000);

Boolean gestureTest = false;

ArrayList<PVector> getInterpolatedPoints(PVector pt1, PVector pt2, float spacing) {
  PVector drawLine = PVector.sub(pt2,pt1);
  float len = drawLine.mag();
  drawLine.normalize();
  float numSteps = (len / spacing);
  drawLine.mult(spacing);
  ArrayList<PVector> ptList = new ArrayList<PVector>();
  PVector stepPoint = pt1.get();
  for (int i = 0; i < numSteps; i++) {
    ptList.add(stepPoint.get());
    stepPoint.add(drawLine);
  }  
  return ptList;
}

public void setup() {
  size (1080, 720);
  background(255);
  leap = new LeapMotionP5(this);
  leap.enableGesture(Type.TYPE_SCREEN_TAP);
  cp = new colorPicker(10, 10, 400, 400, 255);
  // Load Images
  resourceLoader = new ResourceLoader();
  bannerTop = resourceLoader.getImage("bannerTop.png");
  newButton = resourceLoader.getImage("newButton.png");
  brushIncrease = resourceLoader.getImage("brushIncrease.png");
  brushDecrease = resourceLoader.getImage("brushDecrease.png");
  regularBrush = resourceLoader.getImage("regularBrush.png");
  caligBrush = resourceLoader.getImage("caligBrush.png");
  pawShape = resourceLoader.getImage("pawShape.png");
}

public void draw() {
  // Draw Images
  image(bannerTop, 0, 0);
  image(newButton, 190, 86, 142, 50);
  image(brushDecrease, 350, 86, 50, 50);
  image(brushIncrease, 410, 86, 50, 50);
  image(regularBrush, 470, 86, 50, 50);
  image(caligBrush, 530, 86, 50, 50);
  image(pawShape, 590, 86, 50, 50);
  // Render colour palette
  cp.render();

  ArrayList<Finger> fingerList = leap.getFingerList();
    
  if (fingerList.size() > 0) {
  PVector fingerPos = leap.getTip(fingerList.get(0));
  
  
// *************************************************          
// ScreenTap wont work for drawing because it requires a tap (quick forward & back motion)
// ScreenTap can be used for buttons 
// To draw we need to track the z-position of the finger (push in to draw, out to move cursor)
// I set it to z < -300 to push, but you can change it if its too far / too close
// *************************************************

    // PUSH TO DRAW:
    if(fingerPos.z < -300){
      println("/// FINGER OUT at   " + fingerPos.z);
      ArrayList<PVector> points = getInterpolatedPoints(lastFingerPos, fingerPos, 2);
      for (PVector fingerVector: points) { 
         pushMatrix();
            noStroke();
            rotate(radians(bAngle)); // brush rotation (bAngle is currently at 0)
            ellipse(fingerVector.x, fingerVector.y, bW, bH);
         popMatrix();
      }
      lastFingerPos = fingerPos;
    }
    // PULL BACK TO POINT
    else if(fingerPos.z >= -300){
      println("/// FINGER IN");
      lastFingerPos = fingerPos;
    }

    // PAW BRUSH
    if(mouseX > 590 && mouseX < 640 && mouseY > 86 && mouseY < 136) {
      image(pawShape, fingerPos.x, fingerPos.y, 50, 50);
      println("Calligraphy brush");
    }
    
// *************************************************
// Below is for the screenTap on the "New" button
// Kinda works... but its pretty sketchy
// *************************************************

   println("X:  " + fingerPos.x + "  Y: " + fingerPos.y);
   // NEW BUTTON
   if(fingerPos.x > 190 && fingerPos.x < 340 && fingerPos.y > 100 && fingerPos.y < 120) {
      if (gestureTest = true){
        background(255); // New Button: Clear the screen
        println("Cleared Screen"); 
      }
    }
    // DECREASE SIZE
    if(mouseX > 350 && mouseX < 400 && mouseY > 86 && mouseY < 136) {
      if (gestureTest = true){
      bW = bW/1.5;
      bH = bH/1.5;
      println("Brush Decrease. Brush size: " + bW + " by " + bH);
      }
    }
    // INCREASE SIZE
    if(mouseX > 410 && mouseX < 460 && mouseY > 86 && mouseY < 136) {
      if (gestureTest = true){
      bW = bW*1.5;
      bH = bH*1.5;
      println("Brush Increase. Brush size: " + bW + " by " + bH);
      }
    }
    // REGULAR BRUSH
    if(mouseX > 470 && mouseX < 520 && mouseY > 86 && mouseY < 136) {
      if (gestureTest = true){
      bAngle = 0;
      bW = 10;
      bH = 10;
      println("Calligraphy brush");
      }
    }
    // CALLIGRAPHY BRUSH
    if(mouseX > 530 && mouseX < 580 && mouseY > 86 && mouseY < 136) {
      if (gestureTest = true){
      bAngle = 15;
      bW = 5;
      bH = 40;
      println("Calligraphy brush");
      }
    }
  }
}

// SCREEN TAP
public void screenTapGestureRecognized(ScreenTapGesture gesture) { 
  // Handles starting gestures 
  if (gesture.state() == State.STATE_START) {
    gestureTest = false;
  } 
  // Handles continuing gestures
  if (gesture.state() == State.STATE_UPDATE) {
    gestureTest = false;
  }
  // Handles ending gestures
  if (gesture.state() == State.STATE_STOP) { 
    gestureTest = true;
    println(gesture);
    System.out.println("//////////////////////////////////////");
    System.out.println("Gesture type: " + gesture.type());
    System.out.println("ID: " + gesture.id());
    System.out.println("Position: " + leap.vectorToPVector(gesture.position()));
    System.out.println("Direction: " + gesture.direction());
    System.out.println("Duration: " + gesture.durationSeconds() + "s");
    System.out.println("//////////////////////////////////////");
  } 
  else {
    gestureTest = false;
  }
}

void mousePressed(){
  // NEW BUTTON
  /*if(mouseX > 12 && mouseX < 153 && mouseY > 86 && mouseY < 136) {
    background(255); // New Button: Clear the screen
    println("Cleared Screen"); 
  }*/
  // DECREASE SIZE
  if(mouseX > 350 && mouseX < 400 && mouseY > 86 && mouseY < 136) {
    bW = bW/1.5;
    bH = bH/1.5;
    println("Brush Decrease. Brush size: " + bW + " by " + bH);
  }
  // INCREASE SIZE
  if(mouseX > 410 && mouseX < 460 && mouseY > 86 && mouseY < 136) {
    bW = bW*1.5;
    bH = bH*1.5;
    println("Brush Increase. Brush size: " + bW + " by " + bH);
  }
  // REGULAR BRUSH
  if(mouseX > 470 && mouseX < 520 && mouseY > 86 && mouseY < 136) {
    bAngle = 0;
    bW = 10;
    bH = 10;
    println("Calligraphy brush");
  }
  // CALLIGRAPHY BRUSH
  if(mouseX > 530 && mouseX < 580 && mouseY > 86 && mouseY < 136) {
    bAngle = 15;
    bW = 5;
    bH = 40;
    println("Calligraphy brush");
  }
  // PAW BRUSH - see above
}

public void keyPressed() {
/*
  if (key == 't') {
    if (leap.isEnabled(Type.TYPE_SCREEN_TAP)) {
      leap.disableGesture(Type.TYPE_SCREEN_TAP);
      lastGesture = "ScreenTap Gesture disabled. ";
    } 
    else {
      leap.enableGesture(Type.TYPE_SCREEN_TAP);
      lastGesture = "ScreenTap Gesture enabled. ";
    }
  }
 if (key == 'c' || key == 'n') {
    background(255); // Clear the screen
    println("Cleared Screen"); 
  }
  if (key == '+' || key == '[') {
    bW = bW*1.5;
    bH = bH*1.5;
    println("Brush Increase. Brush size: " + bW + " by " + bH);
  } 
  if (key == '-' || key == ']') { 
    bW = bW/1.5;
    bH = bH/1.5;
    println("Brush Decrease. Brush size: " + bW + " by " + bH);
  }
  */
}

public void stop() {
  leap.stop();
}

