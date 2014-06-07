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

void record(int f,int x,int y,int px, int py,float p,int t, boolean m,boolean cleared)
{
  StrokeStep strokeStep=new StrokeStep(f, x, y,px,py,p,t,m,cleared);
  strokeStepList.add(strokeStep);
}

void execute(){
  
  if (!strokeStepList.isEmpty() )
  {
  
    
    
    for(StrokeStep strokeStep: strokeStepList){
      
         if(strokeStep.getIsCleared()){
          brush.commandClear();
        }  else {
         drawBrushStroke(strokeStep.getX(),strokeStep.getY(),strokeStep.getpX(),strokeStep.getpY(),strokeStep.getPressure(),strokeStep.getTransparency(),strokeStep.getIsMirrored(),strokeStep.getIsCleared()); 
        
       if(strokeStep.getIsMirrored())
         {
         postDrawOperation(strokeStep.getX(),strokeStep.getY(),strokeStep.getpX(),strokeStep.getpY(),strokeStep.getPressure(),strokeStep.getTransparency(),strokeStep.getIsMirrored(),strokeStep.getIsCleared()); 
         }
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

 void drawBrushStroke(int x,int y,int px, int py, float p,int t, boolean m, boolean cleared){
  
  brush.drawBrushStroke(x,y,px,py,p,t,m,cleared);
   
 
}
 void postDrawOperation(int x,int y,int px, int py, float p,int t, boolean m,boolean cleared){
       
  brush.postDrawOperation(x,y,px,py,p,t,m,cleared);
 
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
