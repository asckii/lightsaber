class Stroke
{

ArrayList<StrokeStep> strokeList;
  BrushBase brush;
  int previousX;
int previousY;
int mX;
int mY;

Stroke(BrushBase b)
{
  strokeList=new ArrayList<StrokeStep>();
  brush=b;
}

void record(int f,int x,int y,int px, int py,float p)
{
  StrokeStep strokeStep=new StrokeStep(f, x, y,px,py,p);
  strokeList.add(strokeStep);
}

void execute(){
  
    if (!strokeList.isEmpty())
  {
    for(StrokeStep strokeStep: strokeList){
     drawBrushStroke(strokeStep.getX(),strokeStep.getY(),strokeStep.getpX(),strokeStep.getpY(),strokeStep.getPressure());
    }
  } 
}

int getSize()
{
  return strokeList.size();
}


 void drawBrushStroke(int x,int y,int px, int py, float p)
{
  brush.drawBrushStroke(x,y,px,py,p);
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
