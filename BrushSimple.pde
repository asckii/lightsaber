class BrushSimple extends BrushBase
{
     BrushSimple(Object parent,PGraphics p, Point2dArray p2,String n)
  {
    super(parent,p,p2,n);
   rayon=1;
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
    Point2d pt=new Point2d(mx, my);
    pg.stroke(brushColor);
    pg.strokeWeight(rayon); 
    pg.line( mx, my, previousX, previousY);
    pg.endDraw();

    pointsArray.add(pt);  

    previousX=mx;
    previousY=my;
 
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

