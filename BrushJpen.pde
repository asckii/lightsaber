import codeanticode.tablet.*;


class BrushJpen extends BrushBase

{
   BrushJpen(Object parent,PGraphics p, Point2dArray p2,String n)
  {
    super(parent,p,p2,n);
  
  }
  
  
 void drawBrushStroke(int mX,int mY,int pX, int pY)
  {
     
   
     
    
    pg.beginDraw();
    pg.stroke(brushColor,transparency);
    pg.strokeWeight(int(rayon * tablet.getPressure()));
    pg.line(pX, pY, mX, mY);
        
    pg.endDraw();
   
   
    
  }
  
  void draw()
  {
     
    if(idle)
    {
      return;
    }
    
     super.draw();
     
     if (mousePressed && (mouseButton ==LEFT)) {
    drawBrushStroke(mouseX,mouseY,pmouseX,pmouseY);
     }
     recordStroke();
   
  }

}

