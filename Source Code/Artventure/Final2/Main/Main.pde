// DS3 Final 
// April 14, 2014
// JRAA Studios

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

final int STATE_HOMEPAGE = 0;
final int STATE_ARTMODE = 1;
final int STATE_ADVENTUREMODEONE = 2;
final int STATE_ADVENTUREMODETWO = 3;
final int STATE_ADVENTUREMODETHREE = 4;
final int STATE_ADVENTUREMODEFOUR = 5;
final int STATE_TUTORIAL = 6;
final int STATE_CREDITS = 7;
final int STATE_ADVENTUREMODEMENU = 8;
int gAppState = STATE_HOMEPAGE;

LeapMotionP5 leap;
ResourceLoader resourceLoader;
HomePage home;
ArtMode art;
AdvMenu advmenu;
LevelOne levelone;
LevelTwo leveltwo;
LevelThree levelthree;
LevelFour levelfour;
Tutorial tutorial;
Credits credits;

PImage pawCursor, cursor, homePageBG, advMenuBG, back, artBG, creditsBG;

Animation tutorialBG;

/******************** ART MODE ************************/

PGraphics buffer;
// Brush attributes
float bW = 10; // brush width for ellipse
float bH = 10; // brush height for ellipse
float bp = 70; // paw size
float bAngle = 0; // brush angle
float bAngleP = random(1,180);
color col;
boolean particle = false;
boolean paw = false;

/******************** LEVEL 1 ************************/

AudioPlayer player;
AudioPlayer player1;
AudioPlayer player2;
AudioPlayer player3;
Minim minim;
Minim minim1;
Minim minim2;
Minim minim3;
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

PVector lastFingerPosAdv = new PVector(width/2, 1000);
Boolean gestureTest = false;
Boolean counting = true;
float bgWidth = 7001 - 1080;
PFont font;

PImage archietextbox;
// TEXT BOXES - Archie
// *********************************************************************
Boolean textBoxArchieLoaded = false;
int smallerTextSize = 25;
PImage bg, fg, crate, tree1_2, tree2_2, tree3_2; 
PImage treerainbowfish, treerainbowfish2, treerainbowfish3, holerainbowfish;
PImage largerock, crackedrock, crackedrockrainbowfish, weirdrock, weirdrockrainbowfish;
PImage smallrock, smallrockrainbowfish, log, treetrunk;
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
float bgSpeed = 120; // Background speed: Ex. 1000 is very slow and 1 is very fast, 120 seems good
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

/**********************  LEVEL 2 ****************************/

//PVector lastFingerPos = new PVector(width/2, 1000);
//Boolean gestureTest = false;
//Boolean counting = true;
float bgWidth_two = 7001 - 1080;
PImage bg2;
PImage fg2;
PImage crate2;
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
PImage largerock1;
PImage largerock2;
PImage largerock3;
PImage largerockoutline;
PImage roof;
PImage roofoutline;
PImage waterfountain;
PImage waterfountain2;
PImage windowright;
PImage windowleft;
PImage windowrightoutline;
PImage windowleftoutline;
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
//Boolean swipeCrate = false;
//Boolean crateLoaded = true;
Boolean crateRainbowFishLoaded = false;
Boolean swipeLargeRockOutline = false;
Boolean largeRockOutlineLoaded = true;
//Boolean swipeLargeRock = false;
Boolean largeRock1Loaded = false;
Boolean largeRock2Loaded = true;
Boolean largeRock3Loaded = false;
Boolean waterFountainLoaded = true;
Boolean waterFountain2Loaded = false;
Boolean doorLoaded = false;
Boolean swipeDoorOutline = false;
Boolean doorOutlineLoaded = true;
Boolean houseLoaded = false;
Boolean swipeHouseOutline = false;
Boolean houseOutlineLoaded = true;
Boolean roofLoaded = false;
Boolean swipeRoofOutline = false;
Boolean roofOutlineLoaded = true;
Boolean windowRightLoaded = false;
Boolean windowLeftLoaded = false;
Boolean swipeWindowRightOutline = false;
Boolean windowRightOutlineLoaded = true;
Boolean swipeWindowLeftOutline = false;
Boolean windowLeftOutlineLoaded = true;
//Boolean greenBeeLoaded = true;
//Boolean purpleBeeLoaded = true;
//Boolean redBeeLoaded = true;
//Boolean circleBeeGreen = false;
//Boolean circleBeePurple = false;
//Boolean circleBeeRed = false;
//float bgSpeed = 110; // Background speed: Ex. 1000 is very slow and 1 is very fast, 110 seems good on this level
float playerMoveSpeed_two = 50; // Player speed according to Leap Position X: Ex. 100 is smooth, slow and 1 is fastest, 50 seems good
//float archiePosY = 80;
//float archiePosX = 80;
//float rainbowCatPosY = 100;
float xpos_two = 0;
float ypos_two = 0;
//float y = 0; 
//float x = 0;
//int scoreCount = 0;
//int savedTime = 0;
//int timer = 0;
int swipeBridgeOutlineTimer = 0;
int swipeHedgeTimer = 0;
int swipeHoleTimer = 0;
int swipeBoulderTimer = 0;
//int swipeCrateTimer = 0;
int swipeLargeRockOutlineTimer = 0;
//int swipeLargeRockTimer = 0;
int swipeDeadTreeTimer = 0;
int swipeDoorOutlineTimer = 0;
int swipeHouseOutlineTimer = 0;
int swipeRoofOutlineTimer = 0;
int swipeWindowRightOutlineTimer = 0;
int swipeWindowLeftOutlineTimer = 0;
int endLevelTimer = 0;

