class StrokeStep
{
 
  int frame;
  int x,y,px,py;
  BrushBase brush;
  
StrokeStep(int f,int x,int y,int x2, int y2)
{ 

  frame=f;
  this.x=x;
  this.y=y;
  this.px=x;
  this.py=y;
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
