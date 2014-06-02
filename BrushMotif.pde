import codeanticode.tablet.*;

class BrushMotif extends BrushBase
{
  Tablet tablet;
  int angle=0;
  int w,h;
     BrushMotif(PGraphics p, Point2dArray p2,String n,Tablet t)
  {
    super(p,p2,n);
    initImage("motif.png");
    tablet=t;
  }
  
   void initImage(String s)
  {   
    img= loadImage(s);
    w = img.width;
    h = img.height;
  }
  
   void drawBrushStroke()
{
  if (mousePressed && (mouseButton ==LEFT)) {


    //println("dans le draw "+key);
    //  - section draw lines
 
    
    pg.beginDraw();
    //pg.image(img,mouseX-rayon/2,mouseY-rayon/2,rayon,rayon);
   
  for (int i = 0; i <= 10; i++) {
  float x = lerp(pmouseX,mouseX, i/10.0);
  float y = lerp(pmouseY, mouseY, i/10.0);
  int tmpRayon=int(rayon * tablet.getPressure());
 pg.tint(255,0,0,50);
 
  pg.image(img,x-tmpRayon/2,y-tmpRayon/2,tmpRayon,tmpRayon);
  }
 
    
    pg.endDraw();

    //pointsArray.add(pt);  
  }
 
} 
  
  
 void variableEllipse(int x, int y, int px, int py) {
  float speed = abs(x-px) + abs(y-py);
   pg.stroke(brushColor);
  //pg.stroke(speed);
  pg.ellipse(x, y, speed, speed);
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
//showRadiusGizmo();
  }


}