/**********************  LEVEL 3 ****************************/

Animation dingoBarking;
Animation dingoSquished;
Animation dingoStars;
Animation dingoTailWag;
Animation dingoWalking;
Animation playerFalling;

float bgHeight = 4000 - 1080;
float bgEndWidth = 1546 - 1080;

//PImage archietextbox;
PImage dingotextbox;
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
//PImage crackedrock;
PImage crackedrockrainbowfish_three;
PImage rainbowfishbackground_three;
PImage weirdrock_three;
PImage weirdrockrainbowfish_three;
PImage hole_three;
PImage dotboxes_three;
PImage stackedboxes_three;
PImage crackedrock2_three;
PImage crackedrock2rainbowfish_three;
PImage weirdrock2_three;
PImage weirdrock2rainbowfish_three;
PImage erasedcrystals1_three;
PImage erasedcrystals2_three;
PImage dotbox_three;
PImage box_three;

//Boolean textBoxArchieLoaded = true;
Boolean textBoxDingoLoaded = false;

Boolean playerPosStop = false;
Boolean bgPart1Loaded = true;
Boolean bgPart2Loaded = false;
Boolean bgPart3Loaded = false;
Boolean bgFallingLoaded = false;
Boolean bgLoaded_three = false;
Boolean bgEndFightLoaded_three = false;
Boolean bgEndLoaded_three = false;
Boolean ceilingrockLoaded_three = false;
Boolean swipeBreakablecrystals_three = false;
Boolean breakableCrystalsLoaded_three = true;
Boolean breakableCrystalsRainbowFishLoaded_three = false;
Boolean swipeCrackedRock_three = false;
Boolean crackedRockLoaded_three = true;
Boolean crackedRockRainbowFishLoaded_three = false;
Boolean swipeRainbowFishBackground_three = false;
Boolean rainbowFishBackgroundLoaded_three = false;
Boolean holeLoaded_three = true;
Boolean swipeWeirdRock_three = false;
Boolean weirdRockLoaded_three = true;
Boolean weirdRockRainbowFishLoaded_three = false;
Boolean swipeDotBoxes_three = false;
Boolean dotBoxesLoaded_three = true;
Boolean stackedBoxesLoaded_three = false;
Boolean swipeWeirdRock2_three = false;
Boolean weirdRock2Loaded_three = true;
Boolean weirdRock2RainbowFishLoaded_three = false;
Boolean swipeCrackedRock2_three = false;
Boolean crackedRock2Loaded_three = true;
Boolean crackedRock2RainbowFishLoaded_three = false;
Boolean swipeErasedCrystals_three = false;
Boolean erasedCrystals1Loaded_three = true;
Boolean erasedCrystals2Loaded_three = false;
Boolean swipeDotBox_three = false;
Boolean dotBoxLoaded_three = true;
Boolean boxLoaded_three = false;
Boolean dingoLoaded_three = true;
Boolean dingoBarkAnim_three = false;
Boolean dingoStarsAnim = false;

