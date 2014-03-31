// Adventure Mode - Level 2
// Coded by Andrew Wardell
// Date: March 30, 2014

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

import ddf.minim.*;
AudioPlayer player;
Minim minim;//audio context

PVector lastFingerPos = new PVector(width/2, 1000);

PGraphics buffer;

PFont font;

PImage toolsmenu;
PImage cursor;
PImage bg;
PImage fg;
PImage crate;
PImage craterainbowfish;
PImage deadtree;
PImage deadtreerainbowfish;
PImage door;
PImage dooroutline;
PImage bridge;
PImage bridgeoutline;
PImage boulderback;
PImage bouldersmashable;
PImage bouldersmashablerainbowfish;
PImage hedge;
PImage hedgerainbowfish;
PImage hole3;
PImage holefront;
PImage house;
PImage houseoutline;
PImage largerock;
PImage largerock2;
PImage largerock3;
PImage largerockoutline;
PImage roof;
PImage roofoutline;
PImage waterfountain;
PImage waterfountain2;
PImage window;
PImage windowoutline;

Boolean swipeBridgeOutline = false;
Boolean bridgeOutlineLoaded = true;
Boolean bridgeLoaded = false;
Boolean swipeHedge = false;
Boolean hedgeLoaded = true;
Boolean hedgeRainbowFishLoaded = false;
Boolean hole3Loaded = true;
Boolean swipeDeadTree = false;
Boolean deadTreeRainbowFishLoaded = false;
Boolean boulderBackLoaded = true;
Boolean swipeBoulder = false;
Boolean boulderSmashableLoaded = true;
Boolean boulderSmashableRainbowFishLoaded = false;
Boolean swipeCrate = false;
Boolean crateLoaded = true;
Boolean crateRainbowFishLoaded = false;
Boolean swipeLargeRockOutline = false;
Boolean largeRockOutlineLoaded = true;
Boolean swipeLargeRock = false;
Boolean largeRockLoaded = false;
Boolean largeRock2Loaded = true;
Boolean largeRock3Loaded = false;
Boolean waterFountainLoaded = true;
Boolean waterFountain2Loaded = false;
Boolean greenBeeLoaded = true;
Boolean purpleBeeLoaded = true;
Boolean redBeeLoaded = true;
Boolean circleBeeGreen = false;
Boolean circleBeePurple = false;
Boolean circleBeeRed = false;

float bgSpeed = 130; // Background speed: Ex. 1000 is very slow and 1 is very fast, 130 seems good
float playerMoveSpeed = 50; // Player speed according to Leap Position X: Ex. 100 is smooth, slow and 1 is fastest, 50 seems good

float archiePosY = 80;
float archiePosX = 80;
float rainbowCatPosY = 100;
float xpos = 0;
float ypos = 0;
float y = 0; 
float x = 0;
int scoreCount = 0;
int savedTime = 0;
int timer = 0;
int swipeBridgeOutlineTimer = 0;
int swipeHedgeTimer = 0;
int swipeHoleTimer = 0;
int swipeBoulderTimer = 0;
int swipeCrateTimer = 0;
int swipeLargeRockOutlineTimer = 0;
int swipeLargeRockTimer = 0;
int swipeDeadTreeTimer = 0;
int endLevelTimer = 0;

float bgWidth = 7001 - 1080;

Boolean gestureTest = false;
Boolean counting = true;

