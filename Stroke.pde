class Stroke
{

ArrayList<StrokeStep> strokeList;
  BrushBase brush;
Stroke(BrushBase b)
{
  strokeList=new ArrayList<StrokeStep>();
  brush=b;
}

void record(int f,int x,int y,int px, int py)
{
  StrokeStep strokeStep=new StrokeStep(f, x, y,px,py);
  strokeList.add(strokeStep);
}

void execute(){
  
    if (!strokeList.isEmpty())
  {
    for(StrokeStep strokeStep: strokeList){
    
     drawBrushStroke(strokeStep.getX(),strokeStep.getY(),strokeStep.getpX(),strokeStep.getpY());
    }
  } 
}

int previousX;
int previousY;
int mX;
int mY;

 void drawBrushStroke(int x,int y,int px, int py)
{
  brush.drawBrushStroke(x,y,px,py);

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
