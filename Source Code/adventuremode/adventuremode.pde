// Adventure Mode
// Coded by Andrew Wardell
// Revision V1.1 Prototype
// Date: March 21, 2014

import com.leapmotion.leap.Finger;
import com.leapmotion.leap.Hand;
import com.leapmotion.leap.Gesture.State;
import com.leapmotion.leap.Gesture.Type;
import com.leapmotion.leap.ScreenTapGesture;
import com.leapmotion.leap.CircleGesture;
import com.leapmotion.leap.KeyTapGesture;
import com.leapmotion.leap.SwipeGesture;
import com.onformative.leap.LeapMotionP5;

LeapMotionP5 leap;
String lastGesture =
"enabling gestures: \n'c' for CircleGesture\n's' for SwipeGesture\n'k' for KeyTapGesture\n't' for ScreenTapGesture";

// Importing AudioPlayer and minim library
import ddf.minim.*;
AudioPlayer player;
Minim minim;//audio context

PGraphics buffer;

PFont font;

PImage toolsmenu;
PImage cursor;
PImage bg;
PImage fg;
PImage crate;
PImage tree1_2;
PImage tree2_2;
PImage tree3_2;
PImage largerock;
PImage crackedrock;
PImage weirdrock;
PImage log;
PImage treetrunk;
PImage rainbowfish;
PImage rainbowfish2;
PImage rainbowfish3;
PImage inkbees;

float bgSpeed = 130; // Background speed: Ex. 1000 is very slow and 1 is very fast
float playerMoveSpeed = 50; // Player speed according to Leap Position X: Ex. 100 is smooth, slow and 1 is fastest

float xpos = 0;
float ypos = 0;
float y = 0; 
float x = 0;

int timer = 0;
int swipeCrateTimer = 0;
int swipeRockTimer = 0;
int swipeCrackedRockTimer = 0;
int swipeWeirdRockTimer = 0;
int swipeLogTimer = 0;
int swipeTreesTimer = 0;
int swipeTreesTimer2 = 0;
int swipeTreesTimer3 = 0;
int circleBeesTimer = 0;

int scoreCount = 0;
float bgWidth = 7001 - 1080;

PVector lastFingerPos = new PVector(width/2, 1000);

Boolean gestureTest = false;
Boolean counting = true;

Boolean swipeCrate = false;
Boolean crateLoaded = true;
Boolean swipeRock = false;
Boolean rockLoaded = true;
Boolean swipeLog = false;
Boolean logLoaded = true;
Boolean swipeCrackedRock = false;
Boolean crackedRockLoaded = true;
Boolean swipeWeirdRock = false;
Boolean weirdRockLoaded = true;
Boolean swipeTrees = false;
Boolean rainbowFishLoaded = false;
Boolean swipeTrees2 = false;
Boolean rainbowFishLoaded2 = false;
Boolean swipeTrees3 = false;
Boolean rainbowFishLoaded3 = false;
Boolean circleBees = false;
Boolean beesLoaded = true;

ResourceLoader resourceLoader;
Animation playerAnim;

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
  smooth();
  background(255);
  frameRate(30);
  
  // Enabling Gestures
  leap = new LeapMotionP5(this);
  leap.enableGesture(Type.TYPE_CIRCLE);
  leap.enableGesture(Type.TYPE_SWIPE);
  
  // Font Implementation
  font = createFont("Roboto-Regular.ttf", 1);
  textFont(font);
  
  // Playing audio files
  minim = new Minim(this);
  player = minim.loadFile("Birds.mp3");
  player.play();
  
  // Loading Resource Assets
  resourceLoader = new ResourceLoader();
  toolsmenu = resourceLoader.getImage("ToolsMenu.png");
  cursor = resourceLoader.getImage("cursor.png");
  bg = resourceLoader.getImage("Background_2.png");
  fg = resourceLoader.getImage("Foreground_2.png");
  crate = resourceLoader.getImage("Crate_2.png");
  tree1_2 = resourceLoader.getImage("Tree1_2.png");
  tree2_2 = resourceLoader.getImage("Tree2_2.png");
  tree3_2 = resourceLoader.getImage("Tree3_2.png");
  largerock = resourceLoader.getImage("LargeRock_2.png");
  crackedrock = resourceLoader.getImage("CrackedRock_2.png");
  weirdrock = resourceLoader.getImage("WeirdRock_2.png");
  log = resourceLoader.getImage("Log_2.png");
  treetrunk = resourceLoader.getImage("TreeTrunk_2.png");
  rainbowfish = resourceLoader.getImage("RainbowFish_2_1.png");
  rainbowfish2 = resourceLoader.getImage("RainbowFish_2_2.png");
  rainbowfish3 = resourceLoader.getImage("RainbowFish_2_3.png");
  inkbees = resourceLoader.getImage("inkbees_2.png");
  
  playerAnim = new Animation("playerAnimation/playerMove", 7);
  
  buffer = createGraphics(2000, 2000);
  ypos = height * 0.35;
  
}