ResourceLoader resourceLoader;
Animation archieFlying;
Animation playerAnimWalk;
Animation playerAnimIdle;
Animation playerAnimAttack;
Animation inkbeeGreen;
Animation inkbeePurple;
Animation inkbeeRed;

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
  player = minim.loadFile("Level2.mp3");
  player.play();
  
  /*
PImage door;
PImage dooroutline;
PImage house;
PImage houseoutline;
PImage roof;
PImage roofoutline;
PImage window;
PImage windowoutline; */
  
  // Loading Resource Assets
  resourceLoader = new ResourceLoader();
  toolsmenu = resourceLoader.getImage("ToolsMenu.png");
  cursor = resourceLoader.getImage("cursor.png");
  bg = resourceLoader.getImage("Background_2.png");
  fg = resourceLoader.getImage("Foreground_2.png");
  bridgeoutline = resourceLoader.getImage("BridgeOutline_2.png");
  bridge = resourceLoader.getImage("Bridge_2.png");
  hedge = resourceLoader.getImage("Hedge_2.png");
  hedgerainbowfish = resourceLoader.getImage("Hedge_RainbowFish.png");
  hole3 = resourceLoader.getImage("Hole_3.png");
  deadtree = resourceLoader.getImage("DeadTree_2.png");
  deadtreerainbowfish = resourceLoader.getImage("DeadTree_RainbowFish.png");
  boulderback = resourceLoader.getImage("BoulderBack_2.png");
  bouldersmashable = resourceLoader.getImage("BoulderSmashable_2.png");
  bouldersmashablerainbowfish = resourceLoader.getImage("BoulderSmashable_RainbowFish.png");
  crate = resourceLoader.getImage("Crate_2.png");
  craterainbowfish = resourceLoader.getImage("Crate_RainbowFish.png");
  largerockoutline = resourceLoader.getImage("LargeRockOutline_2.png");
  largerock = resourceLoader.getImage("LargeRock_1.png");
  largerock2 = resourceLoader.getImage("LargeRock_2.png");
  largerock3 = resourceLoader.getImage("LargeRock_3.png");
  waterfountain = resourceLoader.getImage("Waterfountain_1.png");
  waterfountain2 = resourceLoader.getImage("Waterfountain_2.png");
  
  archieFlying = new Animation("Animation/Archieframe", 7);
  playerAnimWalk = new Animation("Animation/CATWalking", 7);
  playerAnimIdle = new Animation("Animation/CATIdle", 7);
  playerAnimAttack = new Animation("Animation/CATattacking", 7);
  inkbeeGreen = new Animation("Animation/InkbeeGreen", 11);
  inkbeePurple = new Animation("Animation/InkbeePurple", 11);
  inkbeeRed = new Animation("Animation/InkbeeRed", 11);
  
  buffer = createGraphics(2000, 2000);
  ypos = height * 0.35;
  
}

