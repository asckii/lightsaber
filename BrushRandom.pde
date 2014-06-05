class BrushRandom extends BrushBase
{
     BrushRandom(Object parent,PGraphics p, Point2dArray p2,String n)
  {
    super(parent,p,p2,n);
   
  }
  
  
  
  void drawBrushStroke(int mX,int mY,int pX, int pY, float p) 
{
  
    
    if (previousX==0 && previousY==0)
    {
      previousX=mX;
      previousY=mY;
    }
    pg.beginDraw();
     pg.stroke(brushColor,transparency);
    pg.strokeWeight(0.5);
    float mrx=mX+random(-rayon/5,rayon/5);
    float mry=mY+random(-rayon/5,rayon/5);
    
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
   
    if (mousePressed && (mouseButton ==LEFT)) {
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

