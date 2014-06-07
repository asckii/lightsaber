class BrushLink extends BrushBase
{

   BrushLink(Object parent,PGraphics p, Point2dArray p2,String n)
  {
    super(parent,p,p2,n);
    makeLinkFlag=true;
  }
  
  void makeLink(int mX,int mY,int pX, int pY, float p)
  {
    if (makeLinkFlag)
    {
      if (pointsArray.size()>0  )
      {
        Point2d   tmpPt;
        Point2d pt=new Point2d(mX, mY);
        int step;
        if (rayon<50)
        {
          step=1;
        }
        else
        {
          step=6;
        }
        for (int i=0;i<pointsArray.size();i=i+step)
        {

          tmpPt= (Point2d) pointsArray.get(i);

          if (pt.distance(tmpPt)<rayon)
          {
            pg.beginDraw();
            pg.stroke(brushColor,transparency);
            pg.strokeWeight(0.25);
            pg.line((float)pt.getX(), (float)pt.getY(), (float)tmpPt.getX(), (float)tmpPt.getY());
            pg.endDraw();
          }
        }
      }
    }
  }

  void drawBrushStroke(StrokeStep strokeStep)
  {
    int mx=strokeStep.getX();
    int my=strokeStep.getY();
    int px=strokeStep.getpX();
    int py=strokeStep.getpY(); 
    float strokePressure=strokeStep.getPressure();
    int strokeTransparency=strokeStep.getTransparency();
    
    makeLink(mx, my, px, py, pressure);;
    
   
       if (previousX==0 && previousY==0)
    {
    previousX=px;
   previousY=py;
    }
      pg.fill(153);
   
      pg.stroke(brushColor,transparency);
     
      Point2d pt=new Point2d(mx, my);
      pg.strokeWeight(0.5);
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
