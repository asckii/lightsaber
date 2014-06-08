class BrushSimple extends BrushBase
{
  BrushSimple(Object parent, PGraphics p, Point2dArray p2, String n)
  {
    super(parent, p, p2, n);
    rayon=1;
  }



  void customDraw(StrokeStep strokeStep, float tmpPreviousX, float tmpPreviousY)
  {

    int mx=strokeStep.getX();
    int my=strokeStep.getY();
    int px=strokeStep.getpX();
    int py=strokeStep.getpY(); 
    float pressure=strokeStep.getPressure();
    int transparency=strokeStep.getTransparency();





    pg.beginDraw();
    Point2d pt=new Point2d(mx, my);
    pg.stroke(brushColor);
    pg.strokeWeight(rayon); 
    pg.line( mx, my, tmpPreviousX, tmpPreviousY);
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