void draw() {
  
  background(255);
  
  if (counting) {
    timer = (millis()/1000); // In seconds
  }
  
  

  // ******************** ASSETS INSTANTIATED ********************
  // Background Instantiated 
  image( bg.get(int(x), 0 , bg.width-int(x), bg.height), 0, 0 );

  // Rock Instantiated
  if (x > 1900 - 1500 && x < 1900 && rockLoaded) {
    image( largerock.get(int(x), 0, largerock.width-int(x), largerock.height), 0, 0);
  }
  
  // Tree 1 Instantiated
  if (x > 1550 - 1500 && x < 1550) {
    image( tree1_2.get(int(x), 0, tree1_2.width-int(x), tree1_2.height), 0, 0);
  }
  
  // Tree 2 Instantiated
  if (x > 3350 - 1500 && x < 3350) {
    image( tree2_2.get(int(x), 0, tree2_2.width-int(x), tree2_2.height), 0, 0);
  }
  
  // Tree 3 Instantiated
  if (x > 5700 - 1500 && x < 5700) {
    image( tree3_2.get(int(x), 0, tree3_2.width-int(x), tree3_2.height), 0, 0);
  }
  
  // Weird Rock Instantiated
  if (x > 4100 - 1500 && x < 4100 && weirdRockLoaded) {
    image( weirdrock.get(int(x), 0, weirdrock.width-int(x), weirdrock.height), 0, 0);
  }
  
  // Tree Trunk Instantiated
  if (x > 3700 - 1500 && x < 3700) {
    image( treetrunk.get(int(x), 0, treetrunk.width-int(x), treetrunk.height), 0, 0);
  }
  
  // Rainbow Fish Instantiated
  if (x > 1475 - 1500 && x < 1475 && rainbowFishLoaded) {
    image( rainbowfish.get(int(x), 0, rainbowfish.width-int(x), rainbowfish.height), 0, 0);
  }
  
  // Rainbow Fish 2 Instantiated
  if (x > 3300 - 1500 && x < 3300 && rainbowFishLoaded2) {
    image( rainbowfish2.get(int(x), 0, rainbowfish2.width-int(x), rainbowfish2.height), 0, 0);
  }
  
  // Rainbow Fish 3 Instantiated
  if (x > 5610 - 1500 && x < 5610 && rainbowFishLoaded3) {
    image( rainbowfish3.get(int(x), 0, rainbowfish3.width-int(x), rainbowfish3.height), 0, 0);
  }
  
  // Ink Bees Instantiated
  if (x > 6700 - 1500 && x < 6700 && beesLoaded) {
    image( inkbees.get(int(x), 0, inkbees.width-int(x), inkbees.height), 0, 0);
  }
  
  
  // ******************** PLAYER ANIMATION ********************
  float dx = lastFingerPos.x - xpos; // Distance from cursor, replace mouseX with the leap position x
  playerAnim.display(xpos-playerAnim.getWidth()/2, ypos);
  xpos = xpos + dx/playerMoveSpeed; // Moves player to cursor position

  // User must strike the crate to continue the level
  if (crateLoaded) {
    if (xpos < 510) {
      xpos = xpos + dx/playerMoveSpeed;
    } else {
      xpos = 510;
    }
  } else {
    x += xpos / bgSpeed; 
  }
  
  // Crate Instantiated
  if (x < 1000 && crateLoaded) {
    image( crate.get(int(x), 0, crate.width-int(x), crate.height), 0, 0);
  }  
  
  // Cracked Rock Instantiated
  if (x > 2650 - 1500 && x < 2650 && crackedRockLoaded) {
    image( crackedrock.get(int(x), 0, crackedrock.width-int(x), crackedrock.height), 0, 0);
  }
  
  // Foreground Instantiated
  if (x < 6000) {
    image( fg.get(int(x), 0 , fg.width-int(x), fg.height), 0, 0);
  }
  
  // Log Instantiated
  if (x > 5000 - 1500 && x < 5000 && logLoaded) {
    image( log.get(int(x), 0, log.width-int(x), log.height), 0, 0);
  }
  
  // Tools Menu Instantiated
  image( toolsmenu, 15, 15);
  
  // Cursor
  image(cursor, lastFingerPos.x, lastFingerPos.y, 50, 50);
  
  
  // Circle Bees Text Event, encourage thy player!
  if (!beesLoaded && timer < circleBeesTimer + 7) {
    textSize(35);
    text("Congratulations! You beat the level!", width/3, height/2);
  }  
  
  // ******************** TEXT EVENTS ********************
  // Welcome Text Event
  if (timer < 20) {
    fill(255);
    textSize(48);
    text("YOU ARE RAINBOW CAT", width/3, height/8);
  }
  // Help Text Event 1
  if (x > 300 && x < 600) {
    fill(255);
    textSize(30);
    text("Strike objects to gain points!\nYou might even find Rainbow Fish!", width/2.5, height/8);
  }
  // Help Text Event 2
  if (x > 5200 && x < 5500) {
    fill(255);
    textSize(30);
    text("Circle the bees to net them!", width/2.5, height/8);
  }
  // Telling the user to strike the crate
  if (crateLoaded && timer > 7 && timer < 20) {
    fill(255);
    textSize(30);
    text("Strike the Crate!", width/2.5, height/2);
  }
  // Reminding the user to strike the crate after 20 seconds
  if (crateLoaded && timer > 20) {
    textSize(30);
    text("Strike the Crate by swiping\nLeft and Right using Leap Motion device!", width/3, height/2);
  }
  
  // Swipe Crate Text Event, encourage thy player!
  if (!crateLoaded && timer < swipeCrateTimer + 7) {
    textSize(35);
    text("Amazing! +100 Points", width/2.5, height/2);
  }
  
  // Swipe Rock Text Event, encourage thy player!
  if (!rockLoaded && timer < swipeRockTimer + 7) {
    textSize(35);
    text("Beautiful Rock! +50 Points", width/2.5, height/2);
  }
  
  // Swipe Cracked Rock Text Event, encourage thy player!
  if (!crackedRockLoaded && timer < swipeCrackedRockTimer + 7) {
    textSize(35);
    text("Wasn't even hard! +50 Points", width/2.5, height/2);
  }
  
  // Swipe Weird Rock Text Event, encourage thy player!
  if (!weirdRockLoaded && timer < swipeWeirdRockTimer + 7) {
    textSize(35);
    text("Wonderful Rock! +50 Points", width/2.5, height/2);
  }
  
  // Swipe Log Text Event, encourage thy player!
  if (!logLoaded && timer < swipeLogTimer + 7) {
    textSize(35);
    text("Spectacular! +100 Points", width/3, height/2);
  }
  
  // Swipe Trees Text Event, encourage thy player!
  if (rainbowFishLoaded && timer < swipeTreesTimer + 7) {
    textSize(35);
    text("Rainbow Fish Get! +20 Points", width/3, height/2);
  }
  
  // Swipe Trees 2 Text Event, encourage thy player!
  if (rainbowFishLoaded2 && timer < swipeTreesTimer2 + 7) {
    textSize(35);
    text("Rainbow Fish Get! +30 Points", width/3, height/2);
  }
  
  // Swipe Trees 3 Text Event, encourage thy player!
  if (rainbowFishLoaded3 && timer < swipeTreesTimer3 + 7) {
    textSize(35);
    text("Rainbow Fish Get! +30 Points", width/3, height/2);
  }
  
  
  
  
  // ******************** TESTING ********************
  // Get Finger Positions
    println(lastFingerPos.x + " " + lastFingerPos.y);
  // Get X Dimensions of Screen
    //println("X: " + x);
  // println(timer);

  // Finger Points
  ArrayList<Finger> fingerList = leap.getFingerList();
  if (fingerList.size() > 0) {
    PVector fingerPos = leap.getTip(fingerList.get(0));
    ArrayList<PVector> points = getInterpolatedPoints(lastFingerPos, fingerPos, 2);
    lastFingerPos = fingerPos;
  }
  
  // Still wondering about the implementation for these
  if(lastFingerPos.x > 38 && lastFingerPos.x < 90 && lastFingerPos.y > 80 && lastFingerPos.y < 130) {
      println("Drawing Tool Chosen");
    }
  if(lastFingerPos.x > 120 && lastFingerPos.x < 175 && lastFingerPos.y > 80 && lastFingerPos.y < 130) {
    println("Eraser Chosen");
  }
  
  
  // ******************** LEVEL ONE INTERACTION ********************
  // Swiping the crate
  if (swipeCrate) {
    scoreCount += 100;
    crateLoaded = false;
    swipeCrate = false;
    timer = swipeCrateTimer;
    swipeCrateTimer = (millis() / 1000) - swipeCrateTimer;
  }
  
  // Swiping the rock
  if (swipeRock) {
    scoreCount += 50;
    rockLoaded = false;
    swipeRock = false;
    timer = swipeRockTimer;
    swipeRockTimer = (millis() / 1000) - swipeRockTimer;
  }
  
  // Swiping the cracked rock
  if (swipeCrackedRock) {
    scoreCount += 50;
    crackedRockLoaded = false;
    swipeCrackedRock = false;
    timer = swipeCrackedRockTimer;
    swipeCrackedRockTimer = (millis() / 1000) - swipeCrackedRockTimer;
  }
  
  // Swiping the weird rock
  if (swipeWeirdRock) {
    scoreCount += 50;
    weirdRockLoaded = false;
    swipeWeirdRock = false;
    timer = swipeWeirdRockTimer;
    swipeWeirdRockTimer = (millis() / 1000) - swipeWeirdRockTimer;
  }
  
  // Swiping the log
  if (swipeLog) {
    scoreCount += 100;
    logLoaded = false;
    swipeLog = false;
    timer = swipeLogTimer;
    swipeLogTimer = (millis() / 1000) - swipeLogTimer;
  }
  
  // Swiping the trees
  if (swipeTrees) {
    scoreCount += 20;
    rainbowFishLoaded = true;
    swipeTrees = false;
    timer = swipeTreesTimer;
    swipeTreesTimer = (millis() / 1000) - swipeTreesTimer;
  }
  // Swiping the trees 2
  if (swipeTrees2) {
    scoreCount += 30;
    rainbowFishLoaded2 = true;
    swipeTrees2 = false;
    timer = swipeTreesTimer2;
    swipeTreesTimer2 = (millis() / 1000) - swipeTreesTimer2;
  }
  // Swiping the trees 3
  if (swipeTrees3) {
    scoreCount += 30;
    rainbowFishLoaded3 = true;
    swipeTrees3 = false;
    timer = swipeTreesTimer3;
    swipeTreesTimer3 = (millis() / 1000) - swipeTreesTimer3;
  }
  
  // Circle the bees
  if (circleBees) {
    scoreCount += 100;
    beesLoaded = false;
    circleBees = false;
    timer = circleBeesTimer;
    circleBeesTimer = (millis() / 1000) - circleBeesTimer;
  }
  
  // Level End Event
  if (x > bgWidth) {
    println("Level Ended. Score: " + scoreCount); 
    x = 0;
    scoreCount = 0;
    bgSpeed = 10000;
    playerMoveSpeed = 10000;
  }
  
  fill(255);
  textSize(32);
  text("Score: " + scoreCount, 45, height - 45);
  
}

