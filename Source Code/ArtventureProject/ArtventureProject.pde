// JRAA Studios
// Artventure Source Code
// Members: Andrew Wardell, Alex Tarapacky, Rebecca Riseberry, Jessica Fox
// Revision V1.1 January 31, 2014
import com.onformative.leap.LeapMotionP5;
import com.leapmotion.leap.Finger;
import com.leapmotion.leap.Hand;
import com.leapmotion.leap.CircleGesture;
import com.leapmotion.leap.KeyTapGesture;
import com.leapmotion.leap.ScreenTapGesture;
import com.leapmotion.leap.SwipeGesture;
LeapMotionP5 leap;
String lastGesture =
"enabling gestures: \n'c' for CircleGesture\n's' for SwipeGesture\n'k' for KeyTapGesture\n't' for ScreenTapGesture";

int brushSize = 20;
color blackColor = color(0);
color whiteColor = color(255);
color redColor = color(255, 0, 0);
color yellowColor = color(247, 240, 0);
color greenColor= color(0, 255, 0);
color blueColor= color(0, 0, 255);

color orange= color(247, 112, 0);
color violet= color(110, 0, 220);
color blueGreen= color(0, 247, 146);
color yellowGreen= color(157, 250, 0);
color pink= color(255, 28, 97);
color yellowOrange= color(255, 159, 3);

ResourceLoader resourceLoader;
PFont font;
PImage bannerTop, newButton, selectBrush, strokeDecrease, strokeIncrease; 
PImage blackColorImg, redColorImg, yellowColorImg, greenColorImg, blueColorImg, rainbowColorImg;

