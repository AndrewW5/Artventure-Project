// DS3 Milestone 8
// Alex Tarapacky
// March 28, 2014
// JRAA Studios

/**************************************************
    Changed the colour picker to colour swatched
    Changed the screen tap to push forward to tap
    Put homepage, art mode and credits into separate classes
    Joined files into one application
***************************************************/

import com.onformative.leap.LeapMotionP5;
import com.leapmotion.leap.Finger;
import com.leapmotion.leap.Hand;
import com.leapmotion.leap.CircleGesture;
import com.leapmotion.leap.KeyTapGesture;
import com.leapmotion.leap.ScreenTapGesture;
import com.leapmotion.leap.SwipeGesture;

final int STATE_HOMEPAGE = 0;
final int STATE_ARTMODE = 1;
final int STATE_ADVENTUREMODE = 2;
final int STATE_TUTORIAL = 3;
final int STATE_CREDITS = 4;
int gAppState = STATE_HOMEPAGE;

LeapMotionP5 leap;
ResourceLoader resourceLoader;
HomePage home;
ArtMode art;
Credits credits;
PGraphics buffer;

// Art Assets
PImage homePageBG, pawCursor, creditsBG;
PImage bannerTop, newButton, redColorImg;
PImage brushIncrease, brushDecrease, regularBrush, pawBrush, caligBrush, dotBrush;
PImage turq, red, blue, green, yellow, orange, pink, purple, lblue, white, black, grey;
PImage cursor;
// Brush attributes
float bW = 10; // brush width for ellipse
float bH = 10; // brush height for ellipse
float bAngle = 0; // brush angle
  
PVector lastFingerPos = new PVector(-1000, 1000);

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
  
  leap = new LeapMotionP5(this);
  resourceLoader = new ResourceLoader();
  home = new HomePage();
  art = new ArtMode();
  credits = new Credits();
  
  // Load Images
  pawCursor = resourceLoader.getImage("pawCursor.png");
  homePageBG = resourceLoader.getImage("homePageImage.jpg");
  creditsBG = resourceLoader.getImage("credits.png");
  bannerTop = resourceLoader.getImage("bannerTop.png");
  newButton = resourceLoader.getImage("newButton.png");
  brushIncrease = resourceLoader.getImage("brushIncrease.png");
  brushDecrease = resourceLoader.getImage("brushDecrease.png");
  regularBrush = resourceLoader.getImage("regularBrush.png");
  caligBrush = resourceLoader.getImage("caligBrush.png");
  pawBrush = resourceLoader.getImage("pawBrush.png");
  dotBrush = resourceLoader.getImage("dotBrush.png");
  cursor = resourceLoader.getImage("cursor.png");
  turq = resourceLoader.getImage("turq.png");
  blue = resourceLoader.getImage("blue.png");
  red = resourceLoader.getImage("red.png");
  green = resourceLoader.getImage("green.png");
  lblue = resourceLoader.getImage("lblue.png");
  pink = resourceLoader.getImage("pink.png");
  purple = resourceLoader.getImage("purple.png");
  orange = resourceLoader.getImage("orange.png");
  black = resourceLoader.getImage("black.png");
  white = resourceLoader.getImage("white.png");
  grey = resourceLoader.getImage("grey.png");
  yellow = resourceLoader.getImage("yellow.png");
  
  buffer = createGraphics(1080, 576);
} 
void draw() {  
    background(100);
    image(cursor, lastFingerPos.x, lastFingerPos.y, 50, 50);

    if(STATE_HOMEPAGE == gAppState){
      home.render();
    }
    else if(STATE_ARTMODE == gAppState){
      art.render();
    }
    else if(STATE_CREDITS == gAppState){
      credits.render();
    }
 
}

public void stop() {
  leap.stop();
}
