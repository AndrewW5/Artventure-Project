// Adventure Mode - Level 4
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
Minim minim2;

ResourceLoader resourceLoader;
Animation archieFlying;
Animation playerAnimWalk;
Animation playerAnimIdle;
Animation playerAnimAttack;
Animation playerFalling;
Animation greyhoundBarkAnim;
Animation greyhoundStompAnim;

PVector lastFingerPos = new PVector(width/2, 1000);
Boolean gestureTest = false;
Boolean counting = true;
float bgWidth = 2160 - 1080;

PFont font;

PImage archietextbox;
PImage greyhoundtextbox;
PImage cursor;
PImage bglevel4;
PImage fglevel4;
PImage crackedrock;
PImage crackedrockrainbowfish;
PImage infiniteRAINBOWFISH;

// Text Boxes Variables
Boolean textBoxArchieLoaded = false;
Boolean textBoxGreyhoundLoaded = false;
Boolean firstTextBoxLoaded = true;
Boolean secondTextBoxLoaded = false;
Boolean thirdTextBoxLoaded = false;
Boolean fourthTextBoxLoaded = false;
Boolean fifthTextBoxLoaded = false;

Boolean infiniteRainbowFishLoaded = false;
Boolean bgLoaded = true;
Boolean bgEndFightLoaded = false;
Boolean bgEndLoaded = false;
Boolean playerPosStop = false;
Boolean swipeCrackedRock = false;
Boolean crackedRockLoaded = true;
Boolean crackedRockRainbowFishLoaded = false;
Boolean swipeGrayscaleGreyhound = false;
Boolean greyhoundLoaded = true;
Boolean greyhoundBark = false;
Boolean greyhoundStomp = false;

