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
     int strokeRayon=strokeStep.getRayon();
    float strokePressure=strokeStep.getPressure();
    int strokeTransparency=strokeStep.getTransparency();
    color strokeBrushColor=strokeStep.getBrushColor();
    brushColor=strokeBrushColor;
    
     rayon=strokeRayon;

    pg.beginDraw();
    pg.stroke(brushColor, strokeTransparency);
    pg.strokeWeight(int(strokeRayon *strokePressure));
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

