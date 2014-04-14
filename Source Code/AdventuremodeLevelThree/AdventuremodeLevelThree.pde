// Adventure Mode - Level 3
// Coded by Andrew Wardell
// Date: April 13, 2014

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
AudioPlayer player2;
Minim minim;

ResourceLoader resourceLoader;
Animation archieFlying;
Animation playerAnimWalk;
Animation playerAnimIdle;
Animation playerAnimAttack;
Animation playerFalling;
Animation dingoBarking;
Animation dingoSquished;
Animation dingoStars;
Animation dingoTailWag;
Animation dingoWalking;

PVector lastFingerPos = new PVector(width/2, 1000);
Boolean gestureTest = false;
Boolean counting = true;
float bgHeight = 4000 - 1080;
float bgEndWidth = 1546 - 1080;

PFont font;

PImage archietextbox;
PImage dingotextbox;
PImage cursor;
PImage bgpart1;
PImage fgpart1;
PImage bgpart2;
PImage fgpart2;
PImage bgfalling;
PImage bgpart3;
PImage fgpart3;
PImage bgend;
PImage fgend;
PImage ceilingrock;
PImage breakablecrystals;
PImage breakablecrystalsrainbowfish;
PImage crackedrock;
PImage crackedrockrainbowfish;
PImage rainbowfishbackground;
PImage weirdrock;
PImage weirdrockrainbowfish;
PImage hole;
PImage dotboxes;
PImage stackedboxes;
PImage crackedrock2;
PImage crackedrock2rainbowfish;
PImage weirdrock2;
PImage weirdrock2rainbowfish;
PImage erasedcrystals1;
PImage erasedcrystals2;
PImage dotbox;
PImage box;

Boolean textBoxArchieLoaded = true;
Boolean textBoxDingoLoaded = false;

Boolean playerPosStop = false;
Boolean bgPart1Loaded = true;
Boolean bgPart2Loaded = false;
Boolean bgPart3Loaded = false;
Boolean bgFallingLoaded = false;
Boolean bgLoaded = false;
Boolean bgEndFightLoaded = false;
Boolean bgEndLoaded = false;
Boolean ceilingrockLoaded = false;
Boolean swipeBreakablecrystals = false;
Boolean breakableCrystalsLoaded = true;
Boolean breakableCrystalsRainbowFishLoaded = false;
Boolean swipeCrackedRock = false;
Boolean crackedRockLoaded = true;
Boolean crackedRockRainbowFishLoaded = false;
Boolean swipeRainbowFishBackground = false;
Boolean rainbowFishBackgroundLoaded = false;
Boolean holeLoaded = true;
Boolean swipeWeirdRock = false;
Boolean weirdRockLoaded = true;
Boolean weirdRockRainbowFishLoaded = false;
Boolean swipeDotBoxes = false;
Boolean dotBoxesLoaded = true;
Boolean stackedBoxesLoaded = false;
Boolean swipeWeirdRock2 = false;
Boolean weirdRock2Loaded = true;
Boolean weirdRock2RainbowFishLoaded = false;
Boolean swipeCrackedRock2 = false;
Boolean crackedRock2Loaded = true;
Boolean crackedRock2RainbowFishLoaded = false;
Boolean swipeErasedCrystals = false;
Boolean erasedCrystals1Loaded = true;
Boolean erasedCrystals2Loaded = false;
Boolean swipeDotBox = false;
Boolean dotBoxLoaded = true;
Boolean boxLoaded = false;
Boolean dingoLoaded = true;
Boolean dingoBarkAnim = false;
Boolean dingoStarsAnim = false;

