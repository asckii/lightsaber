class BrushRandom extends BrushBase
{
     BrushRandom(Object parent,PGraphics p, Point2dArray p2,String n)
  {
    super(parent,p,p2,n);
   
  }
  
  
  
  void customDraw(StrokeStep strokeStep,float tmpPreviousX,float tmpPreviousY)
{
  
    int mx=strokeStep.getX();
    int my=strokeStep.getY();
    int px=strokeStep.getpX();
    int py=strokeStep.getpY(); 
    float strokePressure=strokeStep.getPressure();
    int strokeTransparency=strokeStep.getTransparency();
    
   
    
    pg.beginDraw();
    pg.stroke(brushColor,strokeTransparency);
    pg.strokeWeight(0.5);
    float mrx=mx+random(-rayon/5,rayon/5);
    float mry=my+random(-rayon/5,rayon/5);
    
    Point2d pt=new Point2d((int)mrx,(int) mry);
    pg.line( mrx, mry, tmpPreviousX, tmpPreviousY);
    pg.endDraw();

    pointsArray.add(pt);  

  
  
} 
  
  
  
  
  
   void draw()
  {
      if(idle)
    {
      return;
    }
   super.draw();


  }



}

