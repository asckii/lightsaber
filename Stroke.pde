class Stroke
{

ArrayList<StrokeStep> strokeList;
  
Stroke()
{
  strokeList=new ArrayList<StrokeStep>();
}

void record(int f,int x,int y)
{
  
  StrokeStep strokeStep=new StrokeStep(f, x, y);
  strokeList.add(strokeStep);
}

void execute(){
  
    if (!strokeList.isEmpty())
  {
    for(StrokeStep strokeStep: strokeList){
    
     drawBrushStroke(strokeStep.getX(),strokeStep.getY());
    }
  } 
}

int previousX;
int previousY;
int mX;
int mY;

 void drawBrushStroke(int x,int y)
{

    mX=x;
    mY=y;
   
    if (previousX==0 && previousY==0)
    {
      previousX=mX;
      previousY=mY;
    }
    
    pg.beginDraw();
    Point2d pt=new Point2d(mX, mY);
    pg.stroke(color(255,0,0));
    pg.strokeWeight(10);
    pg.line( mX, mY, previousX, previousY);
    pg.endDraw();

    pointsArray.add(pt);  

    previousX=mX;
    previousY=mY;

} 




String toString()
{
  String listStrokes="";
  if (!strokeList.isEmpty())
  {
    for(StrokeStep object: strokeList){
    listStrokes=listStrokes+object.toString();
    }
  } 
  return listStrokes;
}



}
