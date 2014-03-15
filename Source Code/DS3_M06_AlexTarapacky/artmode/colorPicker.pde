class colorPicker {
  
  int mx, my, mw, mh, mc;
  PImage cpImage;

  public colorPicker ( int x, int y, int w, int h, int c ){
    h = h - 330;
    w = w - 100;
    mx = x + 340;
    my = y;
    mw = w;
    mh = h;
    mc = c + 100;
    cpImage = new PImage(w,h);
    init();
  }

  private void init (){
    // draw color.
    int cw = mw - 35;
    for (int i=0; i<cw; i++) {
      float nColorPercent = i / (float)cw;
      float rad = (-360 * nColorPercent) * (PI / 180);
      int nR = (int)(cos(rad) * 127 + 128) << 16;
      int nG = (int)(cos(rad + 2 * PI / 3) * 127 + 128) << 8;
      int nB = (int)(Math.cos(rad + 4 * PI / 3) * 127 + 128);
      int nColor = nR | nG | nB;
      setGradient( i, 0, 1, mh/2, 0xFFFFFF, nColor );
      setGradient( i, (mh/2), 1, mh/2, nColor, 0x000000 );
    }
    // draw black/white.
    drawRect( cw, 0, 30, mh/2, 0xFFFFFF );
    drawRect( cw, mh/2, 30, mh/2, 0 );
    // draw grey scale.
    for ( int j=0; j<mh; j++ ){
      int g = 255 - (int)(j/(float)(mh-1) * 255 );
      drawRect( mw-40, j, 60, 1, color( g, g, g ) );
    }
  }

  private void setGradient(int x, int y, float w, float h, int c1, int c2){
    float deltaR = red(c2) - red(c1);
    float deltaG = green(c2) - green(c1);
    float deltaB = blue(c2) - blue(c1);
    for (int j = y; j<(y+h); j++){
      int c = color( red(c1)+(j-y)*(deltaR/h), green(c1)+(j-y)*(deltaG/h), blue(c1)+(j-y)*(deltaB/h) );
      cpImage.set( x, j, c );
    }
  }

  private void drawRect(int rx, int ry, int rw, int rh, int rc){
    for (int i=rx; i<rx+rw; i++) {
      for (int j=ry; j<ry+rh; j++) {
        cpImage.set(i, j, rc);
      }
    }
  }

  public void render (){
    image(cpImage, mx, my);
    if ( mousePressed &&
      mouseX >= mx && 
      mouseX < mx + mw &&
      mouseY >= my &&
      mouseY < my + mh ) {
      mc = get( mouseX, mouseY );
    }
    buffer.fill(mc); 
    // selected colour rectangle
    rect(mx+300, my, 40, mh);
  }
  
}