// 1.Circle Gesture
public void circleGestureRecognized(CircleGesture gesture, String clockwiseness) {
  
  // Netting the bees
  if (x > 6700 - 1080 && x < 6700 && beesLoaded) {
    if (gesture.state() == State.STATE_STOP) {
      System.out.println("//////////////////////////////////////");
      System.out.println("Gesture type: " + gesture.type().toString());
      System.out.println("ID: " + gesture.id());
      System.out.println("Radius: " + gesture.radius());
      System.out.println("Normal: " + gesture.normal());
      System.out.println("Clockwiseness: " + clockwiseness);
      System.out.println("Turns: " + gesture.progress());
      System.out.println("Center: " + leap.vectorToPVector(gesture.center()));
      System.out.println("Duration: " + gesture.durationSeconds() + "s");
      System.out.println("//////////////////////////////////////");
      lastGesture = "Gesture type: " + gesture.type().toString() + "\n";
      lastGesture += "ID: " + gesture.id() + "\n";
      lastGesture += "Radius: " + gesture.radius() + "\n";
      lastGesture += "Normal: " + gesture.normal() + "\n";
      lastGesture += "Clockwiseness: " + clockwiseness + "\n";
      lastGesture += "Turns: " + gesture.progress() + "\n";
      lastGesture += "Center: " + leap.vectorToPVector(gesture.center()) + "\n";
      lastGesture += "Duration: " + gesture.durationSeconds() + "s" + "\n";
    } 
    else if (gesture.state() == State.STATE_START) {
    } 
    else if (gesture.state() == State.STATE_UPDATE) {
    }
   circleBees = true;
  }
  
}

