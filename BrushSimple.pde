class BrushSimple extends BrushBase
{
     BrushSimple(Object parent,PGraphics p, Point2dArray p2,String n)
  {
    super(parent,p,p2,n);
   rayon=1;
  }
  
  
  
   void drawBrushStroke(int mX,int mY,int pX, int pY, float p)
{

    //  - section draw lines
      if (previousX==0 && previousY==0)
    {
    previousX=pX;
    previousY=pY;
    }
    
    
    pg.beginDraw();
    Point2d pt=new Point2d(mX, mY);
      pg.stroke(brushColor);
    pg.strokeWeight(rayon);
    pg.line( mX, mY, previousX, previousY);
    pg.endDraw();

    pointsArray.add(pt);  

    previousX=mX;
    previousY=mY;
 
} 
  

  void draw()
  {
    
    if(idle)
    {
      return;
    }
   super.draw();
   
   if (mouseButton ==LEFT) {
      drawBrushStroke(mouseX,mouseY,pmouseX,pmouseY,tablet.getPressure());
       recordStroke();

    }
  else
  {
    previousX=0;
    previousY=0;
  }
   
 
  }


}