float bgSpeed_three = 130; // Background speed: Ex. 1000 is very slow and 1 is very fast, 130 seems good
float playerMoveSpeed_three = 50; // Player speed according to Leap Position X: Ex. 100 is smooth, slow and 1 is fastest, 50 seems good
float fallingSpeed_three = 20;
float archiePosY_three = 80;
float archiePosX_three = 80;
float rainbowCatPosY_three = 100;
float xpos_three = 0;
float ypos_three = 0;
//float y = 0; 
//float x = 0;
int scoreCount_three = 0;
int savedTime_three = 0;
//int timer = 0;
int swipeBreakablecrystalsTimer_three = 0;
int swipeCrackedRockTimer_three = 0;
int swipeRainbowFishBackgroundTimer_three = 0;
int swipeDotBoxesTimer_three = 0;
int swipeWeirdRockTimer_three = 0;
int swipeWeirdRock2Timer_three = 0;
int swipeCrackedRock2Timer_three = 0;
int swipeErasedCrystalsTimer_three = 0;
int swipeDotBoxTimer_three = 0;
int exitCaveTimer_three = 0;


/**********************  LEVEL 4 ****************************/

Animation greyhoundBarkAnim;
Animation greyhoundStompAnim;
float bgWidth_four = 2160 - 1080;
PImage greyhoundtextbox;
PImage bglevel4;
PImage fglevel4;
PImage crackedrock_four;
PImage crackedrockrainbowfish_four;
PImage infiniteRAINBOWFISH;
// Text Boxes Variables
int swipeTextBox = 1;
Boolean swipeTextBoxBool = false;
Boolean textBoxGreyhoundLoaded = false;
Boolean firstTextBoxLoaded = true;
Boolean secondTextBoxLoaded = false;
Boolean thirdTextBoxLoaded = false;
Boolean fourthTextBoxLoaded = false;
Boolean fifthTextBoxLoaded = false;
Boolean infiniteRainbowFishLoaded = false;
Boolean bgLoaded_four = true;
Boolean bgEndFightLoaded_four = false;
Boolean bgEndLoaded_four = false;
//Boolean playerPosStop = false;
//Boolean swipeCrackedRock = false;
//Boolean crackedRockLoaded = true;
//Boolean crackedRockRainbowFishLoaded = false;
Boolean swipeGrayscaleGreyhound = false;
Boolean greyhoundLoaded = true;
Boolean greyhoundBark = false;
Boolean greyhoundStomp = false;
//float bgSpeed = 200; // Background speed: Ex. 1000 is very slow and 1 is very fast, 200 seems good
float playerMoveSpeed_four = 50; // Player speed according to Leap Position X: Ex. 100 is smooth, slow and 1 is fastest, 50 seems good
//float archiePosY = 80;
//float archiePosX = 80;
//float rainbowCatPosY = 100;
float xpos_four = 0;
float ypos_four = 0;
//float y = 0; 
//float x = 0;
//int scoreCount = 0;
int scoreCountLimit = 500;
//int savedTime = 0;
//int timer = 0;
//int swipeCrackedRockTimer = 0;
int finishGameTimer = 0;

