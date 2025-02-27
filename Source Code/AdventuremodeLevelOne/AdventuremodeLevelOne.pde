// Adventure Mode - Level 1
// Coded by Andrew Wardell
// Date: April 5, 2014
import ddf.minim.*;
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

AudioPlayer player;
Minim minim;

ResourceLoader resourceLoader;
Animation archieFlying;
Animation playerAnimWalk;
Animation playerAnimIdle;
Animation playerAnimAttack;
Animation inkbeeGreen;
Animation inkbeeGreenBubble;
Animation inkbeePurple;
Animation inkbeePurpleBubble;
Animation inkbeeRed;
Animation inkbeeRedBubble;

PVector lastFingerPos = new PVector(width/2, 1000);
Boolean gestureTest = false;
Boolean counting = true;
float bgWidth = 7001 - 1080;

PFont font;

PImage archietextbox;
PImage cursor;
PImage bg;
PImage fg;
PImage crate;
PImage tree1_2;
PImage tree2_2;
PImage tree3_2;
PImage treerainbowfish;
PImage treerainbowfish2;
PImage treerainbowfish3;
PImage holerainbowfish;
PImage largerock;
PImage crackedrock;
PImage crackedrockrainbowfish;
PImage weirdrock;
PImage weirdrockrainbowfish;
PImage smallrock;
PImage smallrockrainbowfish;
PImage log;
PImage treetrunk;

// TEXT BOXES - Archie
// *********************************************************************
Boolean textBoxArchieLoaded = false;

Boolean swipeCrate = false;
Boolean crateLoaded = true;
Boolean swipeLargeRock = false;
Boolean largeRockLoaded = true;
Boolean holeRainbowFishLoaded = false;
Boolean swipeLog = false;
Boolean logLoaded = true;
Boolean swipeCrackedRock = false;
Boolean crackedRockLoaded = true;
Boolean crackedRockRainbowFishLoaded = false;
Boolean swipeTreeTrunk = false;
Boolean treeTrunkLoaded = true;
Boolean swipeWeirdRock = false;
Boolean weirdRockLoaded = true;
Boolean weirdRockRainbowFishLoaded = false;
Boolean swipeSmallRock = false;
Boolean smallRockLoaded = true;
Boolean smallRockRainbowFishLoaded = false;
Boolean swipeTrees = false;
Boolean treeRainbowFishLoaded = false;
Boolean swipeTrees2 = false;
Boolean treeRainbowFishLoaded2 = false;
Boolean swipeTrees3 = false;
Boolean treeRainbowFishLoaded3 = false;
Boolean circleBeeGreen = false;
Boolean greenBeeLoaded = true;
Boolean circleBeePurple = false;
Boolean purpleBeeLoaded = true;
Boolean circleBeeRed = false;
Boolean redBeeLoaded = true;

