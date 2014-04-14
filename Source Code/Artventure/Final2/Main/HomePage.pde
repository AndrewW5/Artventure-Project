class HomePage {

  HomePage(){
  }

  public void render() {
    
    image(homePageBG, 0, 0);
    archieFlying.display(900, 200);
    playerAnimIdle.display(20, 350);
    image(pawCursor, lastFingerPos.x, lastFingerPos.y, 50, 50);

    ArrayList<Finger> fingerList = leap.getFingerList();
    if (fingerList.size() > 0) {
      PVector fingerPos = leap.getTip(fingerList.get(0));

      /**************************************************
                        BUTTON PRESS
      ***************************************************/

      if (fingerPos.z < -700) {
        println("BUTTON PRESS: " + fingerPos.z);
 
        // ADVENTURE MODE
        if (lastFingerPos.x > 274 && lastFingerPos.x < 804 && lastFingerPos.y > 232 && lastFingerPos.y < 310) {
           gAppState = STATE_ADVENTUREMODEMENU;
           println("Home --> Adventure Menu");
        }
        // ART MENU
        if (lastFingerPos.x > 274 && lastFingerPos.x < 804 && lastFingerPos.y > 323 && lastFingerPos.y < 408) {
           gAppState = STATE_ARTMODE;
           println("Home --> Art Mode");
        }
        // TUTORIAL
        if (lastFingerPos.x > 274 && lastFingerPos.x < 804 && lastFingerPos.y > 422 && lastFingerPos.y < 506) {
           gAppState = STATE_TUTORIAL;
           println("Home --> Tutorial");
        }
        // CREDITS
        else if (lastFingerPos.x > 274 && lastFingerPos.x < 804 && lastFingerPos.y > 518 && lastFingerPos.y < 600) {
          gAppState = STATE_CREDITS;
          println("Home --> Credits");
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
