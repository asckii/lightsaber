import codeanticode.tablet.*;


class BrushJpen extends BrushBase

{
  Tablet tablet;
     BrushJpen(PGraphics p, Point2dArray p2,String n,Tablet t)
  {
    super(p,p2,n);
   tablet=t;
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
      showRadiusGizmo();
    if(idle)
    {
      return;
    }
    if (mousePressed && (mouseButton ==LEFT)) {
   
     
     super.draw();
    pg.beginDraw();
    pg.strokeWeight(int(rayon * tablet.getPressure()));
    pg.line(pmouseX, pmouseY, mouseX, mouseY);
        
    pg.endDraw();

   
    }
    showRadiusGizmo();
   
  }


}

