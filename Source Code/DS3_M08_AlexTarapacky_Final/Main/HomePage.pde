class HomePage {

  HomePage(){
  }

  public void render() {
    
    image(homePageBG, 0, 0);
    image(pawCursor, lastFingerPos.x, lastFingerPos.y, 50, 50);

    ArrayList<Finger> fingerList = leap.getFingerList();
    if (fingerList.size() > 0) {
      PVector fingerPos = leap.getTip(fingerList.get(0));

      /**************************************************
                        BUTTON PRESS
      ***************************************************/

      if (fingerPos.z < -700) {
        println("BUTTON PRESS: " + fingerPos.z);
 
        // ART MODE
        if (lastFingerPos.x > 274 && lastFingerPos.x < 804 && lastFingerPos.y > 232 && lastFingerPos.y < 310) {
           gAppState = STATE_ARTMODE;
           println("CLICK 4 Art Mode");
        }
        // CREDITS
        else if (lastFingerPos.x > 274 && lastFingerPos.x < 804 && lastFingerPos.y > 518 && lastFingerPos.y < 600) {
          gAppState = STATE_CREDITS;
          println("Credits");
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

//void mousePressed() {
//  if(mouseX > 274 && mouseX < 804 && mouseY > 232 && mouseY < 310) {
//    println("Art Mode");
//    art.render();
//  }
//  if(mouseX > 274 && mouseX < 804 && mouseY > 323 && mouseY < 408) {
//    println("Adventure Mode");
//  }
//  if(mouseX > 274 && mouseX < 804 && mouseY > 422 && mouseY < 506) {
//    println("Tutorial");
//  }
//  if(mouseX > 274 && mouseX < 804 && mouseY > 518 && mouseY < 600) {
//    println("Credits");
//  }
//}
