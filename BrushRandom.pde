class BrushRandom extends BrushBase
{
  BrushRandom(Object parent, PGraphics p, Point2dArray p2, String n)
  {
    super(parent, p, p2, n);
  }



  void customDraw(StrokeStep strokeStep, float tmpPreviousX, float tmpPreviousY)
  {

    int mx=strokeStep.getX();
    int my=strokeStep.getY();
    int px=strokeStep.getpX();
    int py=strokeStep.getpY(); 
    float strokePressure=strokeStep.getPressure();
    int strokeTransparency=strokeStep.getTransparency();
     int strokeRayon=strokeStep.getRayon();
     color strokeBrushColor=strokeStep.getBrushColor();
    brushColor=strokeBrushColor;
    
   rayon=strokeRayon;

    pg.beginDraw();
    pg.stroke(brushColor, strokeTransparency);
    //pg.strokeWeight(0.5);
    pg.strokeWeight(int(rayon/4 *strokePressure));
    float mrx=mx+random(-rayon/2, rayon/2);
    float mry=my+random(-rayon/2, rayon/2);

    Point2d pt=new Point2d((int)mrx, (int) mry);
    pg.line(mx, my, mrx, mry );
    pg.line(mrx, mry, tmpPreviousX, tmpPreviousY);
    pg.endDraw();

    pointsArray.add(pt);
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

