import codeanticode.tablet.*;

class BrushMotif extends BrushBase
{
  
  int angle=0;
  int w,h;
     BrushMotif(Object parent,PGraphics p, Point2dArray p2,String n)
  {
    super(parent,p,p2,n);
    initImage("motif4.png");
    
    
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


   
 
    
    pg.beginDraw();
   
   float distance=map(dist(mouseX, mouseY, pmouseX, pmouseY),0,50,9,15);
  for (int i = 0; i <= (int)distance; i++) {
  float x = lerp(pmouseX,mouseX, i/ distance);
  float y = lerp(pmouseY, mouseY, i/distance);
println(tablet.getPressure());
  
  int tmpRayon=int(lerp(prayon,rayon,i/distance) * tablet.getPressure());
  pg.tint(brushColor,transparency);//);//map( tablet.getPressure()*100,0,255,0,255)
  pg.image(img,x-tmpRayon/2,y-tmpRayon/2,tmpRayon,tmpRayon);
  }
 
    
    pg.endDraw();
prayon=rayon;
ppressure=tablet.getPressure();
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