float bgSpeed = 130; // Background speed: Ex. 1000 is very slow and 1 is very fast, 130 seems good
float playerMoveSpeed = 50; // Player speed according to Leap Position X: Ex. 100 is smooth, slow and 1 is fastest, 50 seems good
float fallingSpeed = 20;
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
int swipeBreakablecrystalsTimer = 0;
int swipeCrackedRockTimer = 0;
int swipeRainbowFishBackgroundTimer = 0;
int swipeDotBoxesTimer = 0;
int swipeWeirdRockTimer = 0;
int swipeWeirdRock2Timer = 0;
int swipeCrackedRock2Timer = 0;
int swipeErasedCrystalsTimer = 0;
int swipeDotBoxTimer = 0;
int exitCaveTimer = 0;

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
  leap.enableGesture(Type.TYPE_SWIPE);
  
  // Font Implementation
  font = createFont("Roboto-Regular.ttf", 1);
  textFont(font);
  
  // Playing audio files
  minim = new Minim(this);
  player = minim.loadFile("Groove Grove.mp3");
  player2 = minim.loadFile("Netherworld Shanty.mp3");
  player.play();
  
  // Loading Resource Assets
  resourceLoader = new ResourceLoader();
  archietextbox = resourceLoader.getImage("Textbox-Archie.png");
  dingotextbox = resourceLoader.getImage("Textbox-Dingo.png");
  cursor = resourceLoader.getImage("cursor.png");
  bgpart1 = resourceLoader.getImage("background pt1.png");
  fgpart1 = resourceLoader.getImage("foreground pt1.png");
  bgpart2 = resourceLoader.getImage("background pt2.png");
  fgpart2 = resourceLoader.getImage("foreground pt2.png");
  bgfalling = resourceLoader.getImage("background - falling.png");
  bgpart3 = resourceLoader.getImage("background pt3.png");
  fgpart3 = resourceLoader.getImage("foreground pt3.png");
  bgend = resourceLoader.getImage("background end.png");
  fgend = resourceLoader.getImage("foreground end.png");
  ceilingrock = resourceLoader.getImage("CeilingRock1_3.png");
  breakablecrystals = resourceLoader.getImage("BreakableCrystals_3.png");
  breakablecrystalsrainbowfish = resourceLoader.getImage("BreakableCrystals_RainbowFish.png");
  crackedrock = resourceLoader.getImage("CrackedRock_3.png");
  crackedrockrainbowfish = resourceLoader.getImage("CrackedRock_RainbowFish3.png");
  rainbowfishbackground = resourceLoader.getImage("RainbowFishBackground.png");
  hole = resourceLoader.getImage("hole_3.png");
  weirdrock = resourceLoader.getImage("WeirdRock_3.png");
  weirdrockrainbowfish = resourceLoader.getImage("WeirdRock_RainbowFish3.png");
  dotboxes = resourceLoader.getImage("dotBoxes_3.png");
  stackedboxes = resourceLoader.getImage("StackedBoxes_3.png");
  weirdrock2 = resourceLoader.getImage("WeirdRock_2.png");
  weirdrock2rainbowfish = resourceLoader.getImage("WeirdRock_RainbowFish2.png");
  crackedrock2 = resourceLoader.getImage("CrackedRock_2.png");
  crackedrock2rainbowfish = resourceLoader.getImage("CrackedRock_RainbowFish2.png");
  erasedcrystals1 = resourceLoader.getImage("ErasedCrystal-1_3.png");
  erasedcrystals2 = resourceLoader.getImage("ErasedCrystal-2_3.png");
  dotbox = resourceLoader.getImage("dotBox_3.png");
  box = resourceLoader.getImage("box_3.png");
  
  archieFlying = new Animation("Animation/Archieframe", 7);
  playerAnimWalk = new Animation("Animation/CATWalking", 7);
  playerAnimIdle = new Animation("Animation/CATIdle", 7);
  playerAnimAttack = new Animation("Animation/CATattacking", 7);
  playerFalling = new Animation("Animation/CATfalling", 7);
  dingoBarking = new Animation("Animation/Dingo-Barking", 4);
  dingoSquished = new Animation("Animation/Dingo-Squished", 6);
  dingoStars = new Animation("Animation/Dingo-Stars", 3);
  dingoTailWag = new Animation("Animation/Dingo-TailWag", 3);
  dingoWalking = new Animation("Animation/Dingo-Walking", 6);
  
  ypos = height * 0.35;
  xpos = 200;
  
}