/**************************************************************************/
  
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
  smooth();
  
  leap = new LeapMotionP5(this);
  resourceLoader = new ResourceLoader();
  home = new HomePage();
  art = new ArtMode();
  advmenu = new AdvMenu();
  levelone = new LevelOne();
  leveltwo = new LevelTwo();
  levelthree = new LevelThree();
  levelfour = new LevelFour();
  tutorial = new Tutorial();
  credits = new Credits();
  
  // Load Images
  pawCursor = resourceLoader.getImage("pawCursor.png");
  cursor = resourceLoader.getImage("cursor.png");
  homePageBG = resourceLoader.getImage("HomeMenuBG.png");
  artBG = resourceLoader.getImage("ArtModeBG.png");
  back = resourceLoader.getImage("back.png");
  advMenuBG = resourceLoader.getImage("AdventureMenuBG.png");
  creditsBG = resourceLoader.getImage("CreditsBG.png");
  
  tutorialBG = new Animation("Animation/tutorial_frame", 14);
  
  buffer = createGraphics(1080, 576);
  
  frameRate(30);
  
    
  // Playing audio files
  minim = new Minim(this);
  player = minim.loadFile("Montauk Point.mp3");
  minim1 = new Minim(this);
  player1 = minim1.loadFile("Thatched Villagers.mp3");
  minim2 = new Minim(this);
  player2 = minim2.loadFile("Groove Grove.mp3");
  minim3 = new Minim(this);
  player3 = minim3.loadFile("One-eyed Maestro.mp3");
 
  
  /******************** ADVENTURE LEVEL 1 ************************/

  // Enabling Gestures
  leap.enableGesture(Type.TYPE_CIRCLE);
  leap.enableGesture(Type.TYPE_SWIPE);
  
  // Font Implementation
  font = createFont("Roboto-Regular.ttf", 1);
  textFont(font);
  
  archietextbox = resourceLoader.getImage("Textbox-Archie.png");
  // Loading Resource Assets
  resourceLoader = new ResourceLoader();
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
  
   /******************** ADVENTURE LEVEL 2 ************************/
  
  // Loading Resource Assets
  bg2 = resourceLoader.getImage("Background_two.png");
  fg2 = resourceLoader.getImage("Foreground_two.png");
  bridgeoutline = resourceLoader.getImage("BridgeOutline_two.png");
  bridge = resourceLoader.getImage("Bridge_two.png");
  hedge = resourceLoader.getImage("Hedge_two.png");
  hedgerainbowfish = resourceLoader.getImage("Hedge_RainbowFishtwo.png");
  hole3 = resourceLoader.getImage("Hole_3two.png");
  deadtree = resourceLoader.getImage("DeadTree_two.png");
  deadtreerainbowfish = resourceLoader.getImage("DeadTree_RainbowFishtwo.png");
  boulderback = resourceLoader.getImage("BoulderBack_two.png");
  bouldersmashable = resourceLoader.getImage("BoulderSmashable_two.png");
  bouldersmashablerainbowfish = resourceLoader.getImage("BoulderSmashable_RainbowFish_two.png");
  crate2 = resourceLoader.getImage("Crate_two.png");
  craterainbowfish = resourceLoader.getImage("Crate_RainbowFishtwo.png");
  largerockoutline = resourceLoader.getImage("LargeRockOutline_two.png");
  largerock1 = resourceLoader.getImage("LargeRock_1two.png");
  largerock2 = resourceLoader.getImage("LargeRock_2two.png");
  largerock3 = resourceLoader.getImage("LargeRock_3two.png");
  waterfountain = resourceLoader.getImage("Waterfountain_1two.png");
  waterfountain2 = resourceLoader.getImage("Waterfountain_2two.png");
  
  door = resourceLoader.getImage("Door_two.png");
  dooroutline = resourceLoader.getImage("DoorOutline_two.png");
  house = resourceLoader.getImage("House_two.png");
  houseoutline = resourceLoader.getImage("HouseOutline_two.png");
  roof = resourceLoader.getImage("Roof_two.png");
  roofoutline = resourceLoader.getImage("RoofOutline_two.png");
  windowright = resourceLoader.getImage("WindowRight_two.png");
  windowleft = resourceLoader.getImage("WindowLeft_two.png");
  windowrightoutline = resourceLoader.getImage("WindowRightOutline_two.png");
  windowleftoutline = resourceLoader.getImage("WindowLeftOutline_two.png");
