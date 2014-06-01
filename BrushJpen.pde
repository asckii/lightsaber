import codeanticode.tablet.*;


class BrushJpen extends BrushBase

{
  Tablet tablet;
     BrushJpen(PGraphics p, Point2dArray p2,String n,Tablet t)
  {
    super(p,p2,n);
   tablet=t;
  }
  
  
  

  
  
  
  
  void draw()
  {
      showRadiusGizmo();
    if(idle)
    {
      return;
    }
     super.draw();
    if (mousePressed && (mouseButton ==LEFT)) {
   
     
    
    pg.beginDraw();
    pg.strokeWeight(int(rayon * tablet.getPressure()));
    pg.line(pmouseX, pmouseY, mouseX, mouseY);
        
    pg.endDraw();

   
    }
    showRadiusGizmo();
   
  }


}

