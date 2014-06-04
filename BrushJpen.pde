import codeanticode.tablet.*;


class BrushJpen extends BrushBase

{
   BrushJpen(Object parent,PGraphics p, Point2dArray p2,String n)
  {
    super(parent,p,p2,n);
  
  }
  
  
  

  
  
  
  
  void draw()
  {
     
    if(idle)
    {
      return;
    }
     super.draw();
    if (mousePressed && (mouseButton ==LEFT)) {
   
     
    
    pg.beginDraw();
    pg.stroke(brushColor,transparency);
    pg.strokeWeight(int(rayon * tablet.getPressure()));
    pg.line(pmouseX, pmouseY, mouseX, mouseY);
        
    pg.endDraw();
    recordStroke();
   
    }
    showRadiusGizmo();
   
  }


}

