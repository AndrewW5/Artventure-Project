// JRAA STUDIOS
// COLOUR IMPLEMENTATION
// Alex Tarapacky
// Milestone 02 - Fri Feb 7

import com.onformative.leap.LeapMotionP5;
import com.leapmotion.leap.Finger;
import com.leapmotion.leap.Hand;
import com.leapmotion.leap.Gesture.State;
import com.leapmotion.leap.CircleGesture;
import com.leapmotion.leap.KeyTapGesture;
import com.leapmotion.leap.ScreenTapGesture;
import com.leapmotion.leap.SwipeGesture;
import com.leapmotion.leap.Gesture.Type;

LeapMotionP5 leap;

String lastGesture =
"enabling gestures: \n'c' for CircleGesture\n's' for SwipeGesture\n'k' for KeyTapGesture\n't' for ScreenTapGesture";

// Art assets 
PImage bannerTop, newButton, redColorImg;
PImage brushIncrease, brushDecrease;

// brush attributes
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

void setup() {
  size (1080, 720);
  background(255);
  
  leap = new LeapMotionP5(this);
  leap.enableGesture(Type.TYPE_SCREEN_TAP);
  cp = new colorPicker( 10, 10, 400, 400, 255 );
  
  //load Images
  resourceLoader = new ResourceLoader();
  bannerTop = resourceLoader.getImage("bannerTop.png");
  newButton = resourceLoader.getImage("newButton.png");
  brushIncrease = resourceLoader.getImage("brushIncrease.png");
  brushDecrease = resourceLoader.getImage("brushDecrease.png");
  redColorImg = resourceLoader.getImage("redColour.png");
}

// SCREEN TAP GESTURE
public void screenTapGestureRecognized(ScreenTapGesture gesture) {
  if (gesture.state() == State.STATE_STOP) {
    //gestureTest = false;
    println("OOOOOOOOO");
    /*println("//////////////////////////////////////");
    println("Gesture type: " + gesture.type());
    println("ID: " + gesture.id());
    println("Position: " + leap.vectorToPVector(gesture.position()));
    println("Direction: " + gesture.direction());
    println("Duration: " + gesture.durationSeconds() + "s");
    println("//////////////////////////////////////");
    lastGesture = "Gesture type: " + gesture.type().toString() + "\n";
    lastGesture += "ID: " + gesture.id() + "\n";
    lastGesture += "Position: " + leap.vectorToPVector(gesture.position()) + "\n";
    lastGesture += "Direction: " + gesture.direction() + "\n";
    lastGesture += "Duration: " + gesture.durationSeconds() + "s" + "\n";*/
    
  } 
  if (gesture.state() == State.STATE_START) {
    //gestureTest = true;
    println("IIIIIIIIII");
  } 
  if (gesture.state() == State.STATE_UPDATE) {
    //gestureTest = true;
    println("EEEEEE");
  }
  
}


void draw() {
    
   if(gestureTest == true){
     //println("YEYEYEYEYYE");
     
     
    // ********* DRAWING CODE 
    ArrayList<Finger> fingerList = leap.getFingerList();
    if (fingerList.size() > 0) {
      PVector fingerPos = leap.getTip(fingerList.get(0));
      if (lastFingerPos.x <= -1000) {
        lastFingerPos = fingerPos;
      }
      ArrayList<PVector> points = getInterpolatedPoints(lastFingerPos, fingerPos, 2);
      for (PVector fingerVector: points) { 
        pushMatrix();
        noStroke();
          rotate(radians(bAngle)); // brush rotation (bAngle is currently at 0)
          ellipse(fingerVector.x, fingerVector.y, bW, bH);
        popMatrix();
      }
      lastFingerPos = fingerPos;
    } else {
      lastFingerPos.x = -1000;
    }
    // ********* END OF DRAWING CODE 
    
    
    
     
    // gestureTest = false;
   }
   else{
     //println("FALSE");
   }
   
  
   
  // Load Images
  image(bannerTop, 0, 0);
  image(newButton, 12, 86, 142, 50);
  image(brushIncrease, 555, 86, 50, 50);
  image(brushDecrease, 498, 86, 50, 50);
  image(redColorImg, 612, 86, 50, 50);
  
  // Render colour palette
  cp.render();
}




void mousePressed(){
  // NEW BUTTON
  if(mouseX > 12 && mouseX < 153 && mouseY > 86 && mouseY < 136) {
    background(255); // New Button: Clear the screen
    println("Cleared Screen"); 
  }
  // DECREASE SIZE
  if(mouseX > 498 && mouseX < 545 && mouseY > 86 && mouseY < 136) {
    bW = bW/1.5;
    bH = bH/1.5;
    println("Brush Decrease. Brush size: " + bW + " by " + bH);
  }
  // INCREASE SIZE
  if(mouseX > 554 && mouseX < 598 && mouseY > 86 && mouseY < 136) {
    bW = bW*1.5;
    bH = bH*1.5;
    println("Brush Increase. Brush size: " + bW + " by " + bH);
  }
  // CALLIGRAPHY BRUSH
  if(mouseX > 611 && mouseX < 663 && mouseY > 86 && mouseY < 136) {
    bAngle = 15;
    bW = 5;
    bH = 40;
    println("Calligraphy brush");
  }
}

// Backup key commands
void keyPressed() {
  if (key == 'c' || key == 'n') {
    background(255); // Clear the screen
    println("Cleared Screen"); 
  }
 else if (key == '+' || key == '[') {
    bW = bW*1.5;
    bH = bH*1.5;
    println("Brush Increase. Brush size: " + bW + " by " + bH);
  } 
  else if (key == '-' || key == ']') { 
    bW = bW/1.5;
    bH = bH/1.5;
    println("Brush Decrease. Brush size: " + bW + " by " + bH);
  }
}

// Disconnect Leap Motion device
public void stop() {
  leap.stop();
}
