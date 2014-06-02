class BrushSimple extends BrushBase
{
     BrushSimple(PGraphics p, Point2dArray p2,String n)
  {
    super(p,p2,n);
   
  }
  
  
  
   void drawBrushStroke()
{
  if (mouseButton ==LEFT) {


    println("dans le draw "+key);
    //  - section draw lines
    if (previousX==0 && previousY==0)
    {
      previousX=mouseX;
      previousY=mouseY;
    }
    
    pg.beginDraw();
    Point2d pt=new Point2d(mouseX, mouseY);
      pg.stroke(brushColor);
    pg.strokeWeight(rayon);
    pg.line( mouseX, mouseY, previousX, previousY);
    pg.endDraw();

    pointsArray.add(pt);  

    previousX=mouseX;
    previousY=mouseY;
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

