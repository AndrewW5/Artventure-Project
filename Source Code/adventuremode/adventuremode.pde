// Adventure Mode
// Coded by Andrew Wardell
// Revision V1.0
// Date: March 14, 2014

// Importing AudioPlayer and minim library
import ddf.minim.*;
AudioPlayer player;
Minim minim;//audio context

PFont font;

PImage bg;
PImage bg2;
PImage crate;
PImage tree1_2;
PImage largerock;
PImage toolsmenu;

Animation playerAnim;

float xpos = 0;
float ypos = 0;
float playerMoveSpeed = 70; // How fast the player moves according to cursor position

float y = 0; 
float x = 0;
int timer = 0;
int scoreCount = 0;
float bgWidth = 7001 - 1080;
float bgSpeed = 200; // Higher value, slower background. Lower value, faster background

ResourceLoader resourceLoader;

void setup() {
  size (1080, 720);
  smooth();
  background(255);
  frameRate(30);
  
  // Fonts implemented
  font = createFont("Roboto-Regular.ttf", 1);
  textFont(font);
  
  // Playing sound!
  minim = new Minim(this);
  player = minim.loadFile("Birds.mp3");
  player.play();
  
  resourceLoader = new ResourceLoader();
  bg = resourceLoader.getImage("Background2.png");
  bg2 = resourceLoader.getImage("Foreground.png");
  toolsmenu = resourceLoader.getImage("ToolsMenu.png");
  crate = resourceLoader.getImage("Crate2.png");
  tree1_2 = resourceLoader.getImage("Tree1_2.png");
  largerock = resourceLoader.getImage("LargeRock2.png");
  playerAnim = new Animation("playerAnimation/playerMove", 7);
  ypos = height * 0.35; // y position of player
}

void draw() {
  background(255);
  timer = millis() / 1000;
  
  // Background Instantiated 
  image( bg.get(int(x), 0 , bg.width-int(x), bg.height), 0, 0 );
  
  // Rock Instantiated
  if (x < 1700) {
    image( largerock.get(int(x), 0, largerock.width-int(x), largerock.height), 0, 410 );
  }
  
  // Tree 1 Instantiated
  if (x < 1350) {
    image( tree1_2.get(int(x), 0, tree1_2.width-int(x), tree1_2.height), 0, 50 );
  }
  
  // Tools Menu Instantiated
  image( toolsmenu, 15, 15);
  
  // Player Animation
  float dx = mouseX - xpos; // Distance from cursor, replace mouseX with the leap position x
  //println(dx);
  //println(xpos);
  //xpos=200; // Stays in one spot
  xpos = xpos + dx/playerMoveSpeed; // Moves player to cursor position
  playerAnim.display(xpos-playerAnim.getWidth()/2, ypos);
  x += xpos / bgSpeed;
  
  // Crate Instantiated
  if (x < 1000) {
    image( crate.get(int(x), 0, crate.width-int(x), crate.height), 0, 300 );
  }
  
  // Foreground Instantiated
  if (x < 6166) {
    image( bg2.get(int(x), 0 , bg2.width-int(x), bg2.height), 0, 575 );
  }
  
  // Text Event 1 - Welcome
  if (x > 0 && x < 500) {
    fill(255);
    textSize(48);
    text("WELCOME", width/2.5, height/8);
  }
  
  // Score Counter
  fill(255);
  textSize(32);
  text("Score: " + scoreCount, 45, height - 45);
  //scoreCount = timer; // Change this to when player completes task
  
  // When the level reaches the end of the background width
  if (x > bgWidth) {
    println("Level Ended. Score: " + scoreCount); 
    x = 0;
    scoreCount = 0;
    timer = 0;
  }
}

void stop()
{
  player.close();
  minim.stop();
  super.stop();
}
