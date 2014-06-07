import codeanticode.tablet.*;


class BrushJpen extends BrushBase

{
   BrushJpen(Object parent,PGraphics p, Point2dArray p2,String n)
  {
    super(parent,p,p2,n);
  
  }
  
  
 void drawBrushStroke(StrokeStep strokeStep)
  {
    int mx=strokeStep.getX();
    int my=strokeStep.getY();
    int px=strokeStep.getpX();
    int py=strokeStep.getpY(); 
    float strokePressure=strokeStep.getPressure();
    int strokeTransparency=strokeStep.getTransparency();

    if (previousX==0 && previousY==0)
    {
      //  la brosse a été levée au paravant alors previousx et previousy ont été remis à 0
      // on récupère les dernières positions connues du pinceau
    previousX=px;
    previousY=py;
    }
    
    
    pg.beginDraw();
    pg.stroke(brushColor,strokeTransparency);
    pg.strokeWeight(int(rayon *strokePressure));
    pg.line( mx, my, previousX, previousY);  
    pg.endDraw();
    
    // tant qu'on appuie sur le bouton droit, on conserve les ancienes positions
    previousX=mx;
    previousY=my;
    
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

