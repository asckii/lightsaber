class BrushRandom extends BrushBase
{
     BrushRandom(PGraphics p, Point2dArray p2,String n)
  {
    super(p,p2,n);
   
  }
  
  
  
   void drawBrushStroke()
{
  if (mousePressed && (mouseButton ==LEFT)) {


    //println("dans le draw "+key);
    //  - section draw lines
    if (previousX==0 && previousY==0)
    {
      previousX=mouseX;
      previousY=mouseY;
    }
    pg.beginDraw();
     pg.stroke(brushColor);
    pg.strokeWeight(0.5);
    float mrx=mouseX+random(-rayon/5,rayon/5);
    float mry=mouseY+random(-rayon/5,rayon/5);
    
    Point2d pt=new Point2d((int)mrx,(int) mry);
    pg.line( mrx, mry, previousX, previousY);
    pg.endDraw();

    pointsArray.add(pt);  

    previousX=mrx;
    previousY=mry;
  }
  else
  {
    previousX=0;
    previousY=0;
  }
} 
  
  
  
  
  
   void draw()
  {
      if(idle)
    {
      return;
    }
   super.draw();
  drawBrushStroke();
  recordStroke();
  }



}