//  archieFlying = new Animation("Animation/Archieframe", 7);
//  playerAnimWalk = new Animation("Animation/CATWalking", 7);
//  playerAnimIdle = new Animation("Animation/CATIdle", 7);
//  playerAnimAttack = new Animation("Animation/CATattacking", 7);
//  inkbeeGreen = new Animation("Animation/InkbeeGreen", 11);
//  inkbeeGreenBubble = new Animation("Animation/InkbeeGreenBubble", 11);
//  inkbeePurple = new Animation("Animation/InkbeePurple", 11);
//  inkbeePurpleBubble = new Animation("Animation/InkbeePurpleBubble", 11);
//  inkbeeRed = new Animation("Animation/InkbeeRed", 11);
//  inkbeeRedBubble = new Animation("Animation/InkbeeRedBubble", 11);
  
  ypos_two = height * 0.35;
  
  /******************** ADVENTURE LEVEL 3 ************************/
  
  // Loading Resource Assets
  archietextbox = resourceLoader.getImage("Textbox-Archie.png");
  dingotextbox = resourceLoader.getImage("Textbox-Dingo.png");
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
  //crackedrock_three = resourceLoader.getImage("CrackedRock_3.png");
  crackedrockrainbowfish_three = resourceLoader.getImage("CrackedRock_RainbowFish3_3.png");
  rainbowfishbackground_three = resourceLoader.getImage("RainbowFishBackground.png");
  hole_three = resourceLoader.getImage("hole_3_three.png");
  weirdrock_three = resourceLoader.getImage("WeirdRock_3_3.png");
  weirdrockrainbowfish_three = resourceLoader.getImage("WeirdRock_RainbowFish3_3.png");
  dotboxes_three = resourceLoader.getImage("dotBoxes_3.png");
  stackedboxes_three = resourceLoader.getImage("StackedBoxes_3.png");
  weirdrock2_three = resourceLoader.getImage("WeirdRock_2.png");
  weirdrock2rainbowfish_three = resourceLoader.getImage("WeirdRock_RainbowFish2.png");
  crackedrock2_three = resourceLoader.getImage("CrackedRock_2.png");
  crackedrock2rainbowfish_three = resourceLoader.getImage("CrackedRock_RainbowFish2.png");
  erasedcrystals1_three = resourceLoader.getImage("ErasedCrystal-1_3.png");
  erasedcrystals2_three = resourceLoader.getImage("ErasedCrystal-2_3.png");
  dotbox_three = resourceLoader.getImage("dotBox_3.png");
  box_three = resourceLoader.getImage("box_3.png");

  dingoBarking = new Animation("Animation/Dingo-Barking", 4);
  dingoSquished = new Animation("Animation/Dingo-Squished", 6);
  dingoStars = new Animation("Animation/Dingo-Stars", 3);
  dingoTailWag = new Animation("Animation/Dingo-TailWag", 3);
  dingoWalking = new Animation("Animation/Dingo-Walking", 6);
  playerFalling = new Animation("Animation/CATfalling", 7);
  
  ypos_three = height * 0.35;
  xpos_three = 200;
  
  /******************** ADVENTURE LEVEL 4 ************************/
  
  // Loading Resource Assets
  archietextbox = resourceLoader.getImage("Textbox-Archie.png");
  greyhoundtextbox = resourceLoader.getImage("Textbox-GG.png");
  bglevel4 = resourceLoader.getImage("Level 4 Background.png");
  fglevel4 = resourceLoader.getImage("Level 4 foreground.png");
  crackedrock_four = resourceLoader.getImage("crackedRock_4.png");
  crackedrockrainbowfish_four = resourceLoader.getImage("crackedRock_RainbowFish_four.png");
  infiniteRAINBOWFISH = resourceLoader.getImage("infiniteRainbowFish.png");
  
  greyhoundBarkAnim = new Animation("Animation/GreyhoundBarking", 14);
  greyhoundStompAnim = new Animation("Animation/GreyhoundStomp", 15);
  
  ypos_four = height * 0.35;
  xpos_four = 200;

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
    else if(STATE_ADVENTUREMODEMENU == gAppState){
      advmenu.render();
    }
    else if(STATE_ADVENTUREMODEONE == gAppState){
      player.play();
      levelone.render();
      player.pause();
    }
    else if(STATE_ADVENTUREMODETWO == gAppState){
      player1.play();
      leveltwo.render();
      player1.pause();
    }
    else if(STATE_ADVENTUREMODETHREE == gAppState){
      player2.play();
      levelthree.render();
      player2.pause();
    }
    else if(STATE_ADVENTUREMODEFOUR == gAppState){
      player3.play();
      levelfour.render();
      player3.pause();
    }
    else if(STATE_TUTORIAL == gAppState){
      tutorial.render();
    }
    else if(STATE_CREDITS == gAppState){
      credits.render();
    }
}


