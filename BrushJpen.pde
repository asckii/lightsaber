import codeanticode.tablet.*;


class BrushJpen extends BrushBase

{
   BrushJpen(Object parent,PGraphics p, Point2dArray p2,String n)
  {
    super(parent,p,p2,n);
  
  }
  
  
 void drawBrushStroke(StrokeStep strokeStep)
  {
   // println("drawBrushStroke isPostDrawOperation "+isPostDrawOperation);
    int mx=strokeStep.getX();
    int my=strokeStep.getY();
    int px=strokeStep.getpX();
    int py=strokeStep.getpY(); 
    float strokePressure=strokeStep.getPressure();
    int strokeTransparency=strokeStep.getTransparency();

      float tmpPreviousX=0; float tmpPreviousY=0;

  
    
    if (isPostDrawOperation)
    {
      
       if (pdopreviousX==0 && pdopreviousY==0)
    {
      //println("init isPostDrawOperation");
      //  la brosse a été levée au paravant alors previousx et previousy ont été remis à 0
      // on récupère les dernières positions connues du pinceau si on est en mode mirroir
      pdopreviousX=px;
      pdopreviousY=py; 
    }
      
      tmpPreviousX=pdopreviousX;
      tmpPreviousY=pdopreviousY;
    
    }else {
         if (previousX==0 && previousY==0)
      {
        //  println("init normal");
        //  la brosse a été levée au paravant alors previousx et previousy ont été remis à 0
        // on récupère les dernières positions connues du pinceau si on est en mode mirroir
      previousX=px;
      previousY=py;
      }
        
      tmpPreviousX=previousX;
      tmpPreviousY=previousY;
    }
    
   
    
    
    pg.beginDraw();
    pg.stroke(brushColor,strokeTransparency);
    pg.strokeWeight(int(rayon *strokePressure));
    pg.line( mx, my,tmpPreviousX, tmpPreviousY);  
    pg.endDraw();
    
    
    
    if (isPostDrawOperation)
    {
      // tant qu'on appuie sur le bouton droit, on conserve les ancienes positions
      pdopreviousX=mx;
      pdopreviousY=my;   
    } else
    {
      // tant qu'on appuie sur le bouton droit, on conserve les ancienes positions
    previousX=mx;
    previousY=my;
    }
    
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