float bgSpeed = 100; // Background speed: Ex. 1000 is very slow and 1 is very fast, 120 seems good
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
int swipeCrateTimer = 0;
int swipeLargeRockTimer = 0;
int swipeCrackedRockTimer = 0;
int swipeTreeTrunkTimer = 0;
int swipeWeirdRockTimer = 0;
int swipeSmallRockTimer = 0;
int swipeLogTimer = 0;
int swipeTreesTimer = 0;
int swipeTreesTimer2 = 0;
int swipeTreesTimer3 = 0;
int circleBeesTimer = 0;

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
  player = minim.loadFile("Montauk Point.mp3");
  player.play();
  
  // Loading Resource Assets
  resourceLoader = new ResourceLoader();
  archietextbox = resourceLoader.getImage("Textbox-Archie.png");
  cursor = resourceLoader.getImage("cursor.png");
  bg = resourceLoader.getImage("Background_2.png");
  fg = resourceLoader.getImage("Foreground_2.png");
  crate = resourceLoader.getImage("Crate_2.png");
  tree1_2 = resourceLoader.getImage("Tree1_2.png");
  tree2_2 = resourceLoader.getImage("Tree2_2.png");
  tree3_2 = resourceLoader.getImage("Tree3_2.png");
  treerainbowfish = resourceLoader.getImage("Tree1_RainbowFish.png");
  treerainbowfish2 = resourceLoader.getImage("Tree2_RainbowFish.png");
  treerainbowfish3 = resourceLoader.getImage("Tree3_RainbowFish.png");
  largerock = resourceLoader.getImage("LargeRock_2.png");
  holerainbowfish = resourceLoader.getImage("Hole_RainbowFish.png");
  crackedrock = resourceLoader.getImage("CrackedRock_2.png");
  crackedrockrainbowfish = resourceLoader.getImage("CrackedRock_RainbowFish.png");
  weirdrock = resourceLoader.getImage("WeirdRock_2.png");
  weirdrockrainbowfish = resourceLoader.getImage("WeirdRock_RainbowFish.png");
  smallrock = resourceLoader.getImage("SmallRock_2.png");
  smallrockrainbowfish = resourceLoader.getImage("SmallRock_RainbowFish.png");
  log = resourceLoader.getImage("Log_2.png");
  treetrunk = resourceLoader.getImage("TreeTrunk_2.png");
  
  archieFlying = new Animation("Animation/Archieframe", 7);
  playerAnimWalk = new Animation("Animation/CATWalking", 7);
  playerAnimIdle = new Animation("Animation/CATIdle", 7);
  playerAnimAttack = new Animation("Animation/CATattacking", 7);
  inkbeeGreen = new Animation("Animation/InkbeeGreen", 11);
  inkbeeGreenBubble = new Animation("Animation/InkbeeGreenBubble", 11);
  inkbeePurple = new Animation("Animation/InkbeePurple", 11);
  inkbeePurpleBubble = new Animation("Animation/InkbeePurpleBubble", 11);
  inkbeeRed = new Animation("Animation/InkbeeRed", 11);
  inkbeeRedBubble = new Animation("Animation/InkbeeRedBubble", 11);
  
  ypos = height * 0.35;
  
}