public void circleGestureRecognized(CircleGesture gesture, String clockwiseness) {
  
    // ********** LEVEL 1 GESTURES **********
    
    // Netting Green Bee
    if (x > 6700 - 1080 && x < 6700 && lastFingerPosAdv.x > 400 - 115 && lastFingerPosAdv.x < 400 + 115 && lastFingerPosAdv.y > 80 - 131 && lastFingerPosAdv.y < 80 + 131 && greenBeeLoaded) {
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
      }
     circleBeeGreen = true;
    }
    // Netting Purple Bee
    if (x > 6700 - 1080 && x < 6700 && lastFingerPosAdv.x > 600 - 115 && lastFingerPosAdv.x < 600 + 115 && lastFingerPosAdv.y > 250 - 131 && lastFingerPosAdv.y < 250 + 131 && purpleBeeLoaded) {
     circleBeePurple = true;
    }
    // Netting Red Bee
    if (x > 6700 - 1080 && x < 6700 && lastFingerPosAdv.x > 800 - 115 && lastFingerPosAdv.x < 800 + 115 && lastFingerPosAdv.y > 120 - 131 && lastFingerPosAdv.y < 120 + 131 && redBeeLoaded) {
     circleBeeRed = true;
    }
  
}


public void swipeGestureRecognized(SwipeGesture gesture) {     
     int fingerRightPos = 975;
     int fingerLeftPos = 0;
     
     // ********** LEVEL 1 GESTURES **********
     if(gAppState == STATE_ADVENTUREMODEONE){
         // Crate Swipe
         if (lastFingerPosAdv.x > 600  && lastFingerPosAdv.y > 240 && lastFingerPosAdv.y < 600 && crateLoaded) {
            if (gesture.state() == State.STATE_STOP) {
              System.out.println("//////////////////////////////////////");
              System.out.println("Gesture type: " + gesture.type());
              System.out.println("ID: " + gesture.id());
              System.out.println("Position: " + leap.vectorToPVector(gesture.position()));
              System.out.println("Direction: " + gesture.direction());
              System.out.println("Duration: " + gesture.durationSeconds() + "s");
              System.out.println("Speed: " + gesture.speed());
              System.out.println("//////////////////////////////////////");
            }
          swipeCrate = true;
         }
         // Large Rock Swipe
         if (x > 600 && lastFingerPosAdv.x > fingerLeftPos && lastFingerPosAdv.x < fingerRightPos && lastFingerPosAdv.y > 350 && lastFingerPosAdv.y < 550 && largeRockLoaded) {
          swipeLargeRock = true;
         }
         // Cracked Rock Swipe
         if (x > 2650 - 1080 && x < 2650 && lastFingerPosAdv.x > fingerLeftPos && lastFingerPosAdv.x < fingerRightPos && lastFingerPosAdv.y > 500 && lastFingerPosAdv.y < 645 && crackedRockLoaded) {
          swipeCrackedRock = true;
         }
         // Tree Trunk Swipe
         if (x > 3680 - 1080 && x < 3680 && lastFingerPosAdv.x > fingerLeftPos && lastFingerPosAdv.x < fingerRightPos && lastFingerPosAdv.y > 600 && lastFingerPosAdv.y < 720 && treeTrunkLoaded) {
          swipeTreeTrunk = true;
         }
         // Weird Rock Swipe
         if (x > 4060 - 1080 && x < 4060 && lastFingerPosAdv.x > fingerLeftPos && lastFingerPosAdv.x < fingerRightPos && lastFingerPosAdv.y > 370 && lastFingerPosAdv.y < 560 && weirdRockLoaded) {
          swipeWeirdRock = true;
         }
         // Small Rock Swipe
         if (x > 4530 - 1080 && x < 4530 && lastFingerPosAdv.x > fingerLeftPos && lastFingerPosAdv.x < fingerRightPos && lastFingerPosAdv.y > 540 && lastFingerPosAdv.y < 720 && smallRockLoaded) {
          swipeSmallRock = true;
         }
         // Log Swipe
         if (x > 5050 - 1080 && x < 5050 && lastFingerPosAdv.x > fingerLeftPos && lastFingerPosAdv.x < fingerRightPos && lastFingerPosAdv.y > 480 && lastFingerPosAdv.y < 680 && logLoaded) {
          swipeLog = true;
         }
         // Trees 1 Swipe
         if (x > 1530 - 1080 && x < 1530 && lastFingerPosAdv.x > fingerLeftPos && lastFingerPosAdv.x < fingerRightPos && lastFingerPosAdv.y > 0 && lastFingerPosAdv.y < 300 && !treeRainbowFishLoaded) {
          swipeTrees = true;
         }
         // Trees 2 Swipe
         if (x > 3320 - 1080 && x < 3320 && lastFingerPosAdv.x > fingerLeftPos && lastFingerPosAdv.x < fingerRightPos && lastFingerPosAdv.y > 0 && lastFingerPosAdv.y < 300 && !treeRainbowFishLoaded2) {
          swipeTrees2 = true;
         }
         // Trees 3 Swipe
         if (x > 5700 - 1080 && x < 5700 && lastFingerPosAdv.x > fingerLeftPos && lastFingerPosAdv.x < fingerRightPos && lastFingerPosAdv.y > 0 && lastFingerPosAdv.y < 300 && !treeRainbowFishLoaded3) {
          swipeTrees3 = true;
         }
     }

     // ********** LEVEL 2 GESTURES **********
     if(gAppState == STATE_ADVENTUREMODETWO){
         // Bridge Outline Swipe
         if (lastFingerPos.x > fingerLeftPos && lastFingerPos.x < fingerRightPos && lastFingerPos.y > 0 && lastFingerPos.y < 720 && bridgeOutlineLoaded){
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
         // Door Outline Swipe
         if (x > 6330 - 1080 && x < 6330 && lastFingerPos.x > fingerLeftPos && lastFingerPos.x < fingerRightPos && lastFingerPos.y > 310 && lastFingerPos.y < 670 && doorOutlineLoaded) {
           swipeDoorOutline = true;
         }
         // House Outline Swipe
         if (x > 6500 - 1080 && x < 6500 && lastFingerPos.x > fingerLeftPos && lastFingerPos.x < fingerRightPos && lastFingerPos.y > 155 && lastFingerPos.y < 580 && houseOutlineLoaded) {
           swipeHouseOutline = true;
         }
         // Roof Outline Swipe
         if (x > 6700 - 1080 && x < 6700 && lastFingerPos.x > fingerLeftPos && lastFingerPos.x < fingerRightPos && lastFingerPos.y > 40 && lastFingerPos.y < 285 && roofOutlineLoaded) {
           swipeRoofOutline = true;
         }
         // Window Right Outline Swipe
         if (x > 6610 - 1080 && x < 6610 && lastFingerPos.x > fingerLeftPos && lastFingerPos.x < fingerRightPos && lastFingerPos.y > 285 && lastFingerPos.y < 460 && windowRightOutlineLoaded) {
           swipeWindowRightOutline = true;
         }
         // Window Left Outline Swipe
         if (x > 6050 - 1080 && x < 6050 && lastFingerPos.x > fingerLeftPos && lastFingerPos.x < fingerRightPos && lastFingerPos.y > 285 && lastFingerPos.y < 460 && windowLeftOutlineLoaded) {
           swipeWindowLeftOutline = true;
         }
     }
     
      // ********** LEVEL 3 GESTURES **********
     if(gAppState == STATE_ADVENTUREMODETHREE){
       // Breakable Crystals Swipe
       if (x > 1080 - 1080 && x < 1080 && lastFingerPos.x > fingerLeftPos && lastFingerPos.x < fingerRightPos && lastFingerPos.y > 480 && lastFingerPos.y < 700 && breakableCrystalsLoaded_three && bgPart2Loaded) {
        swipeBreakablecrystals_three = true;
       }
       // Cracked Rock Swipe
       if (x > 1340 - 1080 && x < 1340 && lastFingerPos.x > fingerLeftPos && lastFingerPos.x < fingerRightPos && lastFingerPos.y > 410 && lastFingerPos.y < 548 && crackedRockLoaded_three && bgPart2Loaded) {
        swipeCrackedRock_three = true;
       }
       // Rainbow Fish in Background Swipe
       if (x > 1330 - 1080 && x < 1330 && lastFingerPos.x > fingerLeftPos && lastFingerPos.x < fingerRightPos && lastFingerPos.y > 380 && lastFingerPos.y < 520 && !rainbowFishBackgroundLoaded_three && bgPart2Loaded) {
        swipeRainbowFishBackground_three = true;
       }
       // Dotboxes Swipe
       if (lastFingerPos.x > 650 && lastFingerPos.x < 1080 && lastFingerPos.y > 210 && lastFingerPos.y < 640 && dotBoxesLoaded_three && bgPart3Loaded) {
        swipeDotBoxes_three = true;
       }
       // Weird Rock Swipe
       if (lastFingerPos.x > 500 && lastFingerPos.x < 700 && lastFingerPos.y > 435 && lastFingerPos.y < 545 && weirdRockLoaded_three && bgPart3Loaded) {
        swipeWeirdRock_three = true;
       }
       // Weird Rock 2 Swipe
       if (x > 1550 - 1080 && x < 1550 && lastFingerPos.x > fingerLeftPos && lastFingerPos.x < fingerRightPos && lastFingerPos.y > 560 && lastFingerPos.y < 720 && weirdRock2Loaded_three && bgEndFightLoaded_three) {
        swipeWeirdRock2_three = true;
       }
       // Cracked Rock 2 Swipe
       if (x > 1160 - 1080 && x < 1160 && lastFingerPos.x > fingerLeftPos && lastFingerPos.x < fingerRightPos && lastFingerPos.y > 600 && lastFingerPos.y < 720 && crackedRock2Loaded_three && bgEndFightLoaded_three) {
        swipeCrackedRock2_three = true;
       }
       // Erased Crystals Swipe
       if (x > 1160 - 1080 && x < 1160 && lastFingerPos.x > fingerLeftPos && lastFingerPos.x < fingerRightPos && lastFingerPos.y > 340 && lastFingerPos.y < 540 && erasedCrystals1Loaded_three && bgEndFightLoaded_three) {
        swipeErasedCrystals_three = true;
       }
       // Dot Box Swipe
       if (x > 1400 - 1080 && x < 1400 && lastFingerPos.x > fingerLeftPos && lastFingerPos.x < fingerRightPos && lastFingerPos.y > 285 && lastFingerPos.y < 430 && dotBoxLoaded_three && bgEndFightLoaded_three) {
        swipeDotBox_three = true;
       }
     }

      
         // ********** LEVEL 4 GESTURES **********
      if(gAppState == STATE_ADVENTUREMODEFOUR){  
       
         int archieLeftPos = 1080;
         int archieBottomPos = 500;
       
         // Cracked Rock Swipe
         if (x > 640 - 1080 && x < 640 && lastFingerPos.x > fingerLeftPos && lastFingerPos.x < fingerRightPos && lastFingerPos.y > 580 && lastFingerPos.y < 720 && crackedRockLoaded && bgLoaded_three) {
          swipeCrackedRock = true;
         }
         // Grayscale Greyhound Swipe
         if (x > 2000 - 1080 && x < 2000 && lastFingerPos.x > fingerLeftPos && lastFingerPos.x < fingerRightPos && lastFingerPos.y > 190 && lastFingerPos.y < 700 && greyhoundLoaded) {
          swipeGrayscaleGreyhound = true;
         }
      }
      
}

public void stop() {
  leap.stop();
  //player.close();
  minim.stop();
  minim1.stop();
  minim2.stop();
  super.stop();
}
