// JRAA Studios
// Artventure Source Code
// Created by Andrew Wardell, Alex Tarapacky, Rebecca Riseberry, Jessica Fox
// Revision V1.0 January 29, 2014
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

int brushStroke = 10;
color blackColor = color(0);
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

PFont font;
ResourceLoader resourceLoader;
PImage bannerTop, newButton, selectBrush, strokeDecrease, strokeIncrease; 
PImage blackColorImg, redColorImg, yellowColorImg, greenColorImg, blueColorImg, rainbowColorImg;

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
    PVector fingerPos = leap.getTip(finger);
    float thickness = dist (pmouseX, pmouseY, mouseX, mouseY);
    thickness = map(thickness,0.0,400.0,1.0,40.0);
    thickness = max(thickness,1.0);
    thickness = min(thickness,20.0);
    strokeWeight(brushStroke);
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
    strokeWeight(brushStroke);
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
    brushStroke --; // Minus Button: Stroke Weight Decreased
    println("Brush Stroke is " + brushStroke);
  }
  if(mouseX > 554 && mouseX < 598 && mouseY > 86 && mouseY < 136) {
    brushStroke ++; // Plus Button: Stroke Weight Increased
    println("Brush Stroke is " + brushStroke);
  }
  if(mouseX > 298 && mouseX < 352 && mouseY > 20 && mouseY < 71){
    stroke(blackColor); // Button: Black Colour Box
    println("Black Colour selected");
  }
  if(mouseX > 352 && mouseX < 394 && mouseY > 20 && mouseY < 71){
    stroke(redColor); // Button: Red Colour Box
    println("Red Colour selected");
  }
  if(mouseX > 400 && mouseX < 445 && mouseY > 20 && mouseY < 71){
    stroke(yellowColor); // Button: Yellow Colour Box
    println("Yellow Colour selected");
  }
  if(mouseX > 453 && mouseX < 505 && mouseY > 20 && mouseY < 71){
    stroke(greenColor); // Button: Green Colour Box
    println("Green Colour selected");
  }
  if(mouseX > 508 && mouseX < 550 && mouseY > 20 && mouseY < 71){
    stroke(blueColor); // Button: Blue Colour Box
    println("Blue Colour selected");
  }
  if(mouseX > 555 && mouseX < 600 && mouseY > 20 && mouseY < 71){
    stroke ( random(0, 255), random(255), random(255) ); // Button: Rainbow Colour Box
    println("Stroke colour randomized");
  }
  // Reset Brush Stroke
  if (brushStroke < 0) { 
    brushStroke = 3;
    println("Stroke Reset");
  } else if (brushStroke > 99) {
    brushStroke = 3;
    println("Stroke Reset");
  }
}
// Backup key commands
void keyPressed() {
  if (key == 'c' || key == 'n') {
    background(255); // Clear the screen
    println("Cleared Screen"); 
  } else if (key == '+' || key == '[') {
    brushStroke ++; // Stroke Weight Increased
    println("Brush Stroke is " + brushStroke);
  } else if (key == '-' || key == ']') {
    brushStroke --; // Stroke Weight Decreased
    println("Brush Stroke is " + brushStroke);
  } else if (key == '*') {
    stroke ( random(0, 255), random(255), random(255) ); // Rainbow Colour Box
    println("Stroke colour randomized");
  }
  // Reset Brush Stroke
  if (brushStroke < 0) {
    brushStroke = 3;
    println("Stroke Reset");
  } else if (brushStroke > 99) {
    brushStroke = 3;
    println("Stroke Reset");
  }
}
// Disconnect Leap Motion device
public void stop() {
  leap.stop();
}
