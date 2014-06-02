
class BrushBase
{
  String name;
  int rayon=20;
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
  int pressure;
  Stroke stroke;
  boolean isNewStroke=true;
  BrushBase(PGraphics p, Point2dArray p2, String n)
  {
    previousX=0;
    previousY=0;
    brushSize=1;
    color c=color(0,0,0,255);
    setBrushColor(c);
    update(p, p2, n);
    idle=false;
     stroke=new Stroke();
    //redraw();
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
  
  
  void drawBrushStroke()
  {
     
    
    if (mousePressed && (mouseButton ==LEFT)) {
         
          
      
      if (previousX==0 && previousY==0)
      {
        previousX=mouseX;
        previousY=mouseY;
      }
      pg.fill(153);
   
      pg.stroke(brushColor);
     
      Point2d pt=new Point2d(mouseX, mouseY);
      pg.strokeWeight(0.5);
      pg.line( mouseX, mouseY, previousX, previousY);
      pg.endDraw();

      pointsArray.add(pt);  

      previousX=mouseX;
      previousY=mouseY;
    }
    else
    {
      previousX=0;
      previousY=0;
    }
  } 
  
  
  
void recordStroke()
{
    if (mousePressed && (mouseButton ==LEFT)) {
        println("pressed!!!! ");
        
        if(isNewStroke){
        stroke=new Stroke();
        isNewStroke=false;
        }
        else
        {
        stroke.record(frameCount,mouseX,mouseY);
        } 
    }
  

} 

void mouseReleased()
{
 isNewStroke=true;
}

void executeStroke(){
stroke.execute();
stroke=new Stroke();
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


  void draw()
  {
    if(idle)
{ return;   }


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
