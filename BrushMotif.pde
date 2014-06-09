import codeanticode.tablet.*;

class BrushMotif extends BrushBase
{

  int angle=0;
  int w, h;
  BrushMotif(Object parent, PGraphics p, Point2dArray p2, String n)
  {
    super(parent, p, p2, n);
    initImage("motif4.png");
  }

  void initImage(String s)
  {   
    img= loadImage(s);
    w = img.width;
    h = img.height;
  }

  void customDraw(StrokeStep strokeStep, float tmpPreviousX, float tmpPreviousY)
  {
    int mx=strokeStep.getX();
    int my=strokeStep.getY();
    int px=strokeStep.getpX();
    int py=strokeStep.getpY(); 
    float strokePressure=strokeStep.getPressure();
    int strokeTransparency=strokeStep.getTransparency();
     int strokeRayon=strokeStep.getRayon();
     color strokeBrushColor=strokeStep.getBrushColor();
     
    brushColor=strokeBrushColor;
     rayon=strokeRayon;


    pg.beginDraw(); 
    pg.smooth();
    float distance=map(dist(mx, my, tmpPreviousX, tmpPreviousY), 0, 50, 9, 15);
    for (int i = 0; i <= (int)distance; i++) {
      float x = lerp(tmpPreviousX, mx, i / distance);
      float y = lerp(tmpPreviousY, my, i / distance);

      int tmpRayon=int(lerp(prayon, rayon, i/distance) *strokePressure);
      pg.tint(brushColor, strokeTransparency);
      pg.image(img, x-tmpRayon/2, y-tmpRayon/2, tmpRayon, tmpRayon);
    }

    pg.endDraw();

    prayon=rayon;
  } 


  void variableEllipse(int x, int y, int px, int py) {
    float speed = abs(x-px) + abs(y-py);
    pg.stroke(brushColor);
    //pg.stroke(speed);
    pg.ellipse(x, y, speed, speed);
  }



  void draw()
  {
    if (idle)
    {
      return;
    }
    super.draw();
  }
}