ArrayList<PVector> getInterpolatedPoints(PVector pt1, PVector pt2) {
  PVector drawLine = PVector.sub(pt2,pt1);
  float len = drawLine.mag();
  drawLine.normalize();
  float stepSize = (len / 10.0);
  //drawLine.scale(stepSize);
  ArrayList<PVector> ptList = new ArrayList<PVector>();
  PVector stepPoint = pt1.get();
  for (int i = 0; i < 10; i++) {
    ptList.add(stepPoint.get());
    stepPoint.add(drawLine);
  }  
  return ptList;
} 
void setup() {
  size (1080, 720);
  background(255);
  font = createFont("FuturaStd-Medium-24.vlw",16,true);
  leap = new LeapMotionP5(this);
  
  // Resource Images
  resourceLoader = new ResourceLoader();
  bannerTop = resourceLoader.getImage("bannerTop.png");
  newButton = resourceLoader.getImage("newButton.png");
  selectBrush = resourceLoader.getImage("selectBrush.png");
  strokeDecrease = resourceLoader.getImage("strokeDecrease.png");
  strokeIncrease = resourceLoader.getImage("strokeIncrease.png");
  blackColorImg = resourceLoader.getImage("blackColour.png");
  redColorImg = resourceLoader.getImage("redColour.png");
  yellowColorImg = resourceLoader.getImage("yellowColour.png");
  greenColorImg = resourceLoader.getImage("greenColour.png");
  blueColorImg = resourceLoader.getImage("blueColour.png");
  rainbowColorImg = resourceLoader.getImage("rainbowColour.png");
}
void draw() {
  //println("Mouse X:"+ mouseX+ " Y:" + mouseY); // Mouse Positions
  // Finger Positions to draw
  for (Finger finger : leap.getFingerList()) {
    PVector fingerPos = leap.getTip(finger); // Finger = leap.getFinger(0); fingerPos = leap.getTip(finger);
    float thickness = dist (pmouseX, pmouseY, mouseX, mouseY);
    thickness = map(thickness,0.0,400.0,1.0,40.0);
    thickness = max(thickness,1.0);
    thickness = min(thickness,20.0);
    strokeWeight(brushSize);
    ellipse(fingerPos.x, fingerPos.y, 10, 10);
  }
  // Load Images
  image(bannerTop, 0, 0);
  image(newButton, 12, 86, 142, 50);
  image(selectBrush, 250, 86, 240, 50);
  image(strokeDecrease, 498, 86, 50, 50);
  image(strokeIncrease, 555, 86, 50, 50);
  image(blackColorImg, 298, 21, 50, 50);
  image(redColorImg, 352, 21, 50, 50);
  image(yellowColorImg, 401, 21, 50, 50);
  image(greenColorImg, 453, 21, 50, 50);
  image(blueColorImg, 505, 21, 50, 50);
  image(rainbowColorImg, 555, 21, 50, 50);
}
void mouseDragged() {
  // Draw with mouse
  if (mousePressed) {
    float thickness = dist (pmouseX, pmouseY, mouseX, mouseY);
    thickness = map(thickness,0.0,400.0,1.0,40.0);
    thickness = max(thickness,1.0);
    thickness = min(thickness,20.0);
    strokeWeight(brushSize);
    line (pmouseX, pmouseY, mouseX, mouseY);
  }
}
void mousePressed() {
  // ToolBar UI Area
  if(mouseX > 12 && mouseX < 153 && mouseY > 86 && mouseY < 136) {
    background(255); // New Button: Clear the screen
    println("Cleared Screen"); 
  }
  if(mouseX > 245 && mouseX < 487 && mouseY > 86 && mouseY < 136) {
    println("Select Brush"); // Select Brushes
  }
  if(mouseX > 498 && mouseX < 545 && mouseY > 86 && mouseY < 136) {
    brushSize --; // Minus Button: fill Weight Decreased
    println("Brush fill is " + brushSize);
  }
  if(mouseX > 554 && mouseX < 598 && mouseY > 86 && mouseY < 136) {
    brushSize ++; // Plus Button: fill Weight Increased
    println("Brush fill is " + brushSize);
  }
  if(mouseX > 298 && mouseX < 352 && mouseY > 20 && mouseY < 71){
    fill(blackColor); // Button: Black Colour Box
    stroke(blackColor);
    println("Black Colour selected");
  }
  if(mouseX > 352 && mouseX < 394 && mouseY > 20 && mouseY < 71){
    fill(redColor); // Button: Red Colour Box
    stroke(redColor);
    println("Red Colour selected");
  }
  if(mouseX > 400 && mouseX < 445 && mouseY > 20 && mouseY < 71){
    fill(yellowColor); // Button: Yellow Colour Box
    stroke(yellowColor);
    println("Yellow Colour selected");
  }
  if(mouseX > 453 && mouseX < 505 && mouseY > 20 && mouseY < 71){
    fill(greenColor); // Button: Green Colour Box
    stroke(greenColor);
    println("Green Colour selected");
  }
  if(mouseX > 508 && mouseX < 550 && mouseY > 20 && mouseY < 71){
    fill(blueColor); // Button: Blue Colour Box
    stroke(blueColor);
    println("Blue Colour selected");
  }
  if(mouseX > 555 && mouseX < 600 && mouseY > 20 && mouseY < 71){
    fill ( random(0, 255), random(255), random(255) ); // Button: Rainbow Colour Box
    stroke ( random(0, 255), random(255), random(255) );
    println("fill colour randomized");
  }
  // Reset Brush Size
  if (brushSize < 0) { 
    brushSize = 3;
    println("Weight Reset");
  } else if (brushSize > 200) {
    brushSize = 3;
    println("fill Reset");
  }
}
// Backup key commands
void keyPressed() {
  if (key == 'c' || key == 'n') {
    background(255); // Clear the screen
    println("Cleared Screen"); 
  } else if (key == '+' || key == ']') {
    brushSize ++; // Brush Weight Increased
    println("Brush Size is " + brushSize);
  } else if (key == '-' || key == '[') {
    brushSize --; // Brush Weight Decreased
    println("Brush Size is " + brushSize);
  } else if (key == '*') {
    fill ( random(0, 255), random(255), random(255) ); // Rainbow Colour Box
    stroke( random(0, 255), random(255), random(255) );
    println("Colour randomized");
  } else if (key == 'e') {
    fill(whiteColor);
    stroke(whiteColor);
  }
  // Reset Brush Size
  if (brushSize < 0) {
    brushSize = 3;
    println("Brush Size Reset");
  } else if (brushSize > 200) {
    brushSize = 3;
    println("Brush Size Reset");
  }
}
// Disconnect Leap Motion device
public void stop() {
  leap.stop();
}
