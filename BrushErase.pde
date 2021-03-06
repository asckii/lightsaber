class BrushErase extends BrushBase
{
  BrushErase(Object parent, PGraphics p, Point2dArray p2, String n)
  {
    super(parent, p, p2, n);
  }


  void customDraw(StrokeStep strokeStep, float tmpPreviousX, float tmpPreviousY)
  {
    int mx=strokeStep.getX();
    int my=strokeStep.getY();
    int px=strokeStep.getpX();
    int py=strokeStep.getpY(); 
    int strokeRayon=strokeStep.getRayon();
    float strokePressure=strokeStep.getPressure();
    int strokeTransparency=strokeStep.getTransparency();
    color  strokeBrushColor=strokeStep.getBrushColor();
    brushColor=strokeBrushColor;
     rayon=strokeRayon;
     
    noFill(); 
    stroke(0, 255, 0);
   // ellipse(mx, my, rayon, rayon);
    eraseFunction(mx, my);
  } 


  void eraseFunction(int mX, int mY) {
    PGraphics canvas=pg;

    color c = color(0, 0);
    canvas.beginDraw();
    canvas.loadPixels();
    for (int x=0; x<canvas.width; x++) {
      for (int y=0; y<canvas.height; y++ ) {
        float distance = dist(x, y, mX, mY);
        if (distance <= rayon/2) {
          int loc = x + y*canvas.width;
          canvas.pixels[loc] = c;
        }
      }
    }
    eraseInArray(mX, mY);
    canvas.updatePixels();
    canvas.endDraw();
  }


  void eraseInArray(int mX, int mY) {
    int step;
    if (rayon<50)
    {
      step=1;
    } else
    {
      step=6;
    }
    Point2d ptm=new Point2d(mX, mY);
    Point2d tmpPt;
    for (int i=0; i<pointsArray.size (); i=i+step)
    {

      tmpPt= (Point2d) pointsArray.get(i);

      if (ptm.distance(tmpPt)<rayon)
      {
        pointsArray.remove(i);
      }
    }
  }

  void draw()
  {
    if (idle)
    {
      return;
    }


    super.draw();
  }
}