float bgSpeed = 200; // Background speed: Ex. 1000 is very slow and 1 is very fast, 200 seems good
float playerMoveSpeed = 50; // Player speed according to Leap Position X: Ex. 100 is smooth, slow and 1 is fastest, 50 seems good
float archiePosY = 80;
float archiePosX = 80;
float rainbowCatPosY = 100;
float xpos = 0;
float ypos = 0;
float y = 0; 
float x = 0;
int scoreCount = 0;
int scoreCountLimit = 500;
int savedTime = 0;
int timer = 0;
int swipeCrackedRockTimer = 0;
int finishGameTimer = 0;

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
  minim2 = new Minim(this);
  player = minim.loadFile("One-eyed Maestro.mp3");
  player2 = minim2.loadFile("Music to Delight.mp3");
  player.play();
  
  // Loading Resource Assets
  resourceLoader = new ResourceLoader();
  archietextbox = resourceLoader.getImage("Textbox-Archie.png");
  greyhoundtextbox = resourceLoader.getImage("Textbox-GG.png");
  cursor = resourceLoader.getImage("cursor.png");
  bglevel4 = resourceLoader.getImage("Level 4 Background.png");
  fglevel4 = resourceLoader.getImage("Level 4 foreground.png");
  crackedrock = resourceLoader.getImage("crackedRock_4.png");
  crackedrockrainbowfish = resourceLoader.getImage("crackedRock_RainbowFish.png");
  infiniteRAINBOWFISH = resourceLoader.getImage("infiniteRainbowFish.png");
  
  archieFlying = new Animation("Animation/Archieframe", 7);
  playerAnimWalk = new Animation("Animation/CATWalking", 7);
  playerAnimIdle = new Animation("Animation/CATIdle", 7);
  playerAnimAttack = new Animation("Animation/CATattacking", 7);
  greyhoundBarkAnim = new Animation("Animation/GreyhoundBarking", 14);
  greyhoundStompAnim = new Animation("Animation/GreyhoundStomp", 15);
  
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
  
  // Background Level 4 Instantiated
  if (bgLoaded) {
    image( bglevel4.get(int(x), 0 , bglevel4.width-int(x), bglevel4.height), 0, 0 );
    
    // Foreground Level 4  Instantiated
    image( fglevel4.get(int(x), 0 , fglevel4.width-int(x), fglevel4.height), 0, 0);
    // Cracked Rock Instantiated
    if (x > 640 - 1500 && x < 640 && crackedRockLoaded) {
      image( crackedrock.get(int(x), 0, crackedrock.width-int(x), crackedrock.height), 0, 0);
    }
    // Cracked Rock with Rainbow Fish Instantiated
    if (x > 640 - 1500 && x < 640 && crackedRockRainbowFishLoaded) {
      image( crackedrockrainbowfish.get(int(x), 0, crackedrockrainbowfish.width-int(x), crackedrockrainbowfish.height), 0, 0);
    }
    // INFINITE RAINBOW FISH
    if (x > 1920 - 1500 && x < 1920 && infiniteRainbowFishLoaded) {
      image( infiniteRAINBOWFISH.get(int(x), 0, infiniteRAINBOWFISH.width-int(x), infiniteRAINBOWFISH.height), 0, 0);
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
  int textDurEnd = 4; // Loading time
  
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
    if (!playerPosStop) {
      playerAnimWalk.display(xpos-playerAnimWalk.getWidth()/2, ypos + rainbowCatPosY);
    }
  } else {
    playerAnimIdle.display(xpos-playerAnimIdle.getWidth()/2, ypos + rainbowCatPosY);
  }
  if (playerPosStop) {
     playerAnimIdle.display(xpos-playerAnimIdle.getWidth()/2, ypos + rainbowCatPosY);
  }
  xpos = xpos + dx/playerMoveSpeed; // Moves player to cursor position
  
  
  // Control flow of events
  // Grayscale Greyhound End Fight
  if (greyhoundLoaded) {
    if (x <= bgWidth) {
      xpos = xpos + dx/playerMoveSpeed;
    } else {
      bgEndFightLoaded = true;
      if (scoreCount <= 250) {
        greyhoundStomp = true;
      } else {
        greyhoundStomp = false;
        greyhoundBark = true;
      }
      playerPosStop = true;
      x = bgWidth;
      xpos = 300;
      textSize(largeTextSize);
      text("DEFEAT GRAYSCALE GREYHOUND", width/5, height/topScreenPosY);
    }
    x += xpos / bgSpeed;
  } else {
    //player.close();
    player2.play();
  }
  // Greyhound Barking Instantiated
  if (x > 1920 - 1500 && x < 1920 && greyhoundBark) {
    greyhoundBarkAnim.display(550, 200);
  }
  // Greyhound Stomping Instantiated
  if (x > 1920 - 1500 && x < 1920 && greyhoundStomp) {
    greyhoundStompAnim.display(550, 200);
  }
  
  
  // ******************** LEVEL 3 ASSETS INSTANTIATED ********************
  
  // TEXT BOXES - Archie and Grayscale
  // *********************************************************************
  int firstTextStart = 500;
  int firstTextEnd = 800;
  int secondTextStart = 800;
  int secondTextEnd = 1000;
  int thirdTextStart = 1000;
  int thirdTextEnd = 1100;
  
  if (textBoxArchieLoaded) {
    image( archietextbox, 0, 0);
  }
  if (textBoxGreyhoundLoaded) {
    image( greyhoundtextbox, 0, 0);
  }
  if (x > firstTextStart && x < firstTextEnd) {
    textBoxArchieLoaded = true;
    textSize(smallerTextSize);
    text("Look, it's the Grayscale Greyhound. Finally we found you,\nnow your dastardly schemes can stop.", 
    width/5, height/1.15);
  }
  if (x > secondTextStart && x < secondTextEnd) {
    textBoxArchieLoaded = false;
    textBoxGreyhoundLoaded = true;
    textSize(smallerTextSize);
    text("That's not my name you horrid little bird.", 
    width/4, height/1.15);
  } 
  if (x > thirdTextStart && x < thirdTextEnd && greyhoundLoaded) {
    textBoxArchieLoaded = true;
    textBoxGreyhoundLoaded = false;
    textSize(smallerTextSize);
    text("Quiet you! Hey Cat, slash at him with your paintbrush to defeat him.", 
    width/4, height/1.15);
  }
  if (!greyhoundLoaded && timer - 5 < finishGameTimer + textDuration) {
    textBoxArchieLoaded = true;
    textBoxGreyhoundLoaded = false;
    textSize(smallerTextSize);
    text("Good job, Cat. You did it!", 
    width/4, height/1.2);
  }
  if (!greyhoundLoaded && timer - 10 < finishGameTimer + textDuration) {
    textBoxArchieLoaded = false;
    textBoxGreyhoundLoaded = true;
    textSize(smallerTextSize);
    text("I just wanted to be colorful...", 
    width/4, height/1.1);
  }
  
  
  // Cursor Instantiated
  image(cursor, lastFingerPos.x, lastFingerPos.y, 50, 50);
  
  // ******************** LEVEL 3 TEXT EVENTS ********************
  
  
  // Final Battle Text Event
  if (timer < 1337 && !bgEndFightLoaded) {
    textSize(largeTextSize);
    text("FINAL BATTLE APPROACHES", width/4, height/topScreenPosY);
  }
  // Swipe Cracked Rock Text Event, encourage thy player!
  if (!crackedRockLoaded && timer < swipeCrackedRockTimer + textDuration && !bgEndFightLoaded) {
    textSize(normalTextSize);
    text("Awesome! +50 Points", width/middleScreenPosX, height/middleScreenPosY);
  }
  // When they finish Game!
  if (timer < finishGameTimer + 1337 && !greyhoundLoaded) {
    textSize(largeTextSize);
    text("YOU WIN! CONGRATULATIONS!", width/4, height/topScreenPosY);
  }
  
  

  // ******************** LEVEL 3 GESTURE INTERACTION ********************

  // Swiping the cracked rock
  if (swipeCrackedRock) {
    scoreCount += 50;
    crackedRockRainbowFishLoaded = true;
    crackedRockLoaded = false;
    swipeCrackedRock = false;
    timer = swipeCrackedRockTimer;
    swipeCrackedRockTimer = (millis()/1000) - swipeCrackedRockTimer;
  }
  // Swiping the Grayscale Greyhound
  if (swipeGrayscaleGreyhound) {
    scoreCount += 10;
    swipeGrayscaleGreyhound = false;
    // When Score reaches limit of swipes the player makes
    if (scoreCount > scoreCountLimit) {
      bgEndLoaded = true;
    }
  }
  // Level End Event
  if (bgEndLoaded) {
    scoreCount = 0;
    println("Level Ended. Score: " + scoreCount);
    bgEndLoaded = false;
    greyhoundLoaded = false;
    greyhoundBark = false;
    crackedRockRainbowFishLoaded = false;
    infiniteRainbowFishLoaded = true;
    playerPosStop = false;
    x = bgWidth;
    xpos = 400;
    timer = finishGameTimer;
    finishGameTimer = (millis()/1000) - finishGameTimer;
    player.close();
    player2.play();
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

// 2. Swipe Gesture
public void swipeGestureRecognized(SwipeGesture gesture) {
  
 int fingerRightPos = 975;
 int fingerLeftPos = 0;
 int archieLeftPos = 1080;
 int archieBottomPos = 500;
 
 // ********** LEVEL 3 GESTURES **********
 
 // Cracked Rock Swipe
 if (x > 640 - 1080 && x < 640 && lastFingerPos.x > fingerLeftPos && lastFingerPos.x < fingerRightPos && lastFingerPos.y > 580 && lastFingerPos.y < 720 && crackedRockLoaded && bgLoaded) {
  swipeCrackedRock = true;
 }
 // Grayscale Greyhound Swipe
 if (x > 2000 - 1080 && x < 2000 && lastFingerPos.x > fingerLeftPos && lastFingerPos.x < fingerRightPos && lastFingerPos.y > 190 && lastFingerPos.y < 700 && greyhoundLoaded) {
  swipeGrayscaleGreyhound = true;
 }
 
}

void stop()
{
  player2.close();
  player.close();
  minim.stop();
  super.stop();
  leap.stop();
}
