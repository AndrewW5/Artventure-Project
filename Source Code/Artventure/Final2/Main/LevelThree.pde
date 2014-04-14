class LevelThree {

  LevelThree() {
  }

  public void render() {

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
      
      x = 0; 
      
      image( bgpart1.get(int(x), 0, bgpart1.width-int(x), bgpart1.height), 0, 0 );

      // Foreground Part 1 Instantiated
      if (x < 1080) {
        image( fgpart1.get(int(x), 0, fgpart1.width-int(x), fgpart1.height), 0, 0);
      }
    }
    // Background Part 2 Instantiated
    if (bgPart2Loaded) {
      image( bgpart2.get(int(x), 0, bgpart2.width-int(x), bgpart2.height), 0, 0 );

      // Cracked Rock Instantiated
      if (x > 1340 - 1500 && x < 1340 && crackedRockLoaded_three) {
        image( crackedrock.get(int(x), 0, crackedrock.width-int(x), crackedrock.height), 0, 0);
      }
      // Cracked Rock with Rainbow Fish Instantiated
      if (x > 1340 - 1500 && x < 1340 && crackedRockRainbowFishLoaded_three) {
        image( crackedrockrainbowfish_three.get(int(x), 0, crackedrockrainbowfish_three.width-int(x), crackedrockrainbowfish_three.height), 0, 0);
      }
      // Rainbow Fish in Background Instantiated
      if (x > 1330 - 1500 && x < 1330 && rainbowFishBackgroundLoaded_three) {
        image( rainbowfishbackground_three.get(int(x), 0, rainbowfishbackground_three.width-int(x), rainbowfishbackground_three.height), 0, 0);
      }
      // hole_three Instantiated
      if (x > 1590 - 1500 && x < 1590 && holeLoaded_three) {
        image( hole_three.get(int(x), 0, hole_three.width-int(x), hole_three.height), 0, 0);
      }
    }
    // Background Falling Instantiated
    if (bgFallingLoaded) {
      if (y < bgHeight) { 
        image( bgfalling.get(0, int(y), bgfalling.width, bgfalling.height-int(y)), 0, 0 );
      } 
      else {
        bgPart3Loaded = true;
        bgFallingLoaded = false;
      }
      y += fallingSpeed_three;
    }
    // Background Part 3 Instantiated
    if (bgPart3Loaded) {    
      image( bgpart3.get(int(x), 0, bgpart3.width-int(x), bgpart3.height), 0, 0);
      bgFallingLoaded = false;
      y = 0;
      x = 0;
      // Weird Rock Instantiated
      if (x < 1080 && weirdRockLoaded_three) {
        image( weirdrock_three.get(int(x), 0, weirdrock_three.width-int(x), weirdrock_three.height), 0, 0);
      }
      // Weird Rock with Rainbow Fish Instantiated
      if (x < 1080 && weirdRockRainbowFishLoaded_three) {
        image( weirdrockrainbowfish_three.get(int(x), 0, weirdrockrainbowfish_three.width-int(x), weirdrockrainbowfish_three.height), 0, 0);
      }
      // Dot boxes Instantiated
      if (x < 1080 && dotBoxLoaded_three) {
        image( dotboxes_three.get(int(x), 0, dotboxes_three.width-int(x), dotboxes_three.height), 0, 0);
      }
      // Stacked box_threees Instantiated
      if (x < 1080 && stackedBoxesLoaded_three) {
        image( stackedboxes_three.get(int(x), 0, stackedboxes_three.width-int(x), stackedboxes_three.height), 0, 0);
      }
    }
    if (bgLoaded_three) {  
      image( bgend.get(int(x), 0, bgend.width-int(x), bgend.height), 0, 0);

      // Background End Fight Instantiated
      if (bgEndFightLoaded_three) {
        bgPart3Loaded = false;
        bgSpeed = 150;
        //player.close();
        //player2.play();
        x += xpos_three / bgSpeed;
        // Weird Rock 2 Instantiated
        if (x < 1546 && weirdRock2Loaded_three) {
          image( weirdrock2_three.get(int(x), 0, weirdrock2_three.width-int(x), weirdrock2_three.height), 0, 0);
        }
        // Weird Rock 2 with Rainbow Fish Instantiated
        if (x < 1546 && weirdRock2RainbowFishLoaded_three) {
          image( weirdrock2rainbowfish_three.get(int(x), 0, weirdrock2rainbowfish_three.width-int(x), weirdrock2rainbowfish_three.height), 0, 0);
        }
        // Cracked Rock 2 Instantiated
        if (x > 1160 - 1500 && x < 1160 && crackedRock2Loaded_three) {
          image( crackedrock2_three.get(int(x), 0, crackedrock2_three.width-int(x), crackedrock2_three.height), 0, 0);
        }
        // Cracked Rock 2 with Rainbow Fish Instantiated
        if (x > 1160 - 1500 && x < 1160 && crackedRock2RainbowFishLoaded_three) {
          image( crackedrock2rainbowfish_three.get(int(x), 0, crackedrock2rainbowfish_three.width-int(x), crackedrock2rainbowfish_three.height), 0, 0);
        }
        // Erased Crystals 1 Instantiated
        if (x > 1160 - 1500 && x < 1160 && erasedCrystals1Loaded_three) {
          image( erasedcrystals1_three.get(int(x), 0, erasedcrystals1_three.width-int(x), erasedcrystals1_three.height), 0, 0);
        }
        // Erased Crystals 2 Instantiated
        if (x > 1160 - 1500 && x < 1160 && erasedCrystals2Loaded_three) {
          image( erasedcrystals2_three.get(int(x), 0, erasedcrystals2_three.width-int(x), erasedcrystals2_three.height), 0, 0);
        }
        // Dot box_three Instantiated
        if (x > 1400 - 1500 && x < 1400 && dotBoxLoaded_three) {
          image( dotbox_three.get(int(x), 0, dotbox_three.width-int(x), dotbox_three.height), 0, 0);
        }
        // box_three Instantiated
        if (x > 1400 - 1500 && x < 1400 && boxLoaded_three) {
          image( box_three.get(int(x), 0, box_three.width-int(x), box_three.height), 0, 0);
        }
      }
    }


    // ******************** LEVEL 3 ANIMATION and ADVANCE ********************

    float dx = lastFingerPosAdv.x - xpos_three; // Distance from cursor, Leap Motion control
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
      playerFalling.display(xpos_three-playerFalling.getWidth()/2, 400);
    }
    if (timer < 30) {
      archieFlying.display(xpos_three-archieFlying.getWidth()/2, ypos_three + 80); // Display archie above xpos_threeition of character
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
          playerAnimWalk.display(xpos_three-playerAnimWalk.getWidth()/2, ypos_three + rainbowCatPosY);
        }
      } 
      else {
        playerAnimIdle.display(xpos_three-playerAnimIdle.getWidth()/2, ypos_three + rainbowCatPosY);
      }
    }
    if (playerPosStop) {
      playerAnimIdle.display(xpos_three-playerAnimIdle.getWidth()/2, ypos_three + rainbowCatPosY);
    } 
    xpos_three = xpos_three + dx/playerMoveSpeed; // Moves player to cursor position

    // Control flow of events
    // When Part 1 Ends
    if (xpos_three > 700 && bgPart1Loaded) {
      bgPart1Loaded = false;
      bgPart2Loaded = true;
      xpos_three = 50;
    }
    if (bgPart2Loaded) {    
      if (ceilingrockLoaded_three) {
        if (xpos_three < 200) {
          xpos_three = xpos_three + dx/playerMoveSpeed;
        } 
        else {
          playerPosStop = true;
          xpos_three = 200;
        }
      } 
      else {
        playerPosStop = false;
        x += xpos_three / bgSpeed;
      }
    }
    // When Part 2 Ends
    if (x > 470 && bgPart2Loaded) {
      bgPart2Loaded = false;
      bgFallingLoaded = true;
    }
    // When Part 3 Ends
    if (xpos_three > 800 && bgPart3Loaded && stackedBoxesLoaded_three) {
      bgPart3Loaded = false;
      bgEndFightLoaded_three = true;
      bgLoaded_three = true;
    }
    // Dingo End Fight
    if (bgEndFightLoaded_three) {    
      if (dingoLoaded_three) {
        if (x <= bgEndWidth) {
          xpos_three = xpos_three + dx/playerMoveSpeed_three;
        } 
        else {
          dingoBarkAnim_three = true;
          playerPosStop = true;
          x = bgEndWidth;
          xpos_three = 500;
          textSize(largeTextSize);
          text("DEFEAT DINGO", width/middleScreenPosX, height/topScreenPosY);
        }
      }
    } 
    else {
      // When End Fight is over, player moves to right and level ends
      if (xpos_three > 900 && dingoStarsAnim) {
        bgEndLoaded_three = true;
        dingoStarsAnim = false;
      } 
      else {      
        playerPosStop = false;
        xpos_three = xpos_three + dx/playerMoveSpeed;
      }
    }
    // Dingo Barking Instantiated
    if (x > 1920 - 1500 && x < 1920 && dingoBarkAnim_three) {
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
      if (ceilingrockLoaded_three) {
        image( ceilingrock.get(int(x), 0, ceilingrock.width-int(x), ceilingrock.height), 0, 0);
      }
      // Foreground Part 2 Instantiated
      if (x < 2950) {
        image( fgpart2.get(int(x), 0, fgpart2.width-int(x), fgpart2.height), 0, 0 );
      }
      // Breakable Crystals Instantiated
      if (x > 1080 - 1500 && x < 1340 && breakableCrystalsLoaded_three) {
        image( breakablecrystals.get(int(x), 0, breakablecrystals.width-int(x), breakablecrystals.height), 0, 0);
      }
      // Breakable Crystals with Rainbow Fish Instantiated
      if (x > 1080 - 1500 && x < 1340 && breakableCrystalsRainbowFishLoaded_three) {
        image( breakablecrystalsrainbowfish.get(int(x), 0, breakablecrystalsrainbowfish.width-int(x), breakablecrystalsrainbowfish.height), 0, 0);
      }
    }
    // Background Part 3 Instantiated
    if (bgPart3Loaded) {        
      // Foreground Part 3 Instantiated
      if (x < 1080) {
        image( fgpart3.get(int(x), 0, fgpart3.width-int(x), fgpart3.height), 0, 0);
      }
    }
    if (bgEndFightLoaded_three) {
      // Foreground End Instantiated
      if (x < 1546) {
        image( fgend.get(int(x), 0, fgend.width-int(x), fgend.height), 0, 0);
      }
    }

    // Cursor Instantiated
    image(cursor, lastFingerPosAdv.x, lastFingerPosAdv.y, 50, 50);
    // Back button
    image(back, 0, 0);


    // TEXT boxES - Archie and Dingo
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
    if (bgEndFightLoaded_three && x < 500) {
      textBoxArchieLoaded = true;
      textSize(smallerTextSize);
      text("Stop! Don't you erase one more thing!", 
      width/5, height/1.2);
    }
    if (bgEndFightLoaded_three && x >= 500) {
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
    if (!dingoLoaded_three) {
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
    if (!breakableCrystalsLoaded_three && timer < swipeBreakablecrystalsTimer_three + textDuration && bgPart2Loaded) {
      textSize(normalTextSize);
      text("Beautiful Colours! +50 Points", width/middleScreenPosX, height/middleScreenPosY);
    }
    // Text Event - Drawing the box_threees
    if (!stackedBoxesLoaded_three && bgPart3Loaded) {
      textSize(normalTextSize);
      text("Draw the boxes to continue!", width/middleScreenPosX, height/middleScreenPosY);
    }
    // Swipe Dot box_threees Text, encourage thy player!
    if (timer < swipeDotBoxesTimer_three + textDuration && bgPart3Loaded) {
      textSize(normalTextSize);
      text("Nice! Continue by climbing up!", width/middleScreenPosX, height/middleScreenPosY);
    }
    // When they finish level text
    if (timer < exitCaveTimer_three + textDurEnd) {
      textSize(normalTextSize);
      text("Congratulations! You beat the level!", width/middleScreenPosX, height/middleScreenPosY);
    }
    // End Fight is over
    if (timer < swipeDotBoxTimer_three + textDuration + 5 && bgEndLoaded_three) {
      dingoLoaded_three = false;
      boxLoaded_three = false;
    }



    // ******************** LEVEL 3 GESTURE INTERACTION ********************

    // Swiping the breakable crystals
    if (swipeBreakablecrystals_three) {
      scoreCount += 50;
      breakableCrystalsRainbowFishLoaded_three = true;
      breakableCrystalsLoaded_three = false;
      swipeBreakablecrystals_three = false;
      timer = swipeBreakablecrystalsTimer_three;
      swipeBreakablecrystalsTimer_three = (millis()/1000) - swipeBreakablecrystalsTimer_three;
    } 
    // Swiping the cracked rock
    if (swipeCrackedRock_three) {
      scoreCount += 50;
      crackedRockRainbowFishLoaded_three = true;
      crackedRockLoaded_three = false;
      swipeCrackedRock_three = false;
      timer = swipeCrackedRockTimer_three;
      swipeCrackedRockTimer_three = (millis()/1000) - swipeCrackedRockTimer_three;
    }
    // Swiping the Rainbow Fish in background
    if (swipeRainbowFishBackground_three) {
      scoreCount += 10;
      rainbowFishBackgroundLoaded_three = true;
      swipeRainbowFishBackground_three = false;
      timer = swipeRainbowFishBackgroundTimer_three;
      swipeRainbowFishBackgroundTimer_three = (millis()/1000) - swipeRainbowFishBackgroundTimer_three;
    }
    // Swiping the weird rock
    if (swipeWeirdRock_three) {
      scoreCount += 50;
      weirdRockRainbowFishLoaded_three = true;
      weirdRockLoaded_three = false;
      swipeWeirdRock_three = false;
      timer = swipeWeirdRockTimer_three;
      swipeWeirdRockTimer_three = (millis()/1000) - swipeWeirdRockTimer_three;
    }
    // Swiping the Dot box_threees in Part 3
    if (swipeDotBoxes_three) {
      scoreCount += 50;
      stackedBoxesLoaded_three = true;
      dotBoxesLoaded_three = false;
      swipeDotBoxes_three = false;
      timer = swipeDotBoxesTimer_three;
      swipeDotBoxesTimer_three = (millis()/1000) - swipeDotBoxesTimer_three;
    }
    // Swiping the weird rock 2
    if (swipeWeirdRock2_three) {
      scoreCount += 50;
      weirdRock2RainbowFishLoaded_three = true;
      weirdRock2Loaded_three = false;
      swipeWeirdRock2_three = false;
      timer = swipeWeirdRock2Timer_three;
      swipeWeirdRock2Timer_three = (millis()/1000) - swipeWeirdRock2Timer_three;
    }
    // Swiping the cracked rock 2
    if (swipeCrackedRock2_three) {
      scoreCount += 50;
      crackedRock2RainbowFishLoaded_three = true;
      crackedRock2Loaded_three = false;
      swipeCrackedRock2_three = false;
      timer = swipeCrackedRock2Timer_three;
      swipeCrackedRock2Timer_three = (millis()/1000) - swipeCrackedRock2Timer_three;
    }
    // Swiping the erased crystals
    if (swipeErasedCrystals_three) {
      scoreCount += 50;
      erasedCrystals2Loaded_three = true;
      erasedCrystals1Loaded_three = false;
      swipeErasedCrystals_three = false;
      timer = swipeErasedCrystalsTimer_three;
      swipeErasedCrystalsTimer_three = (millis()/1000) - swipeErasedCrystalsTimer_three;
    }
    // Swiping Dot box_three in End Fight
    if (swipeDotBox_three) {
      boxLoaded_three = true;
      dotBoxLoaded_three = false;
      swipeDotBox_three = false;
      dingoStarsAnim = true;
      dingoBarkAnim_three = false;
      bgEndFightLoaded_three = false;
      timer = swipeDotBoxTimer_three;
      swipeDotBoxTimer_three = (millis()/1000) - swipeDotBoxTimer_three;
    }
    // Level End Event
    if (bgEndLoaded_three) {
      println("Level Ended. Score: " + scoreCount);
      bgEndLoaded_three = false;
      x = 0;
      xpos_three = 500;
      scoreCount = 0;
      timer = exitCaveTimer_three;
      exitCaveTimer_three = (millis()/1000) - exitCaveTimer_three;
      //player2.close();
    }
    // Score Counter
    textSize(32);
    text("Score: " + scoreCount, 45, height - 45);


    // ******************** TESTING ********************

    // Get Finger Positions
    //println(lastFingerPosAdv.x + " " + lastFingerPosAdv.y); // X and Y
    //println("Y: " + lastFingerPosAdv.y); // Just Y
    //println("X: " + lastFingerPosAdv.x); // Just X
    //println(dx);
    //println(xpos_three);
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



    println("x: " + lastFingerPosAdv.x + " y: " + lastFingerPosAdv.y + " z: " + lastFingerPosAdv.z); 
    // BACK TO ADVENTURE MENU
    if (lastFingerPosAdv.x > 0 && lastFingerPosAdv.x < 300 && lastFingerPosAdv.y > 0 && lastFingerPosAdv.y < 300 && lastFingerPosAdv.z < -600) {
      //player2.close();
      gAppState = STATE_ADVENTUREMODEMENU;   
      println("Level 3 --> Adventure Menu");
    }
  }
}

