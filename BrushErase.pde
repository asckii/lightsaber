class BrushErase extends BrushBase
{
     BrushErase(PGraphics p, Point2dArray p2,String n)
  {
    super(p,p2,n);
   
  }
   
  
 void drawBrushStroke()
{
  if (mousePressed && (mouseButton ==LEFT)) {
    
    noFill(); stroke(0,255,0);
    ellipse(mouseX,mouseY,rayon,rayon);
    eraseFunction();
    
  }
 
 
} 
  
  void draw()
  {
      if(idle)
    {
      return;
    }
    drawBrushStroke();
   super.draw();
  
showRadiusGizmo();
  }
  
  
     void eraseFunction() {
      PGraphics canvas=pg;
      
      color c = color(0,0);
      canvas.beginDraw();
      canvas.loadPixels();
      for (int x=0; x<canvas.width; x++) {
        for (int y=0; y<canvas.height; y++ ) {
          float distance = dist(x,y,mouseX,mouseY);
          if (distance <= rayon/2) {
            int loc = x + y*canvas.width;
            canvas.pixels[loc] = c;
          }
        }
      }
      eraseInArray();
      canvas.updatePixels();
      canvas.endDraw();
    }
  
  
  void eraseInArray(){
      int step;
    if (rayon<50)
        {
          step=1;
        }
        else
        {
          step=6;
        }
  Point2d ptm=new Point2d(mouseX,mouseY);
  Point2d tmpPt;
    for (int i=0;i<pointsArray.size();i=i+step)
        {

          tmpPt= (Point2d) pointsArray.get(i);

          if (ptm.distance(tmpPt)<rayon)
          {
            pointsArray.remove(i);
          }
        }  
  }
  

}

/*
// transition vers alpha
float amt = 0.5;
int colorWithZeroAlpha = initialColor - color(0,0,0,255);
int newColor = lerpColor( initialColor, colorWithZeroAlpha, amt );
*/
