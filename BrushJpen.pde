import codeanticode.tablet.*;


class BrushJpen extends BrushBase

{
  BrushJpen(Object parent, PGraphics p, Point2dArray p2, String n)
  {
    super(parent, p, p2, n);
  }


  void customDraw(StrokeStep strokeStep, float tmpPreviousX, float tmpPreviousY)
  {
    // println("drawBrushStroke isPostDrawOperation "+isPostDrawOperation);
    int mx=strokeStep.getX();
    int my=strokeStep.getY();
    int px=strokeStep.getpX();
    int py=strokeStep.getpY(); 

    float strokePressure=strokeStep.getPressure();
    int strokeTransparency=strokeStep.getTransparency();
    // float tmpPreviousX=0; float tmpPreviousY=0;


    pg.beginDraw();
    pg.stroke(brushColor, strokeTransparency);
    pg.strokeWeight(int(rayon *strokePressure));
    pg.line( mx, my, tmpPreviousX, tmpPreviousY);  
    pg.endDraw();
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

