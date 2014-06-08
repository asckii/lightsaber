import codeanticode.tablet.*;
class BrushBase
{
  String name;
  int rayon=20;
  int prayon;
  boolean makeLinkFlag;
  boolean idle;
  
  PGraphics pg;
  boolean makeCircleFlag;
  boolean circleConstructionFlag;
  float previousX, previousY, storedCenterX, storedCenterY,pdopreviousX,pdopreviousY;
 
  int brushSize;
  color brushColor;
  int pFramecount;
  int deltaFramecount;
  float pressure;
  float ppressure;
  float pressureModifier;
  boolean rotateBrush;
  int randomBrush;
  int transparency=255;
 
   Stroke stroke;
  Tablet tablet;
  Object parent;
  boolean isNewStroke=true;
  boolean isXMirrored=false;
  boolean isYMirrored=false;
  boolean playSession=false;
  boolean isCleared=false;
  boolean isPlaying=false;
   int recordCounter=0;
   int incrementStroke=0;
   
   // List<Stroke> strokeList;
   
   
  BrushBase(Object pa,PGraphics p, Point2dArray p2, String n)
  {
    parent=pa;
    tablet= new Tablet((lightsaber)parent); 
    previousX=0;
    previousY=0;
    brushSize=1;
    color c=color(0,0,0,255);
    setBrushColor(c);
    update(p, p2, n);
    idle=false;
     stroke=new Stroke(this,pg);
     UtilsFunctions.strokeList=new ArrayList<Stroke>();
    //redraw();
  }
  

void update(PGraphics p, Point2dArray p2, String n)
{
    pg=p;
    pointsArray=p2;
    name=n;
}

void resetPreviousPoints()
{
    previousX=0;
    previousY=0;
    pdopreviousX=0;
    pdopreviousY=0;
}

void setIsPostDrawOperation(boolean b)
{
  isPostDrawOperation=b;
}

void setPreviousPoints(int x,int y)
{
    previousX=x;
    previousY=y;
}


void IsCleared()
{ 
  println("is cleared");
 
    resetPreviousPoints();
  stroke.record(new StrokeStep(this,0,0,0,0,0,0,0,isXMirrored,true));
}

void commandClear()
{
  pg.beginDraw();
  pg.clear();
  pointsArray=new Point2dArray();
  pg.endDraw();
  image(pg, 0, 0);
}

void setMirrored(boolean b)
{ 
    isXMirrored=b; 
}

boolean getMirrored( )
{  
    return isXMirrored;
}


float getRayon()
{
    return rayon;
}

void setRayon(int r)
{
    rayon=r;
}
  
  
void drawBrushStroke(StrokeStep strokeStep)
{
}
  
  
 
void recordStroke(StrokeStep strokeStep){
          
        
        

      if(isNewStroke){
      UtilsFunctions.strokeList.add(stroke);
      stroke=new Stroke(this,pg);
      isNewStroke=false;
     
     recordCounter++;;
    // println("\n-->creation de stroke "+recordCounter);
      }
      else
      {
      //   print(".");
        stroke.record(strokeStep);
      
      }
      
        // println("recordCounter = "+recordCounter+" - " +frameCount,mouseX,mouseY,pmouseX,pmouseY,tablet.getPressure());
   
    
} 



void playStrokeSession()
{
  playSession=true;
  pointsArray=new Point2dArray();
}


void playStrokeSessionFrame(){
  //println("executeStroke stroke arraylist size "+strokeList.size());
   if (!UtilsFunctions.strokeList.isEmpty())
  {
    print("|");
     
    isPlaying=true;
    if (incrementStroke<UtilsFunctions.strokeList.size()){
      //récuprérer le stroke
     Stroke item=UtilsFunctions.strokeList.get(incrementStroke);
     
     item.execute();
   
    
    }else
    {
      // fin des strokes
      //println("\nfin des strokes");
      playSession=false;
      incrementStroke=0;
       isPlaying=false;
    }
    
    }
  } 


void startStrokeSession(){
  UtilsFunctions.strokeList=new ArrayList<Stroke>();
  recordCounter=0;
}

void executeStroke(){
   if (!UtilsFunctions.strokeList.isEmpty())
  {
    //println("executeStroke stroke arraylist size "+strokeList.get(strokeList.size()-1));
    UtilsFunctions.strokeList.get(UtilsFunctions.strokeList.size()-1).execute();
  }

}

void mouseReleased()
{
 isNewStroke=true;
 //strokeList.add(stroke);
}




