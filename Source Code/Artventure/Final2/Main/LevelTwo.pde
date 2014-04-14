class LevelTwo {

  LevelTwo(){
  }

  public void render() {
        
      background(255);
      fill(255);
     
      if (counting) {
        timer = (millis()/1000); // In seconds
      }
      
      bgSpeed = 120; // reset
      playerMoveSpeed_two = 50; // reset
      
      //player1.play();
      
      // ******************** LEVEL 2 ASSETS INSTANTIATED ********************
      // Each image is loaded into the scene by order of instantiation
      // Ex. Background image is loaded first, so all other assets after will be in front
      // Ex. Cursor image is loaded last, so all other assets before will be behind
      
      // Background Instantiated 
      image( bg2.get(int(x), 0 , bg2.width-int(x), bg2.height), 0, 0 );
      
      // Water Fountain Instantiated
      if (x > 2160 - 1500 && x < 2160 && waterFountainLoaded) {
        image( waterfountain.get(int(x), 0 , waterfountain.width-int(x), waterfountain.height), 0, 0);
      }
      // Water Fountain 2 Instantiated
      if (x > 2400 - 1500 && x < 2400 && waterFountain2Loaded) {
        image( waterfountain2.get(int(x), 0 , waterfountain2.width-int(x), waterfountain2.height), 0, 0);
      }
      // Bridge Outline Instantiated
      if (x < 1220 && bridgeOutlineLoaded) {
        image( bridgeoutline.get(int(x), 0 , bridgeoutline.width-int(x), bridgeoutline.height), 0, 0);
      }
      // Bridge Instantiated
      if (x < 1220 && bridgeLoaded) {
        image( bridge.get(int(x), 0 , bridge.width-int(x), bridge.height), 0, 0);
      }
      // Hedge Instantiated
      if (x > 1600 - 1500 && x < 1600 && hedgeLoaded) {
        image( hedge.get(int(x), 0 , hedge.width-int(x), hedge.height), 0, 0);
      }
      // Hedge with Rainbow Fish Instantiated
      if (x > 1600 - 1500 && x < 1600 && hedgeRainbowFishLoaded) {
        image( hedgerainbowfish.get(int(x), 0 , hedgerainbowfish.width-int(x), hedgerainbowfish.height), 0, 0);
      }
      // Hole Instantiated
      if (x > 2800 - 1500 && x < 2800 && hole3Loaded) {
        image( hole3.get(int(x), 0 , hole3.width-int(x), hole3.height), 0, 0);
      }
      // Dead Tree Instantiated
      if (x > 4100 - 1500 && x < 4100) {
        image( deadtree.get(int(x), 0 , deadtree.width-int(x), deadtree.height), 0, 0);
      }
      // Dead Tree with Rainbow Fish Instantiated
      if (x > 4100 - 1500 && x < 4100 && deadTreeRainbowFishLoaded) {
        image( deadtreerainbowfish.get(int(x), 0 , deadtreerainbowfish.width-int(x), deadtreerainbowfish.height), 0, 0);
      }
      // Crate Instantiated
      if (x > 4880 - 1500 && x < 4880 && crateLoaded) {
        image( crate2.get(int(x), 0 , crate2.width-int(x), crate2.height), 0, 0);
      }
      // Crate with Rainbow Fish Instantiated
      if (x > 4880 - 1500 && x < 4880 && crateRainbowFishLoaded) {
        image( craterainbowfish.get(int(x), 0 , craterainbowfish.width-int(x), craterainbowfish.height), 0, 0);
      }
      // Boulder Back Instantiated
      if (x > 3290 - 1500 && x < 3290 && boulderBackLoaded) {
        image( boulderback.get(int(x), 0 , boulderback.width-int(x), boulderback.height), 0, 0);
      }
      // Boulder Smashable Instantiated
      if (x > 3290 - 1500 && x < 3290 && boulderSmashableLoaded) {
        image( bouldersmashable.get(int(x), 0 , bouldersmashable.width-int(x), bouldersmashable.height), 0, 0);
      }
      // Boulder Smashable with Rainbow Fish Instantiated
      if (x > 3290 - 1500 && x < 3290 && boulderSmashableRainbowFishLoaded) {
        image( bouldersmashablerainbowfish.get(int(x), 0 , bouldersmashablerainbowfish.width-int(x), bouldersmashablerainbowfish.height), 0, 0);
      }
      // Large Rock Outline Instantiated
      if (x > 2150 - 1500 && x < 2150 && largeRockOutlineLoaded) {
        image( largerockoutline.get(int(x), 0 , largerockoutline.width-int(x), largerockoutline.height), 0, 0);
      }
      // Large Rock Instantiated
      if (x > 2130 - 1500 && x < 2130 && largeRock1Loaded) {
        image( largerock1.get(int(x), 0 , largerock1.width-int(x), largerock1.height), 0, 0);
      }
      // Large Rock 2 Instantiated
      if (x > 2470 - 1500 && x < 2470 && largeRock2Loaded) {
        image( largerock2.get(int(x), 0 , largerock2.width-int(x), largerock2.height), 0, 0);
      }
      // Large Rock 3 Instantiated
      if (x > 2780 - 1500 && x < 2780 && largeRock3Loaded) {
        image( largerock3.get(int(x), 0 , largerock3.width-int(x), largerock3.height), 0, 0);
      }
      // House Outline Instantiated
      if (x > 6500 - 1500 && x < 6500 && houseOutlineLoaded) {
        image( houseoutline.get(int(x), 0 , houseoutline.width-int(x), houseoutline.height), 0, 0);
      }
      // House Instantiated
      if (x > 6500 - 1500 && x < 6500 && houseLoaded) {
        image( house.get(int(x), 0 , house.width-int(x), house.height), 0, 0);
      }
      // Door Outline Instantiated
      if (x > 6330 - 1500 && x < 6330 && doorOutlineLoaded) {
        image( dooroutline.get(int(x), 0 , dooroutline.width-int(x), dooroutline.height), 0, 0);
      }
      // Door Instantiated
      if (x > 6330 - 1500 && x < 6330 && doorLoaded) {
        image( door.get(int(x), 0 , door.width-int(x), door.height), 0, 0);
      }
      // Roof Outline Instantiated
      if (x > 6700 - 1500 && x < 6700 && roofOutlineLoaded) {
        image( roofoutline.get(int(x), 0 , roofoutline.width-int(x), roofoutline.height), 0, 0);
      }
      // Roof Instantiated
      if (x > 6700 - 1500 && x < 6700 && roofLoaded) {
        image( roof.get(int(x), 0 , roof.width-int(x), roof.height), 0, 0);
      }
      // Window Right Outline Instantiated
      if (x > 6615 - 1500 && x < 6615 && windowRightOutlineLoaded) {
        image( windowrightoutline.get(int(x), 0 , windowrightoutline.width-int(x), windowrightoutline.height), 0, 0);
      }
      // Window Right Instantiated
      if (x > 6615 - 1500 && x < 6615 && windowRightLoaded) {
        image( windowright.get(int(x), 0 , windowright.width-int(x), windowright.height), 0, 0);
      }
      // Window Left Outline Instantiated
      if (x > 6050 - 1500 && x < 6050 && windowLeftOutlineLoaded) {
        image( windowleftoutline.get(int(x), 0 , windowleftoutline.width-int(x), windowleftoutline.height), 0, 0);
      }
      // Window Left Instantiated
      if (x > 6050 - 1500 && x < 6050 && windowLeftLoaded) {
        image( windowleft.get(int(x), 0 , windowleft.width-int(x), windowleft.height), 0, 0);
      }
      
    
      // ******************** LEVEL 2 ANIMATION ********************
      
      float dx = lastFingerPosAdv.x - xpos_two; // Distance from cursor, Leap Motion control
      int passedTime = millis() - savedTime; // Save the time that has passed in a variable
      
      if (timer < 30) {
        archieFlying.display(xpos_two-archieFlying.getWidth()/2, ypos_two + 80); // Display archie above xpos_twoition of character
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
        playerAnimWalk.display(xpos_two-playerAnimWalk.getWidth()/2, ypos_two + rainbowCatPosY);
      } else {
        playerAnimIdle.display(xpos_two-playerAnimIdle.getWidth()/2, ypos_two + rainbowCatPosY);
      }
      xpos_two = xpos_two + dx/playerMoveSpeed_two; // Moves player to cursor position
      
      
      
    
      // ******************** LEVEL 2 ADVANCE ********************
      
      int smallTextSize = 30;
      int normalTextSize = 35;
      int largeTextSize = 48;
      int middleScreenPosX = 3;
      int middleScreenPosY = 2;
      int topScreenPosY = 8;
      int textDuration = 4;
      int textDurEnd = 6; // Loading time
      
      // User must strike the bridge outline to continue the level
      if (bridgeOutlineLoaded) {
        if (xpos_two < 500) {
          xpos_two = xpos_two + dx/playerMoveSpeed_two;
        } else {
          xpos_two = 500;
        }
      } else {
        x += xpos_two / bgSpeed; 
      }
      // Slowing the game down to swipe house components
      if (x > 4800) {
        bgSpeed = 250;
        //player1.close();
        //player2.play();
      }
      
      
      // ******************** LEVEL 2 ASSETS INSTANTIATED ********************
      
      // Foreground Instantiated
      if (x < 5400) {
        image( fg2.get(int(x), 0 , fg2.width-int(x), fg2.height), 0, 0);
      }
      // Cursor Instantiated
      image(cursor, lastFingerPosAdv.x, lastFingerPosAdv.y, 50, 50);
      // Back button
      image(back, 0, 0);
      
      // TEXT BOXES - Archie
      // *********************************************************************
      int firstTextStart = 0;
      int firstTextEnd = 500;
      int secondTextStart = 0;
      int secondTextEnd = 500;
      int thirdTextStart = 5000;
      int thirdTextEnd = 5500;
      int fourthTextStart = 5500;
      int fourthTextEnd = 7001;
      
      if (textBoxArchieLoaded) {
        image( archietextbox, 0, 0);
      }
      if (x > firstTextStart && x < firstTextEnd && xpos_two < 100) {
        textBoxArchieLoaded = true;
        textSize(smallerTextSize - 3);
        text("Wow, you didn't die. Congratulations, I guess cats really do always land on their\nfeet. Well, let's get a move on then, and keep an eye out, there are sure to be more\nenemies along this path who want to keep us from the Grayscale Greyhound.", 
        width/5, height/1.2);
      }
      if (x > secondTextStart && x < secondTextEnd && xpos_two > 100) {
        textBoxArchieLoaded = true;
        textSize(smallerTextSize - 3);
        text("Oh fiddlesticks, the bridge is out. Fear not my hydrophobic companion, see those\ndotted lines? You can use your paintbrush to trace those lines and create a new object in the world.\nGo ahead and give it a try. Quickly now, we have precious little time to waste.", 
        width/5, height/1.2);
      } 
      if (x > thirdTextStart && x < thirdTextEnd) {
        textBoxArchieLoaded = true;
        textSize(smallerTextSize);
        text("Look, its Dingo Deleto. That dastardly devil is deleting everyone's houses.\nPerhaps you should help fix the damage he's done and chase after him.", 
        width/5, height/1.2);
      }
      if (x > fourthTextStart && x < fourthTextEnd) {
        textBoxArchieLoaded = true;
        textSize(smallerTextSize);
        text("Make haste you paint-speckled peon, we can't let him get away!", 
        width/5, height/1.2);
      }

      
    
    
      // ******************** LEVEL 2 TEXT EVENTS ********************
    
      // End Level Event
      if (timer < endLevelTimer + textDurEnd) {
        textSize(normalTextSize);
        text("Congratulations! You beat the level!", width/middleScreenPosX, height/middleScreenPosY);
      }
      // Welcome Text Event for a duration of time
      if (timer < 15) {
        textSize(largeTextSize);
        text("WELCOME TO LEVEL 2", width/middleScreenPosX, height/topScreenPosY);
      }
      // Strike objects, events, rainbow fish
      if (x > 800 && x < 1200 && timer > 15) {
        textSize(smallTextSize);
        text("Strike objects to gain points!\nEvents may happen!\nYou might even find Rainbow Fish!", width/middleScreenPosX, height/topScreenPosY);
      }
      // Help Text Event 1 - Telling the user to draw the bridge
      if (bridgeOutlineLoaded && timer > 7 && timer < 20) {
        textSize(smallTextSize);
        text("Draw the Bridge!", width/middleScreenPosX, height/middleScreenPosY);
      }
      // Help Text Event 2 - Reminding the user to draw the bridge
      if (bridgeOutlineLoaded && timer > 20) {
        textSize(smallTextSize);
        text("Draw the Bridge by drawing the outline\nusing the Leap Motion!", width/middleScreenPosX, height/middleScreenPosY);
      }
      // Swipe Bridge Outline Text Event, encourage thy player!
      if (!bridgeOutlineLoaded && timer < swipeBridgeOutlineTimer + textDuration) {
        textSize(normalTextSize);
        text("Amazing! +100 Points", width/middleScreenPosX, height/middleScreenPosY);
      }
      // Swipe Hedge Text Event, encourage thy player!
      if (!hedgeLoaded && timer < swipeHedgeTimer + textDuration) {
        textSize(normalTextSize);
        text("Nice Fish! +50 Points", width/middleScreenPosX - 0.5, height/middleScreenPosY);
      }
      // Swipe Boulder Text Event, encourage thy player!
      if (!boulderSmashableLoaded && timer < swipeBoulderTimer + textDuration) {
        textSize(normalTextSize);
        text("Wow! Look beneath the rocks! +50 Points", width/middleScreenPosX - 0.5, height/middleScreenPosY);
      }
      // Swipe Crate Text Event, encourage thy player!
      if (!crateLoaded && timer < swipeCrateTimer + textDuration) {
        textSize(normalTextSize);
        text("Cool Crates! +50 Points", width/middleScreenPosX - 0.5, height/middleScreenPosY);
      }
      // Swipe Large Rock Outline Text Event, encourage thy player!
      if (!largeRockOutlineLoaded && timer < swipeLargeRockOutlineTimer + textDuration) {
        textSize(normalTextSize);
        text("Plugged the water! +30 Points", width/middleScreenPosX - 0.5, height/middleScreenPosY);
      }
      // Swipe Large Rock 3 Text Event, encourage thy player!
      if (!largeRock3Loaded && timer < swipeLargeRockTimer + textDuration) {
        textSize(normalTextSize);
        text("Destroyed the rock! +30 Points", width/middleScreenPosX - 0.5, height/middleScreenPosY);
      }
      // Swipe Dead Tree Text Event, encourage thy player!
      if (deadTreeRainbowFishLoaded && timer < swipeDeadTreeTimer + textDuration) {
        textSize(normalTextSize);
        text("Look at all of them! +50 Points", width/middleScreenPosX - 0.5, height/middleScreenPosY);
      }
      // Swipe Roof Outline Text Event, encourage thy player!
      if (roofLoaded && timer < swipeRoofOutlineTimer + textDuration) {
        textSize(normalTextSize);
        text("Painted a house!", width/middleScreenPosX - 0.5, height/middleScreenPosY);
      }
      
    
    
      // ******************** LEVEL 2 GESTURE INTERACTION ********************
      
      // Swiping the Bridge Outline
      if (swipeBridgeOutline) {
        scoreCount += 100;
        swipeBridgeOutline = false;
        bridgeOutlineLoaded = false;
        bridgeLoaded = true;
        timer = swipeBridgeOutlineTimer;
        swipeBridgeOutlineTimer = (millis()/1000) - swipeBridgeOutlineTimer;
      }
      // Swiping the Hedge
      if (swipeHedge) {
        scoreCount += 50;
        swipeHedge = false;
        hedgeRainbowFishLoaded = true;
        hedgeLoaded = false;
        timer = swipeHedgeTimer;
        swipeHedgeTimer = (millis()/1000) - swipeHedgeTimer;
      }
      // Swiping the Boulder
      if (swipeBoulder) {
        scoreCount += 50;
        swipeBoulder = false;
        boulderSmashableRainbowFishLoaded = true;
        boulderSmashableLoaded = false;
        timer = swipeBoulderTimer;
        swipeBoulderTimer = (millis()/1000) - swipeBoulderTimer;
      }
      // Swiping the Crates
      if (swipeCrate) {
        scoreCount += 50;
        swipeCrate = false;
        crateRainbowFishLoaded = true;
        crateLoaded = false;
        timer = swipeCrateTimer;
        swipeCrateTimer = (millis()/1000) - swipeCrateTimer;
      }
      // Swiping the Large Rock Outline
      if (swipeLargeRockOutline) {
        scoreCount += 30;
        swipeLargeRockOutline = false;
        largeRockLoaded = true;
        largeRockOutlineLoaded = false;
        waterFountainLoaded = false;
        waterFountain2Loaded = true;
        largeRock2Loaded = false;
        largeRock3Loaded = true;
        timer = swipeLargeRockOutlineTimer;
        swipeLargeRockOutlineTimer = (millis()/1000) - swipeLargeRockOutlineTimer;
      }
      // Swiping the Large Rock
      if (swipeLargeRock) {
        scoreCount += 30;
        swipeLargeRock = false;
        largeRock3Loaded = false;
        timer = swipeLargeRockTimer;
        swipeLargeRockTimer = (millis()/1000) - swipeLargeRockTimer;
      }
      // Swiping the Dead Tree
      if (swipeDeadTree) {
        scoreCount += 50;
        deadTreeRainbowFishLoaded = true;
        swipeDeadTree = false;
        timer = swipeDeadTreeTimer;
        swipeDeadTreeTimer = (millis()/1000) - swipeDeadTreeTimer;
      }
      // Swiping the Door Outline
      if (swipeDoorOutline) {
        scoreCount += 10;
        swipeDoorOutline = false;
        doorOutlineLoaded = false;
        doorLoaded = true;
        timer = swipeDoorOutlineTimer;
        swipeDoorOutlineTimer = (millis()/1000) - swipeDoorOutlineTimer;
      }
      // Swiping the House Outline
      if (swipeHouseOutline) {
        scoreCount += 10;
        swipeHouseOutline = false;
        houseOutlineLoaded = false;
        houseLoaded = true;
        timer = swipeHouseOutlineTimer;
        swipeHouseOutlineTimer = (millis()/1000) - swipeHouseOutlineTimer;
      }
      // Swiping the Roof Outline
      if (swipeRoofOutline) {
        scoreCount += 10;
        swipeRoofOutline = false;
        roofOutlineLoaded = false;
        roofLoaded = true;
        timer = swipeRoofOutlineTimer;
        swipeRoofOutlineTimer = (millis()/1000) - swipeRoofOutlineTimer;
      }
      // Swiping the Window Right Outline
      if (swipeWindowRightOutline) {
        scoreCount += 10;
        swipeWindowRightOutline = false;
        windowRightOutlineLoaded = false;
        windowRightLoaded = true;
        timer = swipeWindowRightOutlineTimer;
        swipeWindowRightOutlineTimer = (millis()/1000) - swipeWindowRightOutlineTimer;
      }
      // Swiping the Window Left Outline
      if (swipeWindowLeftOutline) {
        scoreCount += 10;
        swipeWindowLeftOutline = false;
        windowLeftOutlineLoaded = false;
        windowLeftLoaded = true;
        timer = swipeWindowLeftOutlineTimer;
        swipeWindowLeftOutlineTimer = (millis()/1000) - swipeWindowLeftOutlineTimer;
      }
      // Circling the Green Bee
      if (circleBeeGreen) {
        scoreCount += 10;
        greenBeeLoaded = false;
        circleBeeGreen = false;
      }
      // Circling the Purple Bee
      if (circleBeePurple) {
        scoreCount += 10;
        purpleBeeLoaded = false;
        circleBeePurple = false;
      }
      // Circling the Red Bee
      if (circleBeeRed) {
        scoreCount += 10;
        redBeeLoaded = false;
        circleBeeRed = false;
      }
      // Level End Event
      if (x > bgWidth_two) {
        println("Level Ended. Score: " + scoreCount); 
        x = 0;
        scoreCount = 0;
        bgSpeed = 10000; // temp
        playerMoveSpeed_two = 10000; // temp
        timer = endLevelTimer;
        endLevelTimer = (millis()/1000) - endLevelTimer;
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
        //println(xpos_two);
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
      //player1.close();
      // BACK TO ADVENTURE MENU
      if(lastFingerPosAdv.x > 0 && lastFingerPosAdv.x < 300 && lastFingerPosAdv.y > 0 && lastFingerPosAdv.y < 300 && lastFingerPosAdv.z < -600) {
        gAppState = STATE_ADVENTUREMODEMENU;   
        println("Level 2 --> Adventure Menu");
        //player1.close();
      }
      
  }
  
}