void draw() {
  
  background(255);
  fill(255);
 
  if (counting) {
    timer = (millis()/1000); // In seconds
  }
  
  
  // ******************** LEVEL 1 ASSETS INSTANTIATED ********************
  // Each image is loaded into the scene by order of instantiation
  // Ex. Background image is loaded first, so all other assets after will be in front
  // Ex. Cursor image is loaded last, so all other assets before will be behind
  
  // Background Instantiated 
  image( bg.get(int(x), 0 , bg.width-int(x), bg.height), 0, 0 );

  // Large Rock Instantiated
  if (x > 1900 - 1500 && x < 1900 && largeRockLoaded) {
    image( largerock.get(int(x), 0, largerock.width-int(x), largerock.height), 0, 0);
  }
  // Hole with Rainbow Fish Instantiated
  if (x > 1900 - 1500 && x < 1900 && holeRainbowFishLoaded) {
    image( holerainbowfish.get(int(x), 0, holerainbowfish.width-int(x), holerainbowfish.height), 0, 0);
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
  // Tree with Rainbow Fish Instantiated
  if (x > 1475 - 1500 && x < 1475 && treeRainbowFishLoaded) {
    image( treerainbowfish.get(int(x), 0, treerainbowfish.width-int(x), treerainbowfish.height), 0, 0);
  }  
  // Tree with Rainbow Fish 2 Instantiated
  if (x > 3300 - 1500 && x < 3300 && treeRainbowFishLoaded2) {
    image( treerainbowfish2.get(int(x), 0, treerainbowfish2.width-int(x), treerainbowfish2.height), 0, 0);
  }  
  // Tree with Rainbow Fish 3 Instantiated
  if (x > 5610 - 1500 && x < 5610 && treeRainbowFishLoaded3) {
    image( treerainbowfish3.get(int(x), 0, treerainbowfish3.width-int(x), treerainbowfish3.height), 0, 0);
  }
  // Weird Rock Instantiated
  if (x > 4100 - 1500 && x < 4100 && weirdRockLoaded) {
    image( weirdrock.get(int(x), 0, weirdrock.width-int(x), weirdrock.height), 0, 0);
  } 
  // Weird Rock with Rainbow Fish Instantiated
  if (x > 4100 - 1500 && x < 4100 && weirdRockRainbowFishLoaded) {
    image( weirdrockrainbowfish.get(int(x), 0, weirdrockrainbowfish.width-int(x), weirdrockrainbowfish.height), 0, 0);
  }
  // Small Rock Instantiated
  if (x > 4580 - 1500 && x < 4580 && smallRockLoaded) {
    image( smallrock.get(int(x), 0, smallrock.width-int(x), smallrock.height), 0, 0);
  }
  // Small Rock with Rainbow Fish Instantiated
  if (x > 4580 - 1500 && x < 4580 && smallRockRainbowFishLoaded) {
    image( smallrockrainbowfish.get(int(x), 0, smallrockrainbowfish.width-int(x), smallrockrainbowfish.height), 0, 0);
  }
  // Tree Trunk Instantiated
  if (x > 3700 - 1500 && x < 3700) {
    image( treetrunk.get(int(x), 0, treetrunk.width-int(x), treetrunk.height), 0, 0);
  }
  // Ink Bee Green Instantiated
  if (x > 7000 - 1500 && x < 7000 && greenBeeLoaded) {
    inkbeeGreen.display(400, 80); // Displays in the same position as the Green Ink Bee
  }
  // Ink Bee Purple Instantiated
  if (x > 7000 - 1500 && x < 7000 && purpleBeeLoaded) {
    inkbeePurple.display(600, 250); // Displays in same position as the Purple Ink Bee
  }
  // Ink Bee Red Instantiated
  if (x > 7000 - 1500 && x < 7000 && redBeeLoaded) {
    inkbeeRed.display(800, 120); // Displays in same position as the Red Ink Bee
  }
    
    
  // ******************** LEVEL 1 ANIMATION ********************
  
  float dx = lastFingerPos.x - xpos; // Distance from cursor, Leap Motion control
  int passedTime = millis() - savedTime; // Save the time that has passed in a variable
  
  if (timer < 30) {
    archieFlying.display(xpos-archieFlying.getWidth()/2, ypos + 80); // Display archie above xposition of character
  }
  if (timer >= 30) {
    archieFlying.display(archieFlying.getWidth()/2 + archiePosX + 300, archiePosY + 200); // Display archie flying
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
    playerAnimIdle.display(xpos-playerAnimIdle.getWidth()/2, ypos + rainbowCatPosY);
  }
  xpos = xpos + dx/playerMoveSpeed; // Moves player to cursor position
  
  

  // ******************** LEVEL 1 ADVANCE ********************
  
  int smallerTextSize = 25;
  int smallTextSize = 30;
  int normalTextSize = 35;
  int largeTextSize = 48;
  int middleScreenPosX = 3;
  int middleScreenPosY = 2;
  int topScreenPosY = 8;
  int textDuration = 4;
  int textDurEnd = 6; // Loading time
  
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
  // User must strike the log to continue the level
  if (logLoaded) {
    if (x <= 4030) {
      xpos = xpos + dx/playerMoveSpeed;
    } else {
      x = 4030;
      xpos = 510;
      textSize(smallTextSize);
      text("Strike the log to continue!", width/2.5, height/middleScreenPosY);
    }
  } else {
    x += xpos / bgSpeed; 
  }
  // User must catch the bees to continue the level
  if (greenBeeLoaded || purpleBeeLoaded || redBeeLoaded) {
    if (x <= 5710) {
      xpos = xpos + dx/playerMoveSpeed;
    } else {
      x = 5710;
      xpos = 310;
      textSize(smallTextSize);
      text("Circle the bees to catch them!", width/2.2, height/1.7);
    }
  } else {
    x += xpos / bgSpeed;
  }
  
  // ******************** LEVEL 1 ASSETS INSTANTIATED ********************
   
  // Crate Instantiated
  if (x < 1000 && crateLoaded) {
    image( crate.get(int(x), 0, crate.width-int(x), crate.height), 0, 0);
  }
  // Cracked Rock Instantiated
  if (x > 2650 - 1500 && x < 2650 && crackedRockLoaded) {
    image( crackedrock.get(int(x), 0, crackedrock.width-int(x), crackedrock.height), 0, 0);
  }
  // Cracked Rock Rainbow Fish Instantiated
  if (x > 2650 - 1500 && x < 2650 && crackedRockRainbowFishLoaded) {
    image( crackedrockrainbowfish.get(int(x), 0, crackedrockrainbowfish.width-int(x), crackedrockrainbowfish.height), 0, 0);
  }
  // Foreground Instantiated
  if (x < 6000) {
    image( fg.get(int(x), 0 , fg.width-int(x), fg.height), 0, 0);
  }
  // Log Instantiated
  if (x > 5000 - 1500 && x < 5000 && logLoaded) {
    image( log.get(int(x), 0, log.width-int(x), log.height), 0, 0);
  }
    
  // Cursor Instantiated
  image(cursor, lastFingerPos.x, lastFingerPos.y, 50, 50);
  
  
  
  // TEXT BOXES - Archie
  // *********************************************************************
  int firstTextStart = -100;
  int firstTextEnd = 100;
  int secondTextStart = 100;
  int secondTextEnd = 600;
  int thirdTextStart = 600;
  int thirdTextEnd = 900;
  int fourthTextStart = 5700;
  int fourthTextEnd = 6000;
  int fifthTextStart = 6000;
  int fifthTextEnd = 7001;
  
  if (textBoxArchieLoaded) {
    image( archietextbox, 0, 0);
  }
  if (x > firstTextStart && x < firstTextEnd) {
    textBoxArchieLoaded = true;
    textSize(smallerTextSize);
    text("Hmph, I thought cats were supposed to be quick.\nI've been waiting here for an eternity.", 
    width/5, height/1.15);
  }
  if (x > secondTextStart && x < secondTextEnd) {
    textBoxArchieLoaded = true;
    textSize(smallerTextSize - 5);
    text("Oh, where are my manners. My name is Archibald Reginald Thurstan 3rd!\nMy friends call me ART, but you, my saucy minion, can call me Archie.\nWe have a lot of work to do. The Grayscale Greyhound is terrorizing this land\nin a fit of jealous rage because he's as dull as a used up pencil.", 
    width/5, height/1.25);
  } 
  if (x > thirdTextStart && x < thirdTextEnd) {
    textBoxArchieLoaded = true;
    textSize(smallerTextSize);
    text("Looks like you need a lesson in art supplies.", 
    width/4, height/1.15);
  }
  if (x > fourthTextStart && x < fourthTextEnd) {
    textBoxArchieLoaded = true;
    textSize(smallerTextSize);
    text("Quick! The Inkbees are trying to destory the bridge,\ndraw circles around them or swipe at them to defeat them!", 
    width/4, height/1.15);
  }
  if (x > fifthTextStart && x < fifthTextEnd) {
    textBoxArchieLoaded = true;
    textSize(smallerTextSize);
    text("I think that's the last of them. Let's get moving.", 
    width/4, height/1.15);
  }
  
  
  
  
  
  
  // ******************** LEVEL 1 TEXT EVENTS ********************
  
  // When they circle the bees
  if (timer < circleBeesTimer + textDurEnd) {
    textSize(normalTextSize);
    text("Congratulations! You beat the level!", width/middleScreenPosX, height/middleScreenPosY);
  }
  // Welcome Text Event for a duration of time
  if (timer < 15) {
    textSize(largeTextSize);
    text("YOU ARE RAINBOW CAT", width/middleScreenPosX, height/topScreenPosY);
  }
  // Strike things
  if (x > 700 && x < 1500 && timer > 15) {
    textSize(smallTextSize);
    text("Strike things to gain points!\nYou might even find Rainbow Fish!", width/middleScreenPosX, height/topScreenPosY);
  }
  // Help Text Event 1 - Telling the user to strike the crate
  if (crateLoaded && timer > 7 && timer < 20) {
    textSize(smallTextSize);
    text("Strike the Crate!", width/middleScreenPosX, height/middleScreenPosY);
  }
  // Help Text Event 2 - Reminding the user to strike the crate
  if (crateLoaded && timer > 20) {
    textSize(smallTextSize);
    text("Strike the Crate by swiping\nLeft and Right using the Leap Motion!", width/middleScreenPosX, height/middleScreenPosY);
  }
  // Swipe Crate Text Event, encourage thy player!
  if (!crateLoaded && timer < swipeCrateTimer + textDuration) {
    textSize(normalTextSize);
    text("Amazing! +100 Points", width/middleScreenPosX, height/middleScreenPosY);
  }  
  // Swipe Large Rock Text Event, encourage thy player!
  if (!largeRockLoaded && timer < swipeLargeRockTimer + textDuration) {
    textSize(normalTextSize);
    text("Look at the size of those fish! +50 Points", width/middleScreenPosX - 0.5, height/middleScreenPosY);
  }  
  // Swipe Cracked Rock Text Event, encourage thy player!
  if (!crackedRockLoaded && timer < swipeCrackedRockTimer + textDuration) {
    textSize(normalTextSize);
    text("Wasn't even hard! +50 Points", width/middleScreenPosX, height/topScreenPosY);
  }  
  // Swipe Tree Trunk Event, encourage thy player!
  if (!treeTrunkLoaded && timer < swipeTreeTrunkTimer + textDuration - 1) {
    //textSize(normalTextSize);
    //text("Swipe for more! +1 each!", width/middleScreenPosX, height/middleScreenPosXY);
  }  
  // Swipe Weird Rock Text Event, encourage thy player!
  if (!weirdRockLoaded && timer < swipeWeirdRockTimer + textDuration) {
    textSize(normalTextSize);
    text("\"Wonderful Rock\"! +50 Points", width/middleScreenPosX, height/middleScreenPosY);
  }  
  // Swipe Small Rock Text Event, encourage thy player!
  if (!smallRockLoaded && timer < swipeSmallRockTimer + textDuration - 1) {
    textSize(normalTextSize);
    text("Easy one! +50 Points", width/middleScreenPosX, height/topScreenPosY + 2);
  }  
  // Swipe Log Text Event, encourage thy player!
  if (!logLoaded && timer < swipeLogTimer + textDuration - 1) {
    textSize(normalTextSize);
    text("Erase away! +100 Points", width/middleScreenPosX, height/middleScreenPosY);
  }  
  // Swipe Trees 1 Text Event, encourage thy player!
  if (treeRainbowFishLoaded && timer < swipeTreesTimer + textDuration) {
    textSize(normalTextSize);
    text("Rainbow Fish Get! +20 Points", width/middleScreenPosX, height/middleScreenPosY);
  }  
  // Swipe Trees 2 Text Event, encourage thy player!
  if (treeRainbowFishLoaded2 && timer < swipeTreesTimer2 + textDuration) {
    textSize(normalTextSize);
    text("Rainbow Fish Get! +30 Points", width/middleScreenPosX, height/middleScreenPosY);
  }  
  // Swipe Trees 3 Text Event, encourage thy player!
  if (treeRainbowFishLoaded3 && timer < swipeTreesTimer3 + textDuration) {
    textSize(normalTextSize);
    text("Rainbow Fish Get! +30 Points", width/middleScreenPosX, height/middleScreenPosY);
  }
  


  // ******************** LEVEL 1 GESTURE INTERACTION ********************
  
  // Swiping the crate
  if (swipeCrate) {
    scoreCount += 100;
    crateLoaded = false;
    swipeCrate = false;
    timer = swipeCrateTimer;
    swipeCrateTimer = (millis()/1000) - swipeCrateTimer;
  }  
  // Swiping the large rock
  if (swipeLargeRock) {
    scoreCount += 50;
    holeRainbowFishLoaded = true;
    largeRockLoaded = false;
    swipeLargeRock = false;
    timer = swipeLargeRockTimer;
    swipeLargeRockTimer = (millis()/1000) - swipeLargeRockTimer;
  }
  // Swiping the cracked rock
  if (swipeCrackedRock) {
    scoreCount += 50;
    crackedRockRainbowFishLoaded = true;
    crackedRockLoaded = false;
    swipeCrackedRock = false;
    timer = swipeCrackedRockTimer;
    swipeCrackedRockTimer = (millis()/1000) - swipeCrackedRockTimer;
  }  
  // Swiping the tree trunk
  if (swipeTreeTrunk) {
    scoreCount += 1;
    treeTrunkLoaded = false;
    swipeTreeTrunk = false;
    timer = swipeTreeTrunkTimer;
    swipeTreeTrunkTimer = (millis()/1000) - swipeTreeTrunkTimer;
  }  
  // Swiping the weird rock
  if (swipeWeirdRock) {
    scoreCount += 50;
    weirdRockRainbowFishLoaded = true;
    weirdRockLoaded = false;
    swipeWeirdRock = false;
    timer = swipeWeirdRockTimer;
    swipeWeirdRockTimer = (millis()/1000) - swipeWeirdRockTimer;
  }  
  // Swiping the small rock
  if (swipeSmallRock) {
    scoreCount += 50;
    smallRockRainbowFishLoaded = true;
    smallRockLoaded = false;
    swipeSmallRock = false;
    timer = swipeSmallRockTimer;
    swipeSmallRockTimer = (millis()/1000) - swipeSmallRockTimer;
  }
  // Swiping the log
  if (swipeLog) {
    scoreCount += 100;
    logLoaded = false;
    swipeLog = false;
    timer = swipeLogTimer;
    swipeLogTimer = (millis()/1000) - swipeLogTimer;
  }
  // Swiping the trees
  if (swipeTrees) {
    scoreCount += 20;
    treeRainbowFishLoaded = true;
    swipeTrees = false;
    timer = swipeTreesTimer;
    swipeTreesTimer = (millis()/1000) - swipeTreesTimer;
  }
  // Swiping the trees 2
  if (swipeTrees2) {
    scoreCount += 30;
    treeRainbowFishLoaded2 = true;
    swipeTrees2 = false;
    timer = swipeTreesTimer2;
    swipeTreesTimer2 = (millis()/1000) - swipeTreesTimer2;
  }
  // Swiping the trees 3
  if (swipeTrees3) {
    scoreCount += 30;
    treeRainbowFishLoaded3 = true;
    swipeTrees3 = false;
    timer = swipeTreesTimer3;
    swipeTreesTimer3 = (millis()/1000) - swipeTreesTimer3;
  }
  // Circling the Green Bee
  if (circleBeeGreen) {
    scoreCount += 10;
    inkbeeGreenBubble.display(400, 80);
    greenBeeLoaded = false;
    circleBeeGreen = false;
  }
  // Circling the Purple Bee
  if (circleBeePurple) {
    scoreCount += 10;
    inkbeePurpleBubble.display(600, 250);
    purpleBeeLoaded = false;
    circleBeePurple = false;
  }
  // Circling the Red Bee
  if (circleBeeRed) {
    scoreCount += 10;
    inkbeeRedBubble.display(800, 120);
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
    timer = circleBeesTimer;
    circleBeesTimer = (millis()/1000) - circleBeesTimer;
    player.close();
  }
  // Score Counter
  textSize(32);
  text("Score: " + scoreCount, 45, height - 30);
  
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
}

// 1.Circle Gesture
public void circleGestureRecognized(CircleGesture gesture, String clockwiseness) {
  
  // ********** LEVEL 1 GESTURES **********
  
  // Netting Green Bee
  if (x > 6700 - 1080 && x < 6700 && lastFingerPos.x > 400 - 115 && lastFingerPos.x < 400 + 115 && lastFingerPos.y > 80 - 131 && lastFingerPos.y < 80 + 131 && greenBeeLoaded) {
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
   circleBeeGreen = true;
  }
  // Netting Purple Bee
  if (x > 6700 - 1080 && x < 6700 && lastFingerPos.x > 600 - 115 && lastFingerPos.x < 600 + 115 && lastFingerPos.y > 250 - 131 && lastFingerPos.y < 250 + 131 && purpleBeeLoaded) {
   circleBeePurple = true;
  }
  // Netting Red Bee
  if (x > 6700 - 1080 && x < 6700 && lastFingerPos.x > 800 - 115 && lastFingerPos.x < 800 + 115 && lastFingerPos.y > 120 - 131 && lastFingerPos.y < 120 + 131 && redBeeLoaded) {
   circleBeeRed = true;
  }
  
}

// 2. Swipe Gesture
public void swipeGestureRecognized(SwipeGesture gesture) {
  
 int fingerRightPos = 975;
 int fingerLeftPos = 0;
 
 // ********** LEVEL 1 GESTURES **********
 
 // Crate Swipe
 if (lastFingerPos.x > 600  && lastFingerPos.y > 240 && lastFingerPos.y < 600 && crateLoaded) {
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
  swipeCrate = true;
 }
 // Large Rock Swipe
 if (x > 600 && lastFingerPos.x > fingerLeftPos && lastFingerPos.x < fingerRightPos && lastFingerPos.y > 350 && lastFingerPos.y < 550 && largeRockLoaded) {
  swipeLargeRock = true;
 }
 // Cracked Rock Swipe
 if (x > 2650 - 1080 && x < 2650 && lastFingerPos.x > fingerLeftPos && lastFingerPos.x < fingerRightPos && lastFingerPos.y > 500 && lastFingerPos.y < 645 && crackedRockLoaded) {
  swipeCrackedRock = true;
 }
 // Tree Trunk Swipe
 if (x > 3680 - 1080 && x < 3680 && lastFingerPos.x > fingerLeftPos && lastFingerPos.x < fingerRightPos && lastFingerPos.y > 600 && lastFingerPos.y < 720 && treeTrunkLoaded) {
  swipeTreeTrunk = true;
 }
 // Weird Rock Swipe
 if (x > 4060 - 1080 && x < 4060 && lastFingerPos.x > fingerLeftPos && lastFingerPos.x < fingerRightPos && lastFingerPos.y > 370 && lastFingerPos.y < 560 && weirdRockLoaded) {
  swipeWeirdRock = true;
 }
 // Small Rock Swipe
 if (x > 4530 - 1080 && x < 4530 && lastFingerPos.x > fingerLeftPos && lastFingerPos.x < fingerRightPos && lastFingerPos.y > 540 && lastFingerPos.y < 720 && smallRockLoaded) {
  swipeSmallRock = true;
 }
 // Log Swipe
 if (x > 5050 - 1080 && x < 5050 && lastFingerPos.x > fingerLeftPos && lastFingerPos.x < fingerRightPos && lastFingerPos.y > 480 && lastFingerPos.y < 680 && logLoaded) {
  swipeLog = true;
 }
 // Trees 1 Swipe
 if (x > 1530 - 1080 && x < 1530 && lastFingerPos.x > fingerLeftPos && lastFingerPos.x < fingerRightPos && lastFingerPos.y > 0 && lastFingerPos.y < 300 && !treeRainbowFishLoaded) {
  swipeTrees = true;
 }
 // Trees 2 Swipe
 if (x > 3320 - 1080 && x < 3320 && lastFingerPos.x > fingerLeftPos && lastFingerPos.x < fingerRightPos && lastFingerPos.y > 0 && lastFingerPos.y < 300 && !treeRainbowFishLoaded2) {
  swipeTrees2 = true;
 }
 // Trees 3 Swipe
 if (x > 5700 - 1080 && x < 5700 && lastFingerPos.x > fingerLeftPos && lastFingerPos.x < fingerRightPos && lastFingerPos.y > 0 && lastFingerPos.y < 300 && !treeRainbowFishLoaded3) {
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
