class ArtMode {

  ArtMode() {
  } 

  public void render() {

    background(255);

    image(bannerTop, 0, 0);
    image(newButton, 150, 86, 142, 50);
    image(red, 320, 5, 70, 70);
    image(green, 320, 80, 70, 70);
    image(blue, 395, 5, 70, 70);
    image(orange, 395, 80, 70, 70);
    image(yellow, 470, 5, 70, 70);
    image(lblue, 470, 80, 70, 70);
    image(turq, 545, 5, 70, 70);
    image(purple, 545, 80, 70, 70);
    image(pink, 620, 5, 70, 70);
    image(grey, 620, 80, 70, 70);
    image(white, 695, 5, 70, 70);
    image(black, 695, 80, 70, 70);
    image(brushDecrease, 830, 5, 70, 70);
    image(brushIncrease, 830, 80, 70, 70);
    image(regularBrush, 905, 5, 70, 70);
    image(caligBrush, 905, 80, 70, 70);
    image(pawBrush, 980, 5, 70, 70);
    image(dotBrush, 980, 80, 70, 70);

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
        if (lastFingerPos.x > 0 && lastFingerPos.x < 201 && lastFingerPos.y > -150 && lastFingerPos.y < 0) {
          gAppState = STATE_HOMEPAGE;  
          println("BACK TO: Homepage");
        }
        
        // NEW BUTTON
        if (lastFingerPos.x > 190 && lastFingerPos.x < 340 && lastFingerPos.y > -59 && lastFingerPos.y < -8) {
          buffer.background(255); // New Button: Clear the screen
          println("Cleared Screen"); 
          image(cursor, lastFingerPos.x - 25, lastFingerPos.y + 115, 50, 50);
        }
 
        // RED
        if (lastFingerPos.x > 319 && lastFingerPos.x < 391 && lastFingerPos.y > -138 && lastFingerPos.y < -70) {
          buffer.fill(255, 0, 0); 
          println("Red");
        }
        // GREEN
        if (lastFingerPos.x > 319 && lastFingerPos.x < 391 && lastFingerPos.y > -63 && lastFingerPos.y < 7) {
          buffer.fill(10, 178, 4); 
          println("Green");
        }
        // BLUE
        if (lastFingerPos.x > 394 && lastFingerPos.x < 466 && lastFingerPos.y > -138 && lastFingerPos.y < -70) {
          buffer.fill(4, 28, 178); 
          println("Blue");
        }
        // ORANGE
        if (lastFingerPos.x > 394 && lastFingerPos.x < 466 && lastFingerPos.y > -63 && lastFingerPos.y < 7) {
          buffer.fill(178, 73, 4); 
          println("Orange");
        }
        // YELLOW
        if (lastFingerPos.x > 469 && lastFingerPos.x < 541 && lastFingerPos.y > -138 && lastFingerPos.y < -70) {
          buffer.fill(178, 151, 4); 
          println("Yellow");
        }
        // LIGHT BLUE
        if (lastFingerPos.x > 469 && lastFingerPos.x < 541 && lastFingerPos.y > -63 && lastFingerPos.y < 7) {
          buffer.fill(4, 178, 175); 
          println("Light Blue");
        }
        // TURQUOISE  
        if (lastFingerPos.x > 544 && lastFingerPos.x < 616 && lastFingerPos.y > -138 && lastFingerPos.y < -70) {
          buffer.fill(4, 178, 118); 
          println("Turquoise");
        }
        // PURPLE  
        if (lastFingerPos.x > 544 && lastFingerPos.x < 616 && lastFingerPos.y > -63 && lastFingerPos.y < 7) {
          buffer.fill(4, 178, 118); 
          println("Purple");
        }
        // PINK  
        if (lastFingerPos.x > 619 && lastFingerPos.x < 691 && lastFingerPos.y > -138 && lastFingerPos.y < -70) {
          buffer.fill(178, 4, 129); 
          println("Pink");
        }
        // GREY 
        if (lastFingerPos.x > 619 && lastFingerPos.x < 691 && lastFingerPos.y > -63 && lastFingerPos.y < 7) {
          buffer.fill(100); 
          println("Grey");
        }
        // WHITE  
        if (lastFingerPos.x > 694 && lastFingerPos.x < 766 && lastFingerPos.y > -138 && lastFingerPos.y < -70) {
          buffer.fill(0); 
          println("White");
        }
        // BLACK  
        if (lastFingerPos.x > 694 && lastFingerPos.x < 766 && lastFingerPos.y > -63 && lastFingerPos.y < 7) {
          buffer.fill(255); 
          println("Black");
        }
        
        // DECREASE SIZE
        if (lastFingerPos.x > 829 && lastFingerPos.x < 901 && lastFingerPos.y > -138 && lastFingerPos.y < -70) {
          bW = bW/1.5;
          bH = bH/1.5;
          println("Brush Decrease. Brush size: " + bW + " by " + bH);
        }
        // INCREASE SIZE
        if (lastFingerPos.x > 829 && lastFingerPos.x < 901 && lastFingerPos.y > -63 && lastFingerPos.y < 7) {
          bW = bW*1.5;
          bH = bH*1.5;
          println("Brush Increase. Brush size: " + bW + " by " + bH);
        }
        // REGULAR BRUSH
        if (lastFingerPos.x > 904 && lastFingerPos.x < 976 && lastFingerPos.y > -138 && lastFingerPos.y < -70) {
          bAngle = 0;
          bW = 10;
          bH = 10;
          println("Regular brush");
        }
        // CALIGRAPHY BRUSH
        if (lastFingerPos.x > 904 && lastFingerPos.x < 976 && lastFingerPos.y > -63 && lastFingerPos.y < 7) {
          bAngle = 15;
          bW = 5;
          bH = 40;
          buffer.ellipse(lastFingerPos.x, lastFingerPos.y/5, bW, bH);
          println("Calligraphy brush");
        }
        // PAW BRUSH
        if (lastFingerPos.x > 979 && lastFingerPos.x < 1051 && lastFingerPos.y > -138 && lastFingerPos.y < -70) {
          buffer.image(pawBrush, lastFingerPos.x, lastFingerPos.y, 50, 50);
          println("Paw brush");
        }
        // DOT BRUSH
        if (lastFingerPos.x > 979 && lastFingerPos.x < 1051 && lastFingerPos.y > -63 && lastFingerPos.y < 7) {
          buffer.image(pawBrush, lastFingerPos.x, lastFingerPos.y, 50, 50);
          println("Paw brush");
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

