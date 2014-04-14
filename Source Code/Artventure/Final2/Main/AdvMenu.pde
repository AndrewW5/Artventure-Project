class AdvMenu {

  AdvMenu(){
  }

  public void render() {
    
    image(advMenuBG, 0, 0);
    image(back, 1000, 0);
    archieFlying.display(750, 230);
    image(pawCursor, lastFingerPos.x, lastFingerPos.y, 50, 50);


    ArrayList<Finger> fingerList = leap.getFingerList();
    if (fingerList.size() > 0) {
      PVector fingerPos = leap.getTip(fingerList.get(0));

      /**************************************************
                        BUTTON PRESS
      ***************************************************/

// y = 326 - 628

      if (fingerPos.z < -700) {
        println("BUTTON PRESS: " + fingerPos.z);
        // BACK TO HOME
       if(lastFingerPos.x > 970 && lastFingerPos.x < 1080 && lastFingerPos.y > 0 && lastFingerPos.y < 150) {
        gAppState = STATE_HOMEPAGE;   
           println("Adventure Menu --> HomePage");
        }
        // LEVEL 1
        if (lastFingerPos.x > 5 && lastFingerPos.x < 266 && lastFingerPos.y > 326 && lastFingerPos.y < 628) {
           gAppState = STATE_ADVENTUREMODEONE;
           println("Adventure Menu --> Level ");
        }
        // LEVEL 2
        if (lastFingerPos.x > 280 && lastFingerPos.x < 533 && lastFingerPos.y > 326 && lastFingerPos.y < 628) {
           gAppState = STATE_ADVENTUREMODETWO;
           println("Adventure Menu --> Level 2");
        }
        // LEVEL 3
        if (lastFingerPos.x > 547 && lastFingerPos.x < 798 && lastFingerPos.y > 326 && lastFingerPos.y < 628) {
           gAppState = STATE_ADVENTUREMODETHREE;
           println("Adventure Menu --> Level 3");
        }
        // LEVEL 4
        if (lastFingerPos.x > 812 && lastFingerPos.x < 1075 && lastFingerPos.y > 326 && lastFingerPos.y < 1075) {
           gAppState = STATE_ADVENTUREMODEFOUR;
           println("Adventure Menu --> Level 4");
        }
      }

      /**************************************************
                    PULL BACK TO POINT
      ***************************************************/

      else if (fingerPos.z >= -300) {
        lastFingerPos = fingerPos;
      }
    }

  }
  
}