void draw() {
  
  background(255);
  fill(255);
 
  if (counting) {
    timer = (millis()/1000); // In seconds
  }
  
  
  // ******************** LEVEL 2 ASSETS INSTANTIATED ********************
  // Each image is loaded into the scene by order of instantiation
  // Ex. Background image is loaded first, so all other assets after will be in front
  // Ex. Cursor image is loaded last, so all other assets before will be behind
  
  // Background Instantiated 
  image( bg.get(int(x), 0 , bg.width-int(x), bg.height), 0, 0 );
  
  // Water Fountain Instantiated
  if (x > 2160 - 1500 && x < 2160 && waterFountainLoaded) {
    image( waterfountain.get(int(x), 0 , waterfountain.width-int(x), waterfountain.height), 0, 0);
  }
  // Water Fountain 2 Instantiated
  if (x > 2400 - 1500 && x < 2400 && waterFountain2Loaded) {
    image( waterfountain2.get(int(x), 0 , waterfountain2.width-int(x), waterfountain2.height), 0, 0);
  }
  // Bridge Outline Instantiated
  if (x < 1220 && bridgeOutlineLoaded) {
    image( bridgeoutline.get(int(x), 0 , bridgeoutline.width-int(x), bridgeoutline.height), 0, 0);
  }
  // Bridge Instantiated
  if (x < 1220 && bridgeLoaded) {
    image( bridge.get(int(x), 0 , bridge.width-int(x), bridge.height), 0, 0);
  }
  // Hedge Instantiated
  if (x > 1600 - 1500 && x < 1600 && hedgeLoaded) {
    image( hedge.get(int(x), 0 , hedge.width-int(x), hedge.height), 0, 0);
  }
  // Hedge with Rainbow Fish Instantiated
  if (x > 1600 - 1500 && x < 1600 && hedgeRainbowFishLoaded) {
    image( hedgerainbowfish.get(int(x), 0 , hedgerainbowfish.width-int(x), hedgerainbowfish.height), 0, 0);
  }
  // Hole Instantiated
  if (x > 2800 - 1500 && x < 2800 && hole3Loaded) {
    image( hole3.get(int(x), 0 , hole3.width-int(x), hole3.height), 0, 0);
  }
  // Dead Tree Instantiated
  if (x > 4100 - 1500 && x < 4100) {
    image( deadtree.get(int(x), 0 , deadtree.width-int(x), deadtree.height), 0, 0);
  }
  // Dead Tree with Rainbow Fish Instantiated
  if (x > 4100 - 1500 && x < 4100 && deadTreeRainbowFishLoaded) {
    image( deadtreerainbowfish.get(int(x), 0 , deadtreerainbowfish.width-int(x), deadtreerainbowfish.height), 0, 0);
  }
  // Crate Instantiated
  if (x > 4880 - 1500 && x < 4880 && crateLoaded) {
    image( crate.get(int(x), 0 , crate.width-int(x), crate.height), 0, 0);
  }
  // Crate with Rainbow Fish Instantiated
  if (x > 4880 - 1500 && x < 4880 && crateRainbowFishLoaded) {
    image( craterainbowfish.get(int(x), 0 , craterainbowfish.width-int(x), craterainbowfish.height), 0, 0);
  }
  // Boulder Back Instantiated
  if (x > 3290 - 1500 && x < 3290 && boulderBackLoaded) {
    image( boulderback.get(int(x), 0 , boulderback.width-int(x), boulderback.height), 0, 0);
  }
  // Boulder Smashable Instantiated
  if (x > 3290 - 1500 && x < 3290 && boulderSmashableLoaded) {
    image( bouldersmashable.get(int(x), 0 , bouldersmashable.width-int(x), bouldersmashable.height), 0, 0);
  }
  // Boulder Smashable with Rainbow Fish Instantiated
  if (x > 3290 - 1500 && x < 3290 && boulderSmashableRainbowFishLoaded) {
    image( bouldersmashablerainbowfish.get(int(x), 0 , bouldersmashablerainbowfish.width-int(x), bouldersmashablerainbowfish.height), 0, 0);
  }
  // Large Rock Outline Instantiated
  if (x > 2150 - 1500 && x < 2150 && largeRockOutlineLoaded) {
    image( largerockoutline.get(int(x), 0 , largerockoutline.width-int(x), largerockoutline.height), 0, 0);
  }
  // Large Rock Instantiated
  if (x > 2130 - 1500 && x < 2130 && largeRockLoaded) {
    image( largerock.get(int(x), 0 , largerock.width-int(x), largerock.height), 0, 0);
  }
  // Large Rock 2 Instantiated
  if (x > 2470 - 1500 && x < 2470 && largeRock2Loaded) {
    image( largerock2.get(int(x), 0 , largerock2.width-int(x), largerock2.height), 0, 0);
  }
  // Large Rock 3 Instantiated
  if (x > 2780 - 1500 && x < 2780 && largeRock3Loaded) {
    image( largerock3.get(int(x), 0 , largerock3.width-int(x), largerock3.height), 0, 0);
  }
  

  // ******************** LEVEL 2 ANIMATION ********************
  
  //float dx = mouseX - xpos; // Testing with the mouse
  float dx = lastFingerPos.x - xpos; // Distance from cursor, Leap Motion control
  int passedTime = millis() - savedTime;
  
  if (timer < 30) {
    archieFlying.display(xpos-archieFlying.getWidth()/2, ypos + 80);
  }
  if (timer >= 30) {
    archieFlying.display(archieFlying.getWidth()/2 + archiePosX + 300, archiePosY + 200);
  }
  if (dx > 40 || dx < -40) {
    if (passedTime > 4000) {
      float randx = 100;
      float randy = 100;
      archiePosX = random(-randx, randx);
      archiePosY = random(-randy, randy);
      savedTime = millis();
    }
    playerAnimWalk.display(xpos-playerAnimWalk.getWidth()/2, ypos + rainbowCatPosY);
  } else {
    playerAnimWalk.display(xpos-playerAnimWalk.getWidth()/2, ypos + rainbowCatPosY);
  }
  xpos = xpos + dx/playerMoveSpeed; // Moves player to cursor position
  
  

  // ******************** LEVEL 2 ADVANCE ********************
  
  int smallTextSize = 30;
  int normalTextSize = 35;
  int largeTextSize = 48;
  int middleScreenPosX = 3;
  int middleScreenPosY = 2;
  int topScreenPosY = 8;
  int textDuration = 4;
  int textDurEnd = 6; // Loading time
  
  // User must strike the bridge outline to continue the level
  if (bridgeOutlineLoaded) {
    if (xpos < 700) {
     // xpos = xpos + dx/playerMoveSpeed;
    } else {
      //xpos = 700;
    }
  } else {
    x += xpos / bgSpeed; 
  }
  
  
  // ******************** LEVEL 2 ASSETS INSTANTIATED ********************
  
  // Foreground Instantiated
  if (x < 5400) {
    image( fg.get(int(x), 0 , fg.width-int(x), fg.height), 0, 0);
  }
  
  // Tools Menu Instantiated
  image( toolsmenu, 15, 15);
  
  // Cursor Instantiated
  image(cursor, lastFingerPos.x, lastFingerPos.y, 50, 50);
  


  // ******************** LEVEL 2 TEXT EVENTS ********************

  // End Level Event
  if (timer < endLevelTimer + textDurEnd) {
    textSize(normalTextSize);
    text("Congratulations! You beat the level!", width/middleScreenPosX, height/middleScreenPosY);
  }
  // Welcome Text Event for a duration of time
  if (timer < 15) {
    textSize(largeTextSize);
    text("WELCOME TO LEVEL 2", width/middleScreenPosX, height/topScreenPosY);
  }
  // Strike objects, events, rainbow fish
  if (x > 800 && x < 1200 && timer > 15) {
    textSize(smallTextSize);
    text("Strike objects to gain points!\nEvents may happen!\nYou might even find Rainbow Fish!", width/middleScreenPosX, height/topScreenPosY);
  }
  // Help Text Event 1 - Telling the user to draw the bridge
  if (bridgeOutlineLoaded && timer > 7 && timer < 20) {
    textSize(smallTextSize);
    text("Draw the Bridge!", width/middleScreenPosX, height/middleScreenPosY);
  }
  // Help Text Event 2 - Reminding the user to draw the bridge
  if (bridgeOutlineLoaded && timer > 20) {
    textSize(smallTextSize);
    text("Draw the Bridge by drawing the outline\nusing the Leap Motion!", width/middleScreenPosX, height/middleScreenPosY);
  }
  // Swipe Bridge Outline Text Event, encourage thy player!
  if (!bridgeOutlineLoaded && timer < swipeBridgeOutlineTimer + textDuration) {
    textSize(normalTextSize);
    text("Amazing! +100 Points", width/middleScreenPosX, height/middleScreenPosY);
  }
  // Swipe Hedge Text Event, encourage thy player!
  if (!hedgeLoaded && timer < swipeHedgeTimer + textDuration) {
    textSize(normalTextSize);
    text("Nice Fish! +50 Points", width/middleScreenPosX - 0.5, height/middleScreenPosY);
  }
  // Swipe Boulder Text Event, encourage thy player!
  if (!boulderSmashableLoaded && timer < swipeBoulderTimer + textDuration) {
    textSize(normalTextSize);
    text("Wow! Look beneath the boulder! +50 Points", width/middleScreenPosX - 0.5, height/middleScreenPosY);
  }
  // Swipe Crate Text Event, encourage thy player!
  if (!crateLoaded && timer < swipeCrateTimer + textDuration) {
    textSize(normalTextSize);
    text("Cool Crates! +50 Points", width/middleScreenPosX - 0.5, height/middleScreenPosY);
  }
  // Swipe Large Rock Outline Text Event, encourage thy player!
  if (!largeRockOutlineLoaded && timer < swipeLargeRockOutlineTimer + textDuration) {
    textSize(normalTextSize);
    text("Plugged the water! +30 Points", width/middleScreenPosX - 0.5, height/middleScreenPosY);
  }
  // Swipe Large Rock 3 Text Event, encourage thy player!
  if (!largeRock3Loaded && timer < swipeLargeRockTimer + textDuration) {
    textSize(normalTextSize);
    text("Destroyed the rock! +30 Points", width/middleScreenPosX - 0.5, height/middleScreenPosY);
  }
  // Swipe Dead Tree Text Event, encourage thy player!
  if (deadTreeRainbowFishLoaded && timer < swipeDeadTreeTimer + textDuration) {
    textSize(normalTextSize);
    text("Look at all of them! +50 Points", width/middleScreenPosX - 0.5, height/middleScreenPosY);
  }
  


  // ******************** LEVEL 2 GESTURE INTERACTION ********************
  
  // Swiping the Bridge Outline
  if (swipeBridgeOutline) {
    scoreCount += 100;
    swipeBridgeOutline = false;
    bridgeOutlineLoaded = false;
    bridgeLoaded = true;
    timer = swipeBridgeOutlineTimer;
    swipeBridgeOutlineTimer = (millis()/1000) - swipeBridgeOutlineTimer;
  }
  // Swiping the Hedge
  if (swipeHedge) {
    scoreCount += 50;
    swipeHedge = false;
    hedgeRainbowFishLoaded = true;
    hedgeLoaded = false;
    timer = swipeHedgeTimer;
    swipeHedgeTimer = (millis()/1000) - swipeHedgeTimer;
  }
  // Swiping the Boulder
  if (swipeBoulder) {
    scoreCount += 50;
    swipeBoulder = false;
    boulderSmashableRainbowFishLoaded = true;
    boulderSmashableLoaded = false;
    timer = swipeBoulderTimer;
    swipeBoulderTimer = (millis()/1000) - swipeBoulderTimer;
  }
  // Swiping the Crates
  if (swipeCrate) {
    scoreCount += 50;
    swipeCrate = false;
    crateRainbowFishLoaded = true;
    crateLoaded = false;
    timer = swipeCrateTimer;
    swipeCrateTimer = (millis()/1000) - swipeCrateTimer;
  }
  // Swiping the Large Rock Outline
  if (swipeLargeRockOutline) {
    scoreCount += 30;
    swipeLargeRockOutline = false;
    largeRockLoaded = true;
    largeRockOutlineLoaded = false;
    waterFountainLoaded = false;
    waterFountain2Loaded = true;
    largeRock2Loaded = false;
    largeRock3Loaded = true;
    timer = swipeLargeRockOutlineTimer;
    swipeLargeRockOutlineTimer = (millis()/1000) - swipeLargeRockOutlineTimer;
  }
  // Swiping the Large Rock
  if (swipeLargeRock) {
    scoreCount += 30;
    swipeLargeRock = false;
    largeRock3Loaded = false;
    timer = swipeLargeRockTimer;
    swipeLargeRockTimer = (millis()/1000) - swipeLargeRockTimer;
  }
  // Swiping the Dead Tree
  if (swipeDeadTree) {
    scoreCount += 50;
    deadTreeRainbowFishLoaded = true;
    swipeDeadTree = false;
    timer = swipeDeadTreeTimer;
    swipeDeadTreeTimer = (millis()/1000) - swipeDeadTreeTimer;
  }
  // Circling the Green Bee
  if (circleBeeGreen) {
    scoreCount += 10;
    greenBeeLoaded = false;
    circleBeeGreen = false;
  }
  // Circling the Purple Bee
  if (circleBeePurple) {
    scoreCount += 10;
    purpleBeeLoaded = false;
    circleBeePurple = false;
  }
  // Circling the Red Bee
  if (circleBeeRed) {
    scoreCount += 10;
    redBeeLoaded = false;
    circleBeeRed = false;
  }
  // Level End Event
  if (x > bgWidth) {
    println("Level Ended. Score: " + scoreCount); 
    x = 0;
    scoreCount = 0;
    bgSpeed = 10000; // temp
    playerMoveSpeed = 10000; // temp
    timer = endLevelTimer;
    endLevelTimer = (millis()/1000) - endLevelTimer;
  }
  // Score Counter
  textSize(32);
  text("Score: " + scoreCount, 45, height - 45);
  
  // ******************** TESTING ********************
  
  // Get Finger Positions
    //println(lastFingerPos.x + " " + lastFingerPos.y); // X and Y
    //println("Y: " + lastFingerPos.y); // Just Y
    //println("X: " + lastFingerPos.x); // Just X
    //println(dx);
    //println(xpos);
  // Get X or Y Dimensions of Screen
    //println("X: " + x);
    //println("Y: " + y);
  // println(timer);

  // Finger Points
  ArrayList<Finger> fingerList = leap.getFingerList();
  if (fingerList.size() > 0) {
    PVector fingerPos = leap.getTip(fingerList.get(0));
    ArrayList<PVector> points = getInterpolatedPoints(lastFingerPos, fingerPos, 2);
    lastFingerPos = fingerPos;
  }  
  // Still wondering about the implementation for these buttons
  if(lastFingerPos.x > 38 && lastFingerPos.x < 90 && lastFingerPos.y > 80 && lastFingerPos.y < 130) {
      println("Drawing Tool Chosen");
  }
  if(lastFingerPos.x > 120 && lastFingerPos.x < 175 && lastFingerPos.y > 80 && lastFingerPos.y < 130) {
    println("Eraser Chosen");
  }
}

