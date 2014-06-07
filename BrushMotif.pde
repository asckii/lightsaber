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
  
  void drawBrushStroke(int mX,int mY,int pX, int pY,float vpressure,int t,boolean m,boolean clear)
{
 
   if (previousX==0 && previousY==0)
      {
        previousX=pX;
        previousY=pY;
      }
  
    pg.beginDraw(); 
    pg.smooth();
   float distance=map(dist(mX, mY, previousX, previousY),0,50,9,15);
  for (int i = 0; i <= (int)distance; i++) {
  float x = lerp(previousX,mX, i/ distance);
  float y = lerp(previousY,mY, i/distance);

  
  int tmpRayon=int(lerp(prayon,rayon,i/distance) *vpressure);
  pg.tint(brushColor,transparency);//);//map( tablet.getPressure()*100,0,255,0,255)
  pg.image(img,x-tmpRayon/2,y-tmpRayon/2,tmpRayon,tmpRayon);
  }
 
  pg.endDraw();
  prayon=rayon;
  ppressure=vpressure;
  
   previousX=mX;
   previousY=mY;
 
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
   
  
    
 

  }


}

