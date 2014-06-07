class StrokeStep
{
 
  int frame;
  int x,y,px,py;
  float pressure;
  BrushBase brush;
  int transparency;
  boolean isMirrored;
  
StrokeStep(int f,int x,int y,int x2, int y2, float p,int t,boolean m)
{ 

  frame=f;
  this.x=x;
  this.y=y;
  this.px=x;
  this.py=y;
  this.pressure=p;
  this.transparency=t;
  this.isMirrored=m;
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
