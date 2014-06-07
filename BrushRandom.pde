class BrushRandom extends BrushBase
{
     BrushRandom(Object parent,PGraphics p, Point2dArray p2,String n)
  {
    super(parent,p,p2,n);
   
  }
  
  
  
  void drawBrushStroke(BrushBase usedbrush,int mX,int mY,int pX, int pY,float vpressure,int t,boolean m,boolean clear)
{
  
    
    if (previousX==0 && previousY==0)
    {
      previousX=pX;
      previousY=pY;
    }
    pg.beginDraw();
    pg.stroke(brushColor,transparency);
    pg.strokeWeight(0.5);
    float mrx=mX+random(-rayon/5,rayon/5);
    float mry=mY+random(-rayon/5,rayon/5);
    
    Point2d pt=new Point2d((int)mrx,(int) mry);
    pg.line( mrx, mry, pX, pY);
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

