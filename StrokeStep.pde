class StrokeStep
{

  int frame;
  int x, y, px, py;
  float pressure;
  BrushBase brush;
  int transparency;
  boolean isMirrored;
  boolean isCleared;
  int rayon;
  BrushBase usedbrush;
   color brushColor;
  StrokeStep(BrushBase usedbrush, int f, int x, int y, int x2, int y2, float p, int t,int ray,color bcolor, boolean m, boolean cl)
  { 

    frame=f;
    this.x=x;
    this.y=y;
    this.px=x;
    this.py=y;
    this.pressure=p;
    this.transparency=t;
    this.isMirrored=m;
    this.isCleared=cl;
    this.brush=usedbrush;
    this.rayon=ray;
    this.brushColor=bcolor;
  }
  
  void setBrushColor(color  c)
  {
  brushColor=c;
  }



  int  getBrushColor()
  {
    return brushColor;
  }
  
void setRayon(int i)
  {
    rayon=i;
  }



  int  getRayon()
  {
    return rayon;
  }


  void setBrush(BrushBase b)
  {
    brush=b;
  }



  BrushBase  getBrush()
  {
    return brush;
  }



  void setFrame(int i)
  {
    frame=i;
  }

  int  getFrame()
  {
    return frame;
  }





  void setIsCleared(boolean b)
  {
    isCleared=b;
  }

  boolean  getIsCleared()
  {
    return isCleared;
  }





  void setIsMirrored(boolean b)
  {
    isMirrored=b;
  }

  boolean  getIsMirrored()
  {
    return isMirrored;
  }


  void setTransparency(int f)
  {
    transparency=f;
  }

  int  getTransparency()
  {
    return transparency;
  }


  void setPressure(float f)
  {
    pressure=f;
  }

  float  getPressure()
  {
    return pressure;
  }

  void setX(int i)
  {
    x=i;
  }

  void setY(int i)
  {
    y=i;
  }


  int getX()
  {
    return x;
  }

  int getY()
  {
    return y;
  }



  void setpX(int i)
  {
    x=i;
  }

  void setpY(int i)
  {
    y=i;
  }


  int getpX()
  {
    return x;
  }

  int getpY()
  {
    return y;
  }


  String toString()
  {
    return "{'frame':"+frame+",'x':"+this.getX()+",'y':"+this.getY()+",'px':"+this.getpX()+",'py':"+this.getpY()+"}";
  }
}