// 2. Swipe Gesture
public void swipeGestureRecognized(SwipeGesture gesture) {
  
 // Crate Swipe
 if (lastFingerPos.x > 600 && crateLoaded) {
    if (gesture.state() == State.STATE_STOP) {
      System.out.println("//////////////////////////////////////");
      System.out.println("Gesture type: " + gesture.type());
      System.out.println("ID: " + gesture.id());
      System.out.println("Position: " + leap.vectorToPVector(gesture.position()));
      System.out.println("Direction: " + gesture.direction());
      System.out.println("Duration: " + gesture.durationSeconds() + "s");
      System.out.println("Speed: " + gesture.speed());
      System.out.println("//////////////////////////////////////");
      lastGesture = "Gesture type: " + gesture.type().toString() + "\n";
      lastGesture += "ID: " + gesture.id() + "\n";
      lastGesture += "Position: " + leap.vectorToPVector(gesture.position()) + "\n";
      lastGesture += "Direction: " + gesture.direction() + "\n";
      lastGesture += "Speed: " + gesture.speed() + "\n";
      lastGesture += "Duration: " + gesture.durationSeconds() + "s" + "\n";
    } 
    else if (gesture.state() == State.STATE_START) {
    } 
    else if (gesture.state() == State.STATE_UPDATE) {
    }
  swipeCrate = true;
 }
 
 // Rock Swipe
 if (x > 600 && lastFingerPos.x > 100 && lastFingerPos.x < 900 && lastFingerPos.y > 300 && lastFingerPos.y < 550 && rockLoaded) {
    if (gesture.state() == State.STATE_STOP) {
    } 
    else if (gesture.state() == State.STATE_START) {
    } 
    else if (gesture.state() == State.STATE_UPDATE) {
    }
  swipeRock = true;
 }
 
 // Cracked Rock Swipe
 if (x > 2600 - 1080 && x < 2600 && lastFingerPos.x > 100 && lastFingerPos.x < 900 && crackedRockLoaded) {
    if (gesture.state() == State.STATE_STOP) {
    } 
    else if (gesture.state() == State.STATE_START) {
    } 
    else if (gesture.state() == State.STATE_UPDATE) {
    }
  swipeCrackedRock = true;
 }
 
 // Weird Rock Swipe
 if (x > 4000 - 1080 && x < 4000 && lastFingerPos.x > 100 && lastFingerPos.x < 900 && weirdRockLoaded) {
    if (gesture.state() == State.STATE_STOP) {
    } 
    else if (gesture.state() == State.STATE_START) {
    } 
    else if (gesture.state() == State.STATE_UPDATE) {
    }
  swipeWeirdRock = true;
 }
 
 // Log Swipe
 if (x > 5000 - 1080 && x < 5000 && lastFingerPos.x > 100 && lastFingerPos.x < 900 && logLoaded) {
    if (gesture.state() == State.STATE_STOP) {
    } 
    else if (gesture.state() == State.STATE_START) {
    } 
    else if (gesture.state() == State.STATE_UPDATE) {
    }
  swipeLog = true;
 }
 
 // Trees Swipe
 if (x > 1475 - 1080 && x < 1475 && lastFingerPos.x > 100 && lastFingerPos.x < 900 && lastFingerPos.y > 0 && lastFingerPos.y < 280 && !rainbowFishLoaded) {
    if (gesture.state() == State.STATE_STOP) {
    } 
    else if (gesture.state() == State.STATE_START) {
    } 
    else if (gesture.state() == State.STATE_UPDATE) {
    }
  swipeTrees = true;
 }
 
 // Trees 2 Swipe
 if (x > 3370 - 1080 && x < 3370 && lastFingerPos.x > 100 && lastFingerPos.x < 900 && lastFingerPos.y > 0 && lastFingerPos.y < 280 && !rainbowFishLoaded2) {
    if (gesture.state() == State.STATE_STOP) {
    } 
    else if (gesture.state() == State.STATE_START) {
    } 
    else if (gesture.state() == State.STATE_UPDATE) {
    }
  swipeTrees2 = true;
 }
 
 // Trees 3 Swipe
 if (x > 5610 - 1080 && x < 5610 && lastFingerPos.x > 100 && lastFingerPos.x < 900 && lastFingerPos.y > 0 && lastFingerPos.y < 280 && !rainbowFishLoaded3) {
    if (gesture.state() == State.STATE_STOP) {
    } 
    else if (gesture.state() == State.STATE_START) {
    } 
    else if (gesture.state() == State.STATE_UPDATE) {
    }
  swipeTrees3 = true;
 }
 
}

void stop()
{
  player.close();
  minim.stop();
  super.stop();
  leap.stop();
}