  void keyPressed() {
    switch(keyCode)
    {
    case 38://haut
      if (rayon<200)
      {
        println("haut");
        rayon =rayon+1;
      }
      break;

    case 40://haut
      if (rayon<200)
      {
        println("bas");
        rayon =rayon-1;
      }
      if (rayon<1)
      {
        rayon=1;
      }
      break;
    }
  }
  

  boolean isPostDrawOperation=false;
void postDrawOperation(StrokeStep strokeStep)
{
  
if (strokeStep.getIsMirrored())
{

  
     WIDTH=1000;HEIGHT=600;
    int middleX=WIDTH/2;int middleY=HEIGHT/2;
    int mmx=(2*middleX)-strokeStep.getX();int pmmx=(2*middleX)-strokeStep.getpX();
     int mmy=strokeStep.getY();int pmmy=strokeStep.getpY();
    
     drawBrushStroke(new StrokeStep(
     this,strokeStep.getFrame(),
     mmx,
     mmy,
     pmmx,
     pmmy,
     strokeStep.getPressure(),
     strokeStep.getTransparency(),
     strokeStep.getIsMirrored(),
     strokeStep.getIsCleared()
     ));
     
      stroke(#000000, 50);
     ellipse(mmx,mmy,rayon,rayon);
   
}

}
  void draw()
  {
    if(idle)
    { return;   }
    smooth();
     noFill();
     stroke(#000000, 50);
      ellipse(mouseX, mouseY, rayon, rayon);

     showRadiusGizmo();
     pg.beginDraw();
     pg.stroke(brushcolor);
     pg.endDraw();
     
   if (mousePressed )
    {
       ShowDrawingGizmo();
    }
  
  
     if(playSession)
     {
       incrementStroke++;
     playStrokeSessionFrame();
     
     }

       
    if ((mousePressed && (mouseButton ==LEFT))&&isPlaying==false) {
    StrokeStep tmpStroke=new StrokeStep(this,frameCount,mouseX,mouseY,pmouseX,pmouseY,tablet.getPressure(),transparency,isXMirrored,false);
     isPostDrawOperation=false;
     drawBrushStroke(tmpStroke);
     recordStroke(tmpStroke);
     isPostDrawOperation=true;
     postDrawOperation(tmpStroke);
     }
     else
     {
       // mouseup
      previousX=0;
       previousY=0;
       pdopreviousX=0;
      pdopreviousY=0; 
     }

   
  }

 void ShowDrawingGizmo()
{
  fill(#ff0000, 20);
  stroke(#ff0000, 50);
  ellipse(mouseX, mouseY, rayon, rayon);
  
}



  void showRadiusGizmo()
  {

    if (keyCode==38) {
      fill(#ff0000, 20);
      stroke(#ff0000, 20);
      ellipse(mouseX, mouseY, rayon, rayon);
    }
    if (keyCode==40) {  
      fill(#ff0000, 20);
      stroke(#ff0000, 50);
      ellipse(mouseX, mouseY, rayon, rayon);
    }
  }



void setIdle(boolean b)
{
  idle=b;
}

boolean getIdle()
{
return idle;
}
  String getName()
  {
    return name;
  }
  
  color getBrushColor()
  {
   return brushColor;
  }
  
  void setBrushColor(color c)
  {
   brushColor=c;
  }
  
void setTransparency(int i)
{
  transparency=i;
}

int getTransparency()
{
return transparency;
}


  
  String toString()
  {
    String result =
    "{'name':"+name+","+
    "'rayon':"+rayon+","+
     "'makeLinkFlag':"+makeLinkFlag+","+
     "'idle':"+idle+","+
     "'pg':"+pg+","+
     "'previousX':"+previousX+","+
       "'previousY':"+previousY+","+
  "'storedCenterX':"+storedCenterX+","+
"'storedCenterY':"+storedCenterY+","+
"'brushSize':"+brushSize+","+
"'brushColor':"+brushColor+","+
"'pressure':"+pressure+",";
  return result;
  }
  
  
}
