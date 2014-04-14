class Tutorial {

  Tutorial(){
  }

  public void render() {
    
    tutorialBG.display(0, 0);
    image(pawCursor, lastFingerPos.x, lastFingerPos.y, 50, 50);

    ArrayList<Finger> fingerList = leap.getFingerList();
    if (fingerList.size() > 0) {
      PVector fingerPos = leap.getTip(fingerList.get(0));

      /**************************************************
                        BUTTON PRESS
      ***************************************************/
      
      if (fingerPos.z < -700) {
        println("BUTTON PRESS: " + fingerPos.z);
        // BACK TO HOME
        if (lastFingerPos.x > 0 && lastFingerPos.x < 201 && lastFingerPos.y > 0 && lastFingerPos.y < 150) {
            gAppState = STATE_HOMEPAGE;  
            println("Tutorial --> Home");
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
