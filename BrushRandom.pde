class BrushRandom extends BrushBase
{
     BrushRandom(Object parent,PGraphics p, Point2dArray p2,String n)
  {
    super(parent,p,p2,n);
   
  }
  
  
  
  void drawBrushStroke(StrokeStep strokeStep)
{
  
    int mx=strokeStep.getX();
    int my=strokeStep.getY();
    int px=strokeStep.getpX();
    int py=strokeStep.getpY(); 
    float pressure=strokeStep.getPressure();
    int transparency=strokeStep.getTransparency();
    
    if (previousX==0 && previousY==0)
    {
      previousX=px;
      previousY=py;
    }
    
    pg.beginDraw();
    pg.stroke(brushColor,transparency);
    pg.strokeWeight(0.5);
    float mrx=mx+random(-rayon/5,rayon/5);
    float mry=my+random(-rayon/5,rayon/5);
    
    Point2d pt=new Point2d((int)mrx,(int) mry);
    pg.line( mrx, mry, previousX, previousY);
    pg.endDraw();

    pointsArray.add(pt);  

    previousX=mrx;
    previousY=mry;
  
  
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

