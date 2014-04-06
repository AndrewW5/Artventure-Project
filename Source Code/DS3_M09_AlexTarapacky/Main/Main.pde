// DS3 Milestone 9
// Alex Tarapacky
// April 4, 2014
// JRAA Studios

/**************************************************
    Created particle and paw brushes
    Implemented new home page and art mode assets
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
final int STATE_ADVENTUREMODE1 = 2;
final int STATE_ADVENTUREMODE2 = 3;
final int STATE_ADVENTUREMODE3 = 4;
final int STATE_ADVENTUREMODE4 = 5;
final int STATE_TUTORIAL = 6;
final int STATE_CREDITS = 7;
int gAppState = STATE_HOMEPAGE;

LeapMotionP5 leap;
ResourceLoader resourceLoader;
HomePage home;
ArtMode art;
Credits credits;

PGraphics buffer;

// Art Assets
PImage homePageBG, pawCursor, artBG, creditsBG;
PImage newButton, brushIncrease, brushDecrease, regularBrush, pawBrush, caligBrush, dotBrush;
PImage turq, red, blue, green, yellow, orange, pink, purple, lblue, white, black, grey;
PImage cursor;
// Brush attributes
float bW = 10; // brush width for ellipse
float bH = 10; // brush height for ellipse
float bp = 70; // paw size
float bAngle = 0; // brush angle
float bAngleP = random(1,180);
color col;

boolean particle = false;
boolean paw = false;
  
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
  cursor = resourceLoader.getImage("cursor.png");
  homePageBG = resourceLoader.getImage("HomeMenuBG.png");
  creditsBG = resourceLoader.getImage("credits.png");
  artBG = resourceLoader.getImage("ArtModeBG.png");
  
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
