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
  float previousX, previousY, storedCenterX, storedCenterY;
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
  List<Stroke> strokeList;
  Stroke stroke;
  Tablet tablet;
  Object parent;
  boolean isNewStroke=true;
  boolean isXMirrored=false;
  boolean isYMirrored=false;
  
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
     strokeList=new ArrayList<Stroke>();
    //redraw();
  }
  
void setMirrored(boolean b)
{ 
    isXMirrored=b; 
}

boolean getMirrored( )
{  
    return isXMirrored;
}

  void update(PGraphics p, Point2dArray p2, String n)
  {
    pg=p;
    pointsArray=p2;
    name=n;
  }


  float getRayon()
  {
    return rayon;
  }
  
  void setRayon(int r)
  {
    rayon=r;
  }
  
  
void drawBrushStroke(int mX,int mY,int pX, int pY,float p)
{
}
  
  
  int recordCounter=0;
void recordStroke(){
          
        recordCounter=0;
        recordCounter++;

      if(isNewStroke){
      strokeList.add(stroke);
      stroke=new Stroke(this,pg);
      isNewStroke=false;
      recordCounter=0;
     
      }
      else
      {
        
        stroke.record(frameCount,mouseX,mouseY,pmouseX,pmouseY,tablet.getPressure());
      
      }
      
        // println("recordCounter = "+recordCounter+" - " +frameCount,mouseX,mouseY,pmouseX,pmouseY,tablet.getPressure());
   
    
} 

boolean playSession=false;

void playStrokeSession()
{
  playSession=true;
}

int incrementStroke=0;
void playStrokeSessionFrame(int increment){
  
   if (!strokeList.isEmpty())
  {
    if (incrementStroke<strokeList.size()){
      //récuprérer le stroke
     Stroke item=strokeList.get(incrementStroke);
     item.execute();
  
    }else
    {
      // fin des strokes
      println("fin des strokes");
      playSession=false;
      incrementStroke=0;
    }
    
    }
  } 


void startStrokeSession(){
  strokeList=new ArrayList<Stroke>();
}


void mouseReleased()
{
 isNewStroke=true;
 strokeList.add(stroke);
}

void executeStroke(){
   if (!strokeList.isEmpty())
  {
    println("executeStroke stroke arraylist size "+strokeList.get(strokeList.size()-1));
    strokeList.get(strokeList.size()-1).execute();
  }

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
  

  
void postDrawOperation()
{
  
if (isXMirrored)
{
  println("isXMirrored "+isXMirrored);
     previousX=0;
     previousY=0;
     
     WIDTH=1000;HEIGHT=600;
    int midleX=WIDTH/2;int midleY=HEIGHT/2;
    int mmx=(2*midleX)-mouseX;int pmmx=(2*midleX)-pmouseX;
     drawBrushStroke(mmx,mouseY,pmmx,pmouseY,tablet.getPressure());
   //recordStroke();
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
   previousX=0;
   previousY=0;
  
     if(playSession)
     {
     playStrokeSessionFrame(incrementStroke);
     incrementStroke++;
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

void setTransparency(int i)
{
  transparency=i;
}

int getTransparency()
{
return transparency;
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
