// JRAA Studios
// Artventure Source Code - Home Page

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

ResourceLoader resourceLoader;

PImage homePageImage, pawCursorImage;

PVector lastFingerPos = new PVector(-1000, 1000);

void setup() {
  size (1080, 720); // Renderer
  
  leap = new LeapMotionP5(this);
  
  // Resource Images
  resourceLoader = new ResourceLoader();
  homePageImage = resourceLoader.getImage("homePageImage.jpg");
  pawCursorImage = resourceLoader.getImage("pawCursor.png");
  
} 
void draw() {  
  // Load Images
  image(homePageImage, 0, 0);
  
  // Creates a cursor at the mouse X and Y position
  pushMatrix();
    translate(mouseX, mouseY);
    cursor(pawCursorImage, 0, 0);
  popMatrix();
}
void mousePressed() {
  if(mouseX > 274 && mouseX < 804 && mouseY > 232 && mouseY < 310) {
    println("Art Mode");
  }
  if(mouseX > 274 && mouseX < 804 && mouseY > 323 && mouseY < 408) {
    println("Adventure Mode");
  }
  if(mouseX > 274 && mouseX < 804 && mouseY > 422 && mouseY < 506) {
    println("Tutorial");
  }
  if(mouseX > 274 && mouseX < 804 && mouseY > 518 && mouseY < 600) {
    println("Credits");
  }
}
// Disconnect Leap Motion device
public void stop() {
  leap.stop();
}
