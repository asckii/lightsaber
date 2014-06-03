class StrokeStep
{
 
  int frame;
  int x,y;
  
StrokeStep(int f,int x,int y)
{ 

  frame=f;
  this.x=x;
  this.y=y;
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

String toString()
{
 return "{'frame':"+frame+",'x':"+this.getX()+",'y':"+this.getY()+"}";
}
          


}
