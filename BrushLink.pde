class BrushLink extends BrushBase
{

   BrushLink(PGraphics p, Point2dArray p2,String n)
  {
    super(p,p2,n);
    makeLinkFlag=true;
  }
  
  void makeLink()
  {
    if (makeLinkFlag)
    {
      if (pointsArray.size()>0 && (mousePressed && mouseButton == LEFT) )
      {
       /* fill(#ff0000, 20);
        stroke(#ff0000, 50);
        ellipse(mouseX, mouseY, rayon, rayon);*/
        // affichage des  points
        Point2d   tmpPt;
        Point2d pt=new Point2d(mouseX, mouseY);
        int step;
        if (rayon<50)
        {
          step=1;
        }
        else
        {
          step=6;
        }
        for (int i=0;i<pointsArray.size();i=i+step)
        {

          tmpPt= (Point2d) pointsArray.get(i);

          if (pt.distance(tmpPt)<rayon)
          {
            pg.beginDraw();
            pg.stroke(brushColor);
            pg.strokeWeight(0.25);
            pg.line((float)pt.getX(), (float)pt.getY(), (float)tmpPt.getX(), (float)tmpPt.getY());
            pg.endDraw();
          }
        }
      }
    }
  }




  /*void keyPressed() {
   
    switch(keyCode)
    {
    case 32:
      if (makeLinkFlag)
      {
        makeLinkFlag=false;
      }
      else
      {
        makeLinkFlag=true;
      }
      break;
  
    
     case 38://haut
    if (rayon<200)
    {
     
      rayon =rayon+1;
    }
    break;

  case 40://haut
    if (rayon<200)
    {
   
      rayon =rayon-1;
    }
    break;
    
      }
  }*/



void draw()
{
    if(idle)
    {
      return;
    }
  super.draw();
  makeLink();
  drawBrushStroke();
  recordStroke();
}

}
