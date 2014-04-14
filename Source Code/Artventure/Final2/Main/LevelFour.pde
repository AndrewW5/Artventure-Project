class LevelFour {

  LevelFour(){
  }

  public void render() {
    
      
      background(255);
      fill(255);
     
      if (counting) {
        timer = (millis()/1000); // In seconds
      }
      
      bgSpeed = 120; // reset
     
      
      // ******************** LEVEL 4 ASSETS INSTANTIATED ********************
      // Each image is loaded into the scene by order of instantiation
      // Ex. Background image is loaded first, so all other assets after will be in front
      // Ex. Cursor image is loaded last, so all other assets before will be behind
      
      // Background Level 4 Instantiated
      if (bgLoaded_four) {
        image( bglevel4.get(int(x), 0 , bglevel4.width-int(x), bglevel4.height), 0, 0 );
        
        // Foreground Level 4  Instantiated
        image( fglevel4.get(int(x), 0 , fglevel4.width-int(x), fglevel4.height), 0, 0);
        // Cracked Rock Instantiated
        if (x > 640 - 1500 && x < 640 && crackedRockLoaded) {
          image( crackedrock_four.get(int(x), 0, crackedrock_four.width-int(x), crackedrock_four.height), 0, 0);
        }
        // Cracked Rock with Rainbow Fish Instantiated
        if (x > 640 - 1500 && x < 640 && crackedRockRainbowFishLoaded) {
          image( crackedrockrainbowfish_four.get(int(x), 0, crackedrockrainbowfish_four.width-int(x), crackedrockrainbowfish_four.height), 0, 0);
        }
        // INFINITE RAINBOW FISH
        if (x > 1920 - 1500 && x < 1920 && infiniteRainbowFishLoaded) {
          image( infiniteRAINBOWFISH.get(int(x), 0, infiniteRAINBOWFISH.width-int(x), infiniteRAINBOWFISH.height), 0, 0);
        }
      }
        
      // ******************** LEVEL 4 ANIMATION and ADVANCE ********************
      
      float dx = lastFingerPosAdv.x - xpos_four; // Distance from cursor, Leap Motion control
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
        archieFlying.display(xpos_four-archieFlying.getWidth()/2, ypos_four + 80); // Display archie above xpos_fourition of character
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
          playerAnimWalk.display(xpos_four-playerAnimWalk.getWidth()/2, ypos_four + rainbowCatPosY);
        }
      } else {
        playerAnimIdle.display(xpos_four-playerAnimIdle.getWidth()/2, ypos_four + rainbowCatPosY);
      }
      if (playerPosStop) {
         playerAnimIdle.display(xpos_four-playerAnimIdle.getWidth()/2, ypos_four + rainbowCatPosY);
      }
      xpos_four = xpos_four + dx/playerMoveSpeed_four; // Moves player to cursor position
      
      
      // Control flow of events
      // Grayscale Greyhound End Fight
      if (greyhoundLoaded) {
        if (x <= bgWidth_four) {
          xpos_four = xpos_four + dx/playerMoveSpeed_four;
        } else {
          bgEndFightLoaded_four = true;
          if (scoreCount <= 250) {
            greyhoundStomp = true;
          } else {
            greyhoundStomp = false;
            greyhoundBark = true;
          }
          playerPosStop = true;
          x = bgWidth_four;
          xpos_four = 300;
          textSize(largeTextSize);
          text("DEFEAT GRAYSCALE GREYHOUND", width/5, height/topScreenPosY);
        }
        x += xpos_four / bgSpeed;
      } else {
        //player.close();
        //player2.play();
      }
      // Greyhound Barking Instantiated
      if (x > 1920 - 1500 && x < 1920 && greyhoundBark) {
        greyhoundBarkAnim.display(550, 200);
      }
      // Greyhound Stomping Instantiated
      if (x > 1920 - 1500 && x < 1920 && greyhoundStomp) {
        greyhoundStompAnim.display(550, 200);
      }
      
      
      // ******************** LEVEL 4 ASSETS INSTANTIATED ********************
      
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
      image(cursor, lastFingerPosAdv.x, lastFingerPosAdv.y, 50, 50);
      // Back button
      image(back, 0, 0);
      
      // ******************** LEVEL 4 TEXT EVENTS ********************
      
      
      // Final Battle Text Event
      if (timer < 1337 && !bgEndFightLoaded_four) {
        textSize(largeTextSize);
        text("FINAL BATTLE APPROACHES", width/4, height/topScreenPosY);
      }
      // Swipe Cracked Rock Text Event, encourage thy player!
      if (!crackedRockLoaded && timer < swipeCrackedRockTimer + textDuration && !bgEndFightLoaded_four) {
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
          bgEndLoaded_four = true;
        }
      }
      // Level End Event
      if (bgEndLoaded_four) {
        scoreCount = 0;
        println("Level Ended. Score: " + scoreCount);
        bgEndLoaded_four = false;
        greyhoundLoaded = false;
        greyhoundBark = false;
        crackedRockRainbowFishLoaded = false;
        infiniteRainbowFishLoaded = true;
        playerPosStop = false;
        x = bgWidth_four;
        xpos_four = 400;
        timer = finishGameTimer;
        finishGameTimer = (millis()/1000) - finishGameTimer;
        //player.close();
        //player2.play();
      }
      // Score Counter
      textSize(32);
      text("Score: " + scoreCount, 45, height - 30);
      
      
      // ******************** TESTING ********************
      
      // Get Finger Positions
        //println(lastFingerPosAdv.x + " " + lastFingerPosAdv.y); // X and Y
        //println("Y: " + lastFingerPosAdv.y); // Just Y
        //println("X: " + lastFingerPosAdv.x); // Just X
        //println(dx);
        //println(xpos_four);
      // Get X or Y Dimensions of Screen
        //println("X: " + x);
        //println("Y: " + y);
      // println(timer);
    
      // Finger Points
      ArrayList<Finger> fingerList = leap.getFingerList();
      if (fingerList.size() > 0) {
        PVector fingerPos = leap.getTip(fingerList.get(0));
        ArrayList<PVector> points = getInterpolatedPoints(lastFingerPosAdv, fingerPos, 2);
        lastFingerPosAdv = fingerPos;
      }   
      
      // BACK TO ADVENTURE MENU
      if(lastFingerPosAdv.x > 0 && lastFingerPosAdv.x < 300 && lastFingerPosAdv.y > 0 && lastFingerPosAdv.y < 300 && lastFingerPosAdv.z < -600) {
        //player.close();
        gAppState = STATE_ADVENTUREMODEMENU;   
        println("Level 4 --> Adventure Menu");

      }
    
  }

}
