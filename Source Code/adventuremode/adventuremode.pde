// Adventure Mode
// Coded by Andrew Wardell
// Revision V1.0
// Date: March 13, 2014

PImage bg;
PImage bg2;
PImage crate;
PImage toolsmenu;

Animation playerAnim;

float xpos;
float ypos;
float playerMoveSpeed = 60; // How fast the player moves according to cursor position

int scoreCount = 0;
int finalScore = 0;
float y = 0; 
float x = 0;
float bgWidth = 7001 - 1080;
float bgSpeed = 150; // Higher value, slower background. Lower value, faster background

ResourceLoader resourceLoader;

void setup() {
  size (1080, 720);
  background(255);
  frameRate(30);
  
  resourceLoader = new ResourceLoader();
  bg = resourceLoader.getImage("Background2.png");
  bg2 = resourceLoader.getImage("Foreground.png");
  toolsmenu = resourceLoader.getImage("ToolsMenu.png");
  crate = resourceLoader.getImage("Crate.png");
  playerAnim = new Animation("playerAnimation/playerMove", 7);
  ypos = height * 0.35; // y position of player
}

void draw() {
  background(255);

  // When the level reaches the end
  if (x > bgWidth) { 
    x = 0;
    scoreCount = 0;
    println("Level Ended. Final Score: " + scoreCount);
  }
  
  // Background Instantiated 
  image( bg.get(int(x), 0 , bg.width-int(x), bg.height), 0, 0 );
  
  // Tools Menu Instantiated
  image( toolsmenu, 15, 15);
  
  // Animate HERE
  float dx = mouseX - xpos; // Distance from cursor, replace mouseX with the leap position x
  //println(dx);
  //println(xpos);
  //xpos=200; // Stays in one spot
  xpos = xpos + dx/playerMoveSpeed; // Moves player to cursor position
  playerAnim.display(xpos-playerAnim.getWidth()/2, ypos);
  x += xpos / bgSpeed;
  
  // Foreground Instantiated
  image( bg2.get(int(x), 0 , bg2.width-int(x), bg2.height), 0, 575 );
  
  // Crate Instantiated
  float cratePosX = 500;
  if (x < cratePosX) {
    image( crate.get(int(x), 0 , crate.width-int(x), crate.height), 0, 575 );
  }
  
  // Text Event 1
  if (x > 0 && x < 500) {
    fill(255);
    textSize(40);
    text("WELCOME", width/2.5, height/8);
  }
  
  // Score Counter
  fill(255);
  textSize(30);
  float scorePos = 45;
  text("Score: " + scoreCount, scorePos, height - scorePos);  
}
