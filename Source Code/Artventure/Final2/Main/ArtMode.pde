class ArtMode {

  ArtMode() {
  } 
  
  public void render() {

    background(255);
    
    image(artBG, 0, 0);
    image(cursor, lastFingerPos.x - 25, lastFingerPos.y + 115, 50, 50);
    
    //Off-screen buffer for drawing features
    buffer.beginDraw();     

    ArrayList<Finger> fingerList = leap.getFingerList();
    if (fingerList.size() > 0) {
      PVector fingerPos = leap.getTip(fingerList.get(0));

      /**************************************************
                        BUTTON PRESS
      ***************************************************/

      if (fingerPos.z < -700) {
        println("BUTTON PRESS: " + fingerPos.z);
        
        // BACK TO HOME
        if (lastFingerPos.x > 0 && lastFingerPos.x < 80 && lastFingerPos.y > -150 && lastFingerPos.y < -30) {
          gAppState = STATE_HOMEPAGE;  
          println("Art Mode --> Home");
        }
        // NEW BUTTON
        if (lastFingerPos.x > 120 && lastFingerPos.x < 263 && lastFingerPos.y > -53 && lastFingerPos.y < -4) {
          buffer.background(255); // New Button: Clear the screen
          println("Cleared Screen"); 
          image(cursor, lastFingerPos.x - 25, lastFingerPos.y + 115, 50, 50);
        }
        /********* FUNCTIONS ***********/
         // INCREASE SIZE
        if (lastFingerPos.x > 330 && lastFingerPos.x < 397 && lastFingerPos.y > -145 && lastFingerPos.y < -75) {
          bW = bW*1.5;
          bH = bH*1.5;
          println("Brush Increase. Brush size: " + bW + " by " + bH);
        }
        // DECREASE SIZE
        if (lastFingerPos.x > 330 && lastFingerPos.x < 397 && lastFingerPos.y > -70 && lastFingerPos.y < 0) {
          bW = bW/1.5;
          bH = bH/1.5;
          println("Brush Decrease. Brush size: " + bW + " by " + bH);
        }
        // REGULAR BRUSH
        if (lastFingerPos.x > 423 && lastFingerPos.x < 487 && lastFingerPos.y > -145 && lastFingerPos.y < -75) {
          bAngle = 0;
          bW = 10;
          bH = 10;
          println("Regular brush");
          particle = false;
          paw = false;
        }        
        // PAW BRUSH
        if (lastFingerPos.x > 423 && lastFingerPos.x < 487 && lastFingerPos.y > -70 && lastFingerPos.y < 0) {
          buffer.image(pawCursor, lastFingerPos.x, lastFingerPos.y, 50, 50);
          println("Paw brush");
          particle = false;
          paw = true;
        }
        // CALIGRAPHY BRUSH
        if (lastFingerPos.x > 495 && lastFingerPos.x < 558 && lastFingerPos.y > -145 && lastFingerPos.y < -75) {
          bAngle = 15;
          bW = 5;
          bH = 40;
          buffer.ellipse(lastFingerPos.x, lastFingerPos.y/5, bW, bH);
          println("Calligraphy brush");
          particle = false;
          paw = false;
        }
        // PARTICLE BRUSH
        if (lastFingerPos.x > 494 && lastFingerPos.x < 558 && lastFingerPos.y > -70 && lastFingerPos.y < 0) {
          println("Particle brush");
          particle = true;
          paw = false;
        }
     /********* COLOURS ***********/
        // RED
        if (lastFingerPos.x > 585 && lastFingerPos.x < 648 && lastFingerPos.y > -145 && lastFingerPos.y < -75) {
          col = color(178,4,10);
          buffer.fill(col); 
          println("Red");
        }
        // DARK BLUE
        if (lastFingerPos.x > 585 && lastFingerPos.x < 648 && lastFingerPos.y > -70 && lastFingerPos.y < 0) {
          col = color(18,42,218); 
          buffer.fill(col);
          println("Deep Blue");
        }
        // ORANGE
        if (lastFingerPos.x > 656 && lastFingerPos.x < 718 && lastFingerPos.y > -145 && lastFingerPos.y < -75) {
          col = color(234,127,0); 
          buffer.fill(col);
          println("Orange");
        }
        // PURPLE  
        if (lastFingerPos.x > 656 && lastFingerPos.x < 718 && lastFingerPos.y > -70 && lastFingerPos.y < 0) {
          col = color(111,7,207); 
          buffer.fill(col);
          println("Purple");
        }
        // YELLOW
        if (lastFingerPos.x > 726 && lastFingerPos.x < 788 && lastFingerPos.y > -145 && lastFingerPos.y < -75) {
          col = color(250,230,11); 
          buffer.fill(col);
          println("Yellow");
        }
        // PINK  
        if (lastFingerPos.x > 726 && lastFingerPos.x < 788 && lastFingerPos.y > -70 && lastFingerPos.y < 0) {
          col = color(230,43,215); 
          buffer.fill(col);
          println("Pink");
        }
        // LIGHT GREEN
        if (lastFingerPos.x > 798 && lastFingerPos.x < 860 && lastFingerPos.y > -145 && lastFingerPos.y < -75) {
          col = color(155,178,4); 
          buffer.fill(col);
          println("Light Green");
        }
        // BROWN 
        if (lastFingerPos.x > 798 && lastFingerPos.x < 860 && lastFingerPos.y > -70 && lastFingerPos.y < 0) {
          col = color(80,52,12); 
          buffer.fill(col);
          println("Brown");
        }
        // DARK GREEN
        if (lastFingerPos.x > 866 && lastFingerPos.x < 929 && lastFingerPos.y > -145 && lastFingerPos.y < -75) {
          col = color(25,141,25); 
          buffer.fill(col);
          println("Dark Green");
        }
        // WHITE  
        if (lastFingerPos.x > 866 && lastFingerPos.x < 929 && lastFingerPos.y > -70 && lastFingerPos.y < 0) {
          col = color(255); 
          buffer.fill(col);
          println("White");
        }        
        // TURQUOISE  
        if (lastFingerPos.x > 937 && lastFingerPos.x < 1000 && lastFingerPos.y > -145 && lastFingerPos.y < -75) {
          col = color(16,156,115); 
          buffer.fill(col);
          println("Turquoise");
        }
        // GREY 
        if (lastFingerPos.x > 937 && lastFingerPos.x < 1000 && lastFingerPos.y > -70 && lastFingerPos.y < 0) {
          col = color(100); 
          buffer.fill(col);
          println("Grey");
        }
        // LIGHT BLUE
        if (lastFingerPos.x > 1007 && lastFingerPos.x < 1070 && lastFingerPos.y > -145 && lastFingerPos.y < -75) {
          col = color(28,225,227); 
          buffer.fill(col);
          println("Light Blue");
        }
        // BLACK  
        if (lastFingerPos.x > 1007 && lastFingerPos.x < 1070 && lastFingerPos.y > -70 && lastFingerPos.y < 0) {
          col = color(0); 
          buffer.fill(col);
          println("Black");
        }
        
      }

      /**************************************************
                        PUSH TO DRAW
      ***************************************************/
      
      if (fingerPos.z < -300 && fingerPos.z >= -700) {
        println("/// FINGER OUT at   " + fingerPos.z);
        ArrayList<PVector> points = getInterpolatedPoints(lastFingerPos, fingerPos, 2);
        for (PVector fingerVector: points) { 
            buffer.pushMatrix();
              buffer.noStroke();
              buffer.rotate(radians(bAngle)); // brush rotation (bAngle is currently at 0)
              buffer.ellipse(fingerVector.x, fingerVector.y, bW, bH);
            buffer.popMatrix();
          }
          lastFingerPos = fingerPos;
          
        // PARTICLE BUTTON FUNCTIONALITY
        if(particle){
          bW=0; bH=0;
          float b2 = random(5,100);
          float h = hue(col);
          buffer.colorMode(HSB, 255, 100, 100);
          buffer.fill(h, 100, (random(50, 100)));
          if(col == color(255)){ // White
            buffer.fill(h, 1, (random(80, 100)));
          }if(col == color(0)){ // Black
            buffer.fill(h, 1, (random(0, 20)));
          }if(col == color(100)){ // Grey
            buffer.fill(h, 1, (random(30, 70)));
          }
          buffer.ellipse(random(lastFingerPos.x - 50, lastFingerPos.x + 50), random(lastFingerPos.y - 50, lastFingerPos.y + 50), b2, b2);
        }
        // PAW BUTTON FUNCTIONALITY
        if(paw){
          points = getInterpolatedPoints(lastFingerPos, fingerPos, 200);
          bW=0; bH=0;
          bp=random(30,90);
          buffer.tint(col);
          buffer.image(pawCursor, lastFingerPos.x, lastFingerPos.y, bp, bp);
        }
      }

      /**************************************************
                   PULL BACK TO POINT
      ***************************************************/

      else if (fingerPos.z >= -300) {
        lastFingerPos = fingerPos;
      }
    }

    buffer.endDraw();
    image(buffer, 0, 150);
  }
  
}

