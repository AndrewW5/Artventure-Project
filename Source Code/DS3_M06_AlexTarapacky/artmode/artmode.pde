// DS3 Milestone 6
// Alex Tarapacky
// March 14, 2014
// JRAA Studios

// *************************************************
// Resolved issues in the color picker
// Created a buffer for the art application
// Screen tapping buttons is working
// *************************************************

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

PGraphics buffer;

// Art assets 
PImage bannerTop, newButton, redColorImg;
PImage brushIncrease, brushDecrease, regularBrush, pawShape, caligBrush;
PImage cursor;

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
  cp = new colorPicker(10, 10, 400, 400, 0);
  // Load Images
  resourceLoader = new ResourceLoader();
  bannerTop = resourceLoader.getImage("bannerTop.png");
  newButton = resourceLoader.getImage("newButton.png");
  brushIncrease = resourceLoader.getImage("brushIncrease.png");
  brushDecrease = resourceLoader.getImage("brushDecrease.png");
  regularBrush = resourceLoader.getImage("regularBrush.png");
  caligBrush = resourceLoader.getImage("caligBrush.png");
  pawShape = resourceLoader.getImage("pawShape.png");
  cursor = resourceLoader.getImage("cursor.png");
  
  buffer = createGraphics(1080, 576);
}

public void draw() {
  background(255);
  
  image(bannerTop, 0, 0);
  image(newButton, 190, 86, 142, 50);
  image(brushDecrease, 350, 86, 50, 50);
  image(brushIncrease, 410, 86, 50, 50);
  image(regularBrush, 470, 86, 50, 50);
  image(caligBrush, 530, 86, 50, 50);
  image(pawShape, 590, 86, 50, 50);
  // cursor
  image(cursor, lastFingerPos.x - 25, lastFingerPos.y + 115, 50, 50);

  // Render colour palette
  cp.render();
  
// *************************************************
// DRAWING ON NEW BUFFER
// *************************************************

  //Off-screen buffer for drawing features
  buffer.beginDraw();    

    ArrayList<Finger> fingerList = leap.getFingerList();
    if (fingerList.size() > 0) {
    PVector fingerPos = leap.getTip(fingerList.get(0));
      // PUSH TO DRAW:
      if(fingerPos.z < -300){
        println("/// FINGER OUT at   " + fingerPos.z);
        ArrayList<PVector> points = getInterpolatedPoints(lastFingerPos, fingerPos, 2);
        for (PVector fingerVector: points) { 
           buffer.pushMatrix();
              buffer.noStroke();
              buffer.rotate(radians(bAngle)); // brush rotation (bAngle is currently at 0)
              buffer.ellipse(fingerVector.x, fingerVector.y, bW, bH);
           buffer.popMatrix();
        }
        lastFingerPos = fingerPos;
      }
      // PULL BACK TO POINT
      else if(fingerPos.z >= -300){
        println("/// FINGER IN");
        lastFingerPos = fingerPos;
      }
    println("X:  " + lastFingerPos.x + "  Y: " + lastFingerPos.y);
   }
    
  buffer.endDraw();
  image(buffer, 0, 144);   

// *************************************************
// BUTTON SCREEN TAPPING
// *************************************************

  if (gestureTest == true){
       // NEW BUTTON
       if(lastFingerPos.x > 190 && lastFingerPos.x < 340 && lastFingerPos.y > -59 && lastFingerPos.y < -8) {
          if (gestureTest = true){
            buffer.background(255); // New Button: Clear the screen
            
            println("Cleared Screen"); 
          }
          image(cursor, lastFingerPos.x - 25, lastFingerPos.y + 115, 50, 50);
        }
        // DECREASE SIZE
        if(lastFingerPos.x > 329 && lastFingerPos.x < 401 && lastFingerPos.y > -59 && lastFingerPos.y < -8) {
          bW = bW/1.5;
          bH = bH/1.5;
          println("Brush Decrease. Brush size: " + bW + " by " + bH);
        }
        // INCREASE SIZE
        if(lastFingerPos.x > 409 && lastFingerPos.x < 461 && lastFingerPos.y > -59 && lastFingerPos.y < -8) {
          bW = bW*1.5;
          bH = bH*1.5;
          println("Brush Increase. Brush size: " + bW + " by " + bH);
        }
        // REGULAR BRUSH
        if(lastFingerPos.x > 469 && lastFingerPos.x < 521 && lastFingerPos.y > -59 && lastFingerPos.y < -8) {
          bAngle = 0;
          bW = 10;
          bH = 10;
          println("Regular brush");
        }
        // CALIGRAPHY BRUSH
        if(lastFingerPos.x > 529 && lastFingerPos.x < 581 && lastFingerPos.y > -59 && lastFingerPos.y < -8) {
          bAngle = 15;
          bW = 5;
          bH = 40;
          println("Calligraphy brush");
        }
        // PAW BRUSH
        if(lastFingerPos.x > 589 && lastFingerPos.x < 641 && lastFingerPos.y > -59 && lastFingerPos.y < -8) {
          image(pawShape, lastFingerPos.x, lastFingerPos.y, 50, 50);
          println("Calligraphy brush");
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
    System.out.println("//////////////////////////////////////");
    System.out.println("Gesture type: " + gesture.type());
    System.out.println("ID: " + gesture.id());
    System.out.println("Position: " + leap.vectorToPVector(gesture.position()));
    System.out.println("Direction: " + gesture.direction());
    System.out.println("Duration: " + gesture.durationSeconds() + "s");
    System.out.println("//////////////////////////////////////");
    System.out.println("//////////////////////////////////////");
  } 
  
  else {
    gestureTest = false;
  }//gestureTest = false;
}

void mousePressed(){
  // NEW BUTTON
  if(mouseX > 12 && mouseX < 153 && mouseY > 86 && mouseY < 136) {
    background(255); // New Button: Clear the screen
    println("Cleared Screen"); 
  }
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

