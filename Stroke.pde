class Stroke
{

ArrayList<StrokeStep> strokeStepList;
  BrushBase brush;
  int previousX;
int previousY;
int mX;
int mY;

Stroke(BrushBase b,PGraphics pg)
{
  strokeStepList=new ArrayList<StrokeStep>();
  brush=b;
}

void record(int f,int x,int y,int px, int py,float p,int t, boolean m)
{
  StrokeStep strokeStep=new StrokeStep(f, x, y,px,py,p,t,m);
  strokeStepList.add(strokeStep);
}

void execute(){
  
  if (!strokeStepList.isEmpty() )
  {
    //println("strokestepList : "+strokeStepList.size());
    for(StrokeStep strokeStep: strokeStepList){
     drawBrushStroke(strokeStep.getX(),strokeStep.getY(),strokeStep.getpX(),strokeStep.getpY(),strokeStep.getPressure(),strokeStep.getTransparency(),strokeStep.getIsMirrored()); 
    
   if(strokeStep.getIsMirrored())
     {
     postDrawOperation(strokeStep.getX(),strokeStep.getY(),strokeStep.getpX(),strokeStep.getpY(),strokeStep.getPressure(),strokeStep.getTransparency(),strokeStep.getIsMirrored()); 
     }
   }
   
    
     
  }
  
}

List<StrokeStep> getList()
{
   return strokeStepList;
}

int getSize()
{
  return strokeStepList.size();
}

 void drawBrushStroke(int x,int y,int px, int py, float p,int t, boolean m)
{
  
  brush.drawBrushStroke(x,y,px,py,p,t,m);
   
 
}
 void postDrawOperation(int x,int y,int px, int py, float p,int t, boolean m)
{
  
  
      
  brush.postDrawOperation(x,y,px,py,p,t,m);
 
    
} 


void draw()
  {
     pg.beginDraw();
       
      pg.rect (50,80,50,50);
      pg.endDraw();
      
  }

String toString()
{
  String listStrokes="";
  if (!strokeStepList.isEmpty())
  {
    for(StrokeStep object: strokeStepList){
    listStrokes=listStrokes+object.toString();
    }
  } 
  return listStrokes;
}



}