void draw() {
  
  background(255);
  fill(255);
 
  if (counting) {
    timer = (millis()/1000); // In seconds
  }
  
  
  // ******************** LEVEL 3 ASSETS INSTANTIATED ********************
  // Each image is loaded into the scene by order of instantiation
  // Ex. Background image is loaded first, so all other assets after will be in front
  // Ex. Cursor image is loaded last, so all other assets before will be behind
  
  // Background Part 1 Instantiated
  if (bgPart1Loaded) {
    image( bgpart1.get(int(x), 0 , bgpart1.width-int(x), bgpart1.height), 0, 0 );
    
    // Foreground Part 1 Instantiated
    if (x < 1080) {
      image( fgpart1.get(int(x), 0 , fgpart1.width-int(x), fgpart1.height), 0, 0);
    }
  }
  // Background Part 2 Instantiated
  if (bgPart2Loaded) {
    image( bgpart2.get(int(x), 0 , bgpart2.width-int(x), bgpart2.height), 0, 0 );
    
    // Cracked Rock Instantiated
    if (x > 1340 - 1500 && x < 1340 && crackedRockLoaded) {
      image( crackedrock.get(int(x), 0, crackedrock.width-int(x), crackedrock.height), 0, 0);
    }
    // Cracked Rock with Rainbow Fish Instantiated
    if (x > 1340 - 1500 && x < 1340 && crackedRockRainbowFishLoaded) {
      image( crackedrockrainbowfish.get(int(x), 0, crackedrockrainbowfish.width-int(x), crackedrockrainbowfish.height), 0, 0);
    }
    // Rainbow Fish in Background Instantiated
    if (x > 1330 - 1500 && x < 1330 && rainbowFishBackgroundLoaded) {
      image( rainbowfishbackground.get(int(x), 0, rainbowfishbackground.width-int(x), rainbowfishbackground.height), 0, 0);
    }
    // Hole Instantiated
    if (x > 1590 - 1500 && x < 1590 && holeLoaded) {
      image( hole.get(int(x), 0, hole.width-int(x), hole.height), 0, 0);
    }
    
  }
  // Background Falling Instantiated
  if (bgFallingLoaded) {
    if (y < bgHeight) { 
      image( bgfalling.get(0, int(y), bgfalling.width, bgfalling.height-int(y)), 0, 0 );
    } else {
      bgPart3Loaded = true;
      bgFallingLoaded = false;
    }
    y += fallingSpeed; 
  }
  // Background Part 3 Instantiated
  if (bgPart3Loaded) {    
    image( bgpart3.get(int(x), 0 , bgpart3.width-int(x), bgpart3.height), 0, 0);
    bgFallingLoaded = false;
    y = 0;
    x = 0;
    // Weird Rock Instantiated
    if (x < 1080 && weirdRockLoaded) {
      image( weirdrock.get(int(x), 0 , weirdrock.width-int(x), weirdrock.height), 0, 0);
    }
    // Weird Rock with Rainbow Fish Instantiated
    if (x < 1080 && weirdRockRainbowFishLoaded) {
      image( weirdrockrainbowfish.get(int(x), 0 , weirdrockrainbowfish.width-int(x), weirdrockrainbowfish.height), 0, 0);
    }
    // Dot Boxes Instantiated
    if (x < 1080 && dotBoxesLoaded) {
      image( dotboxes.get(int(x), 0 , dotboxes.width-int(x), dotboxes.height), 0, 0);
    }
    // Stacked Boxes Instantiated
    if (x < 1080 && stackedBoxesLoaded) {
      image( stackedboxes.get(int(x), 0 , stackedboxes.width-int(x), stackedboxes.height), 0, 0);
    }
  }
  if (bgLoaded) {  
    image( bgend.get(int(x), 0 , bgend.width-int(x), bgend.height), 0, 0);
    
    // Background End Fight Instantiated
    if (bgEndFightLoaded) {
      bgPart3Loaded = false;
      bgSpeed = 150;
      //player.close();
      player2.play();
      x += xpos / bgSpeed;
      // Weird Rock 2 Instantiated
      if (x < 1546 && weirdRock2Loaded) {
        image( weirdrock2.get(int(x), 0 , weirdrock2.width-int(x), weirdrock2.height), 0, 0);
      }
      // Weird Rock 2 with Rainbow Fish Instantiated
      if (x < 1546 && weirdRock2RainbowFishLoaded) {
        image( weirdrock2rainbowfish.get(int(x), 0 , weirdrock2rainbowfish.width-int(x), weirdrock2rainbowfish.height), 0, 0);
      }
      // Cracked Rock 2 Instantiated
      if (x > 1160 - 1500 && x < 1160 && crackedRock2Loaded) {
        image( crackedrock2.get(int(x), 0, crackedrock2.width-int(x), crackedrock2.height), 0, 0);
      }
      // Cracked Rock 2 with Rainbow Fish Instantiated
      if (x > 1160 - 1500 && x < 1160 && crackedRock2RainbowFishLoaded) {
        image( crackedrock2rainbowfish.get(int(x), 0, crackedrock2rainbowfish.width-int(x), crackedrock2rainbowfish.height), 0, 0);
      }
      // Erased Crystals 1 Instantiated
      if (x > 1160 - 1500 && x < 1160 && erasedCrystals1Loaded) {
        image( erasedcrystals1.get(int(x), 0, erasedcrystals1.width-int(x), erasedcrystals1.height), 0, 0);
      }
      // Erased Crystals 2 Instantiated
      if (x > 1160 - 1500 && x < 1160 && erasedCrystals2Loaded) {
        image( erasedcrystals2.get(int(x), 0, erasedcrystals2.width-int(x), erasedcrystals2.height), 0, 0);
      }
      // Dot Box Instantiated
      if (x > 1400 - 1500 && x < 1400 && dotBoxLoaded) {
        image( dotbox.get(int(x), 0, dotbox.width-int(x), dotbox.height), 0, 0);
      }
      // Box Instantiated
      if (x > 1400 - 1500 && x < 1400 && boxLoaded) {
        image( box.get(int(x), 0, box.width-int(x), box.height), 0, 0);
      }
    }
  }
    
    
  // ******************** LEVEL 3 ANIMATION and ADVANCE ********************
  
  float dx = lastFingerPos.x - xpos; // Distance from cursor, Leap Motion control
  int passedTime = millis() - savedTime; // Save the time that has passed in a variable
  
  int smallerTextSize = 25;
  int smallTextSize = 30;
  int normalTextSize = 35;
  int largeTextSize = 48;
  int middleScreenPosX = 3;
  int middleScreenPosY = 2;
  int topScreenPosY = 8;
  int textDuration = 4;
  int textDurEnd = 3; // Loading time
  
  // When the player is falling, only show the falling animation
  if (bgFallingLoaded) {
    playerFalling.display(xpos-playerFalling.getWidth()/2, 400);
  }
  if (timer < 30) {
    archieFlying.display(xpos-archieFlying.getWidth()/2, ypos + 80); // Display archie above xposition of character
  }
  if (timer >= 30) {
    archieFlying.display(archieFlying.getWidth()/2 + archiePosX + 300, archiePosY + 200); // Display archie flying
  }
  // When the Player is not falling
  if (!bgFallingLoaded) {
    if (dx > 40 || dx < -40) {
      if (passedTime > 4000) {
        float randx = 100;
        float randy = 100;
        archiePosX = random(-randx, randx);
        archiePosY = random(-randy, randy);
        savedTime = millis();
      }
      if (!playerPosStop) {
        playerAnimWalk.display(xpos-playerAnimWalk.getWidth()/2, ypos + rainbowCatPosY);
      }
    } else {
      playerAnimIdle.display(xpos-playerAnimIdle.getWidth()/2, ypos + rainbowCatPosY);
    }
  }
  if (playerPosStop) {
    playerAnimIdle.display(xpos-playerAnimIdle.getWidth()/2, ypos + rainbowCatPosY);
  } 
  xpos = xpos + dx/playerMoveSpeed; // Moves player to cursor position
  
  // Control flow of events
  // When Part 1 Ends
  if (xpos > 700 && bgPart1Loaded) {
    bgPart1Loaded = false;
    bgPart2Loaded = true;
    xpos = 50;
  }
  if (bgPart2Loaded) {    
    if (ceilingrockLoaded) {
      if (xpos < 200) {
        xpos = xpos + dx/playerMoveSpeed;
      } else {
        playerPosStop = true;
        xpos = 200;
      }
    } else {
      playerPosStop = false;
      x += xpos / bgSpeed; 
    }
  }
  // When Part 2 Ends
  if (x > 470 && bgPart2Loaded) {
    bgPart2Loaded = false;
    bgFallingLoaded = true;
  }
  // When Part 3 Ends
  if (xpos > 800 && bgPart3Loaded && stackedBoxesLoaded) {
    bgPart3Loaded = false;
    bgEndFightLoaded = true;
    bgLoaded = true;
  }
  // Dingo End Fight
  if (bgEndFightLoaded) {    
    if (dingoLoaded) {
      if (x <= bgEndWidth) {
        xpos = xpos + dx/playerMoveSpeed;
      } else {
        dingoBarkAnim = true;
        playerPosStop = true;
        x = bgEndWidth;
        xpos = 500;
        textSize(largeTextSize);
        text("DEFEAT DINGO", width/middleScreenPosX, height/topScreenPosY);
      }
    }
  } else {
    // When End Fight is over, player moves to right and level ends
    if (xpos > 900 && dingoStarsAnim) {
      bgEndLoaded = true;
      dingoStarsAnim = false;
    } else {      
      playerPosStop = false;
      xpos = xpos + dx/playerMoveSpeed;
    }
  }
  // Dingo Barking Instantiated
  if (x > 1920 - 1500 && x < 1920 && dingoBarkAnim) {
    dingoBarking.display(770, 440);
  }
  // Dingo Barking Instantiated
  if (x > 1920 - 1500 && x < 1920 && dingoStarsAnim) {
    dingoStars.display(770, 440);
  }
  
    
  
  // ******************** LEVEL 3 ASSETS INSTANTIATED ********************
  
  // Background Part 2 Instantiated
  if (bgPart2Loaded) {
    // Ceiling Rock Instantiated
    if (ceilingrockLoaded) {
      image( ceilingrock.get(int(x), 0, ceilingrock.width-int(x), ceilingrock.height), 0, 0);
    }
    // Foreground Part 2 Instantiated
    if (x < 2950) {
      image( fgpart2.get(int(x), 0 , fgpart2.width-int(x), fgpart2.height), 0, 0 );
    }
    // Breakable Crystals Instantiated
    if (x > 1080 - 1500 && x < 1340 && breakableCrystalsLoaded) {
      image( breakablecrystals.get(int(x), 0, breakablecrystals.width-int(x), breakablecrystals.height), 0, 0);
    }
    // Breakable Crystals with Rainbow Fish Instantiated
    if (x > 1080 - 1500 && x < 1340 && breakableCrystalsRainbowFishLoaded) {
      image( breakablecrystalsrainbowfish.get(int(x), 0, breakablecrystalsrainbowfish.width-int(x), breakablecrystalsrainbowfish.height), 0, 0);
    }
  }
  // Background Part 3 Instantiated
  if (bgPart3Loaded) {        
    // Foreground Part 3 Instantiated
    if (x < 1080) {
      image( fgpart3.get(int(x), 0 , fgpart3.width-int(x), fgpart3.height), 0, 0);
    }
  }
  if (bgEndFightLoaded) {
    // Foreground End Instantiated
    if (x < 1546) {
      image( fgend.get(int(x), 0 , fgend.width-int(x), fgend.height), 0, 0);
    }
    
  }
  
  // Cursor Instantiated
  image(cursor, lastFingerPos.x, lastFingerPos.y, 50, 50);
  
  
  // TEXT BOXES - Archie and Dingo
  // *********************************************************************
  
  if (textBoxArchieLoaded) {
    image( archietextbox, 0, 0);
  }
  if (textBoxDingoLoaded) {
    image( dingotextbox, 0, 0);
  }
  if (bgPart1Loaded) {
    textBoxArchieLoaded = true;
    textSize(smallerTextSize);
    text("Dingo's gone into the Rainbow Cave, after him!\nBut be careful, the cave may be a bit unstable.", 
    width/5, height/1.2);
  }
  if (bgPart3Loaded) {
    textBoxArchieLoaded = true;
    textSize(smallerTextSize);
    text("Trace those lines and create some stairs for us to get back up.", 
    width/5, height/1.15);
  }
  if (bgEndFightLoaded && x < 500) {
    textBoxArchieLoaded = true;
    textSize(smallerTextSize);
    text("Stop! Don't you erase one more thing!", 
    width/5, height/1.2);
  }
  if (bgEndFightLoaded && x >= 500) {
    textBoxArchieLoaded = true;
    textSize(smallerTextSize);
    text("That scoundrel. Quick, draw a box over him to knock him out.", 
    width/5, height/1.2);
  }
  if (dingoStarsAnim) {
    textBoxArchieLoaded = true;
    textBoxDingoLoaded = false;
    textSize(smallerTextSize);
    text("Good job!", 
    width/5, height/1.2);
  }
  if (!dingoLoaded) {
    textBoxDingoLoaded = true;
    textBoxArchieLoaded = false;
    textSize(smallerTextSize);
    text("Your attempts are futile. You'll never defeat my master.", 
    width/5, height/1.2);
  }
  
  
  
  
  // ******************** LEVEL 3 TEXT EVENTS ********************
  
  
  // Welcome Text Event
  if (timer < 1337 && bgPart1Loaded) {
    textSize(largeTextSize);
    text("ENTER THE CAVE", width/middleScreenPosX, height/topScreenPosY);
  }
  // Swipe Breakable Crystals Text Event, encourage thy player!
  if (!breakableCrystalsLoaded && timer < swipeBreakablecrystalsTimer + textDuration && bgPart2Loaded) {
    textSize(normalTextSize);
    text("Beautiful Colours! +50 Points", width/middleScreenPosX, height/middleScreenPosY);
  }
  // Text Event - Drawing the boxes
  if (!stackedBoxesLoaded && bgPart3Loaded) {
    textSize(normalTextSize);
    text("Draw the boxes to continue!", width/middleScreenPosX, height/middleScreenPosY);
  }
  // Swipe Dot Boxes Text, encourage thy player!
  if (timer < swipeDotBoxesTimer + textDuration && bgPart3Loaded) {
    textSize(normalTextSize);
    text("Nice! Continue by climbing up!", width/middleScreenPosX, height/middleScreenPosY);
  }
  // When they finish level text
  if (timer < exitCaveTimer + textDurEnd) {
    textSize(normalTextSize);
    text("Congratulations! You beat the level!", width/middleScreenPosX, height/middleScreenPosY);
  }
  // End Fight is over
  if (timer < swipeDotBoxTimer + textDuration + 5 && bgEndLoaded) {
    dingoLoaded = false;
    boxLoaded = false;
  }
  
  

  // ******************** LEVEL 3 GESTURE INTERACTION ********************
  
  // Swiping the breakable crystals
  if (swipeBreakablecrystals) {
    scoreCount += 50;
    breakableCrystalsRainbowFishLoaded = true;
    breakableCrystalsLoaded = false;
    swipeBreakablecrystals = false;
    timer = swipeBreakablecrystalsTimer;
    swipeBreakablecrystalsTimer = (millis()/1000) - swipeBreakablecrystalsTimer;
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
  // Swiping the Rainbow Fish in background
  if (swipeRainbowFishBackground) {
    scoreCount += 10;
    rainbowFishBackgroundLoaded = true;
    swipeRainbowFishBackground = false;
    timer = swipeRainbowFishBackgroundTimer;
    swipeRainbowFishBackgroundTimer = (millis()/1000) - swipeRainbowFishBackgroundTimer;
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
  // Swiping the Dot Boxes in Part 3
  if (swipeDotBoxes) {
    scoreCount += 50;
    stackedBoxesLoaded = true;
    dotBoxesLoaded = false;
    swipeDotBoxes = false;
    timer = swipeDotBoxesTimer;
    swipeDotBoxesTimer = (millis()/1000) - swipeDotBoxesTimer;
  }
  // Swiping the weird rock 2
  if (swipeWeirdRock2) {
    scoreCount += 50;
    weirdRock2RainbowFishLoaded = true;
    weirdRock2Loaded = false;
    swipeWeirdRock2 = false;
    timer = swipeWeirdRock2Timer;
    swipeWeirdRock2Timer = (millis()/1000) - swipeWeirdRock2Timer;
  }
  // Swiping the cracked rock 2
  if (swipeCrackedRock2) {
    scoreCount += 50;
    crackedRock2RainbowFishLoaded = true;
    crackedRock2Loaded = false;
    swipeCrackedRock2 = false;
    timer = swipeCrackedRock2Timer;
    swipeCrackedRock2Timer = (millis()/1000) - swipeCrackedRock2Timer;
  }
  // Swiping the erased crystals
  if (swipeErasedCrystals) {
    scoreCount += 50;
    erasedCrystals2Loaded = true;
    erasedCrystals1Loaded = false;
    swipeErasedCrystals = false;
    timer = swipeErasedCrystalsTimer;
    swipeErasedCrystalsTimer = (millis()/1000) - swipeErasedCrystalsTimer;
  }
  // Swiping Dot Box in End Fight
  if (swipeDotBox) {
    boxLoaded = true;
    dotBoxLoaded = false;
    swipeDotBox = false;
    dingoStarsAnim = true;
    dingoBarkAnim = false;
    bgEndFightLoaded = false;
    timer = swipeDotBoxTimer;
    swipeDotBoxTimer = (millis()/1000) - swipeDotBoxTimer;
  }
  // Level End Event
  if (bgEndLoaded) {
    println("Level Ended. Score: " + scoreCount);
    bgEndLoaded = false;
    x = 0;
    xpos = 500;
    scoreCount = 0;
    timer = exitCaveTimer;
    exitCaveTimer = (millis()/1000) - exitCaveTimer;
    player2.close();
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
}

// 2. Swipe Gesture
public void swipeGestureRecognized(SwipeGesture gesture) {
  
 int fingerRightPos = 975;
 int fingerLeftPos = 0;
 
 // ********** LEVEL 3 GESTURES **********
 
 // Breakable Crystals Swipe
 if (x > 1080 - 1080 && x < 1080 && lastFingerPos.x > fingerLeftPos && lastFingerPos.x < fingerRightPos && lastFingerPos.y > 480 && lastFingerPos.y < 700 && breakableCrystalsLoaded && bgPart2Loaded) {
  swipeBreakablecrystals = true;
 }
 // Cracked Rock Swipe
 if (x > 1340 - 1080 && x < 1340 && lastFingerPos.x > fingerLeftPos && lastFingerPos.x < fingerRightPos && lastFingerPos.y > 410 && lastFingerPos.y < 548 && crackedRockLoaded && bgPart2Loaded) {
  swipeCrackedRock = true;
 }
 // Rainbow Fish in Background Swipe
 if (x > 1330 - 1080 && x < 1330 && lastFingerPos.x > fingerLeftPos && lastFingerPos.x < fingerRightPos && lastFingerPos.y > 380 && lastFingerPos.y < 520 && !rainbowFishBackgroundLoaded && bgPart2Loaded) {
  swipeRainbowFishBackground = true;
 }
 // Dotboxes Swipe
 if (lastFingerPos.x > 650 && lastFingerPos.x < 1080 && lastFingerPos.y > 210 && lastFingerPos.y < 640 && dotBoxesLoaded && bgPart3Loaded) {
  swipeDotBoxes = true;
 }
 // Weird Rock Swipe
 if (lastFingerPos.x > 500 && lastFingerPos.x < 700 && lastFingerPos.y > 435 && lastFingerPos.y < 545 && weirdRockLoaded && bgPart3Loaded) {
  swipeWeirdRock = true;
 }
 // Weird Rock 2 Swipe
 if (x > 1550 - 1080 && x < 1550 && lastFingerPos.x > fingerLeftPos && lastFingerPos.x < fingerRightPos && lastFingerPos.y > 560 && lastFingerPos.y < 720 && weirdRock2Loaded && bgEndFightLoaded) {
  swipeWeirdRock2 = true;
 }
 // Cracked Rock 2 Swipe
 if (x > 1160 - 1080 && x < 1160 && lastFingerPos.x > fingerLeftPos && lastFingerPos.x < fingerRightPos && lastFingerPos.y > 600 && lastFingerPos.y < 720 && crackedRock2Loaded && bgEndFightLoaded) {
  swipeCrackedRock2 = true;
 }
 // Erased Crystals Swipe
 if (x > 1160 - 1080 && x < 1160 && lastFingerPos.x > fingerLeftPos && lastFingerPos.x < fingerRightPos && lastFingerPos.y > 340 && lastFingerPos.y < 540 && erasedCrystals1Loaded && bgEndFightLoaded) {
  swipeErasedCrystals = true;
 }
 // Dot Box Swipe
 if (x > 1400 - 1080 && x < 1400 && lastFingerPos.x > fingerLeftPos && lastFingerPos.x < fingerRightPos && lastFingerPos.y > 285 && lastFingerPos.y < 430 && dotBoxLoaded && bgEndFightLoaded) {
  swipeDotBox = true;
 }
 
}

void stop()
{
  player.close();
  minim.stop();
  super.stop();
  leap.stop();
}
