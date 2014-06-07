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

void record(BrushBase usedbrush,int f,int x,int y,int px, int py,float p,int t, boolean m,boolean cleared)
{
  StrokeStep strokeStep=new StrokeStep(usedbrush,f, x, y,px,py,p,t,m,cleared);
  strokeStepList.add(strokeStep);
}

void execute(){
  
  if (!strokeStepList.isEmpty() )
  {
  
    
    
    for(StrokeStep strokeStep: strokeStepList){
      
        brush=strokeStep.getBrush();;
        
         if(strokeStep.getIsCleared()){
          brush.commandClear();
        }  
        else 
        {
          
          
          
        
        
       if(strokeStep.getIsMirrored())
         {
           
            println("deux opérations");
            int xop1=strokeStep.getX();
            int yop1=strokeStep.getY();
            int xopp1=strokeStep.getpX();
            int yopp1=strokeStep.getpY();
            float op1Pressure=strokeStep.getPressure();
            int op1Transparency=strokeStep.getTransparency();
            boolean op1Mirrored=strokeStep.getIsMirrored();
            boolean op1Iscleared=strokeStep.getIsCleared();
              brush.setPreviousPoints(xopp1,yopp1);
         drawBrushStroke(brush,xop1,yop1,xopp1,yopp1,op1Pressure,op1Transparency,op1Mirrored,op1Iscleared); 
            
           int xop2=strokeStep.getX();
            int yop2=strokeStep.getY();
             int xopp2=strokeStep.getpX();
            int yopp2=strokeStep.getpY();
             float op2Pressure=strokeStep.getPressure();
            int op2Transparency=strokeStep.getTransparency();
            boolean op2Mirrored=strokeStep.getIsMirrored();
            boolean op2Iscleared=strokeStep.getIsCleared();
            brush.setPreviousPoints(xopp2,yopp2);
         postDrawOperation(brush,xop2,yop2,xopp2,yopp2,op2Pressure,op2Transparency,op2Mirrored,op2Iscleared); 
         
         }
         else
         {
           println("une seule opération");
         drawBrushStroke(brush,strokeStep.getX(),strokeStep.getY(),strokeStep.getpX(),strokeStep.getpY(),strokeStep.getPressure(),strokeStep.getTransparency(),strokeStep.getIsMirrored(),strokeStep.getIsCleared()); 
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

 void drawBrushStroke(BrushBase usedbrush,int x,int y,int px, int py, float p,int t, boolean m, boolean cleared){
  
  brush.drawBrushStroke(usedbrush,x,y,px,py,p,t,m,cleared);
   
 
}
 void postDrawOperation(BrushBase usedbrush,int x,int y,int px, int py, float p,int t, boolean m,boolean cleared){
       
  brush.postDrawOperation(usedbrush,x,y,px,py,p,t,m,cleared);
 
} 


void draw()
  {
     pg.beginDraw();
       
      pg.rect (50,80,50,50);
      pg.endDraw();
      
     println("stroke draw");
      
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
