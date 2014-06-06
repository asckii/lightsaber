import codeanticode.tablet.*;


class BrushJpen extends BrushBase

{
   BrushJpen(Object parent,PGraphics p, Point2dArray p2,String n)
  {
    super(parent,p,p2,n);
  
  }
  
  
 void drawBrushStroke(int mX,int mY,int pX, int pY,float vpressure)
  {
    
  if (previousX==0 && previousY==0)
    {
    previousX=pX;
   previousY=pY;
    }
    
    
    pg.beginDraw();
    pg.smooth();
    pg.stroke(brushColor,transparency);
    pg.strokeWeight(int(rayon *vpressure));
    pg.line(mX, mY,previousX, previousY );  
    pg.endDraw();
    
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
   
     if (mousePressed && (mouseButton ==LEFT)) {
      drawBrushStroke(mouseX,mouseY,pmouseX,pmouseY,tablet.getPressure());
     
     previousX=0;
     previousY=0;
     WIDTH=1000;HEIGHT=600;
     int midleX=WIDTH/2;int midleY=HEIGHT/2;
    int mmx=(2*midleX)-mouseX;int pmmx=(2*midleX)-pmouseX;
     drawBrushStroke(mmx,mouseY,pmmx,pmouseY,tablet.getPressure());
     
     recordStroke();
     }
    
   
  }

}