// 1.Circle Gesture
public void circleGestureRecognized(CircleGesture gesture, String clockwiseness) {
  
  // ********** LEVEL 2 GESTURES **********
  
  /*
  // Netting Purple Bee
  if (x > 6700 - 1080 && x < 6700 && lastFingerPos.x > 550 && lastFingerPos.x < 650 && lastFingerPos.y > 200 && lastFingerPos.y < 300 && purpleBeeLoaded) {
   circleBeePurple = true;
  }
  // Netting Red Bee
  if (x > 6700 - 1080 && x < 6700 && lastFingerPos.x > 750 && lastFingerPos.x < 850 && lastFingerPos.y > 70 && lastFingerPos.y < 170 && redBeeLoaded) {
   circleBeeRed = true;
  } */
  
}

// 2. Swipe Gesture
public void swipeGestureRecognized(SwipeGesture gesture) {
  
 int fingerRightPos = 975;
 int fingerLeftPos = 0;
 
 // ********** LEVEL 2 GESTURES **********
 
 // Bridge Outline Swipe
 if (lastFingerPos.x > fingerRightPos && lastFingerPos.y > 465 && lastFingerPos.y < 650 && bridgeOutlineLoaded) {
   swipeBridgeOutline = true;
 }
 // Hedge Swipe
 if (x > 1600 - 1080 && x < 1600 && lastFingerPos.x > fingerLeftPos && lastFingerPos.x < fingerRightPos && lastFingerPos.y > 160 && lastFingerPos.y < 380 && hedgeLoaded) {
   swipeHedge = true;
 }
 // Boulder Swipe
 if (x > 3290 - 1080 && x < 3290 && lastFingerPos.x > fingerLeftPos && lastFingerPos.x < fingerRightPos && lastFingerPos.y > 480 && lastFingerPos.y < 612 && boulderSmashableLoaded) {
   swipeBoulder = true;
 }
 // Crate Swipe
 if (x > 4880 - 1080 && x < 4880 && lastFingerPos.x > fingerLeftPos && lastFingerPos.x < fingerRightPos && lastFingerPos.y > 292 && lastFingerPos.y < 580 && crateLoaded) {
   swipeCrate = true;
 }
 // Large Rock Outline Swipe
 if (x > 2130 - 1080 && x < 2130 && lastFingerPos.x > fingerLeftPos && lastFingerPos.x < fingerRightPos && lastFingerPos.y > 380 && lastFingerPos.y < 585 && largeRockOutlineLoaded) {
   swipeLargeRockOutline = true;
 }
 // Large Rock Swipe
 if (x > 2780 - 1080 && x < 2780 && lastFingerPos.x > fingerLeftPos && lastFingerPos.x < fingerRightPos && lastFingerPos.y > 410 && lastFingerPos.y < 585 && largeRock3Loaded) {
   swipeLargeRock = true;
 }
 // Dead Tree Swipe
 if (x > 4100 - 1080 && x < 4100 && lastFingerPos.x > fingerLeftPos && lastFingerPos.x < fingerRightPos && lastFingerPos.y > 150 && lastFingerPos.y < 400 && !deadTreeRainbowFishLoaded) {
   swipeDeadTree = true;
 }
 
}

void stop()
{
  player.close();
  minim.stop();
  super.stop();
  leap.stop();
}
