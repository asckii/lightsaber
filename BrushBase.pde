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
  float storedCenterX, storedCenterY;

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
  lightsaber parent;
  boolean isNewStroke=true;
  boolean isXMirrored=false;
  boolean isYMirrored=false;
  boolean playSession=false;
  boolean isCleared=false;
  boolean isPlaying=false;
   
  int recordCounter=0;
  int incrementStroke=0;

  // List<Stroke> strokeList;


  BrushBase(Object pa, PGraphics p, Point2dArray p2, String n)
  {
    parent=((lightsaber)pa); 
    tablet= new Tablet(parent); 
    UtilsFunctions.previousX=0;
    UtilsFunctions.previousY=0;
    brushSize=1;
    color c=color(0, 0, 0, 255);
    setBrushColor(c);
    update(p, p2, n);
    idle=false;
    stroke=new Stroke(this, pg);
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
    UtilsFunctions.previousX=0;
    UtilsFunctions.previousY=0;
    UtilsFunctions.pdopreviousX=0;
    UtilsFunctions.pdopreviousY=0;
  }

  void setIsPostDrawOperation(boolean b)
  {
    isPostDrawOperation=b;
  }

  void setPreviousPoints(int x, int y)
  {
    UtilsFunctions.previousX=x;
    UtilsFunctions.previousY=y;
  }


  void IsCleared()
  { 
    println("is cleared");

    resetPreviousPoints();
    incrementStroke=0;
    stroke.record(new StrokeStep(this, 0, 0, 0, 0, 0, 0, 0,rayon,brushColor,isXMirrored, true));
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



  void customDraw(StrokeStep strokeStep, float tmpPreviousX, float tmpPreviousY) {
  }

  void drawBrushStroke(StrokeStep strokeStep)
  {

    int mx=strokeStep.getX();
    int my=strokeStep.getY();
    int px=strokeStep.getpX();
    int py=strokeStep.getpY(); 
    int strokeRayon=strokeStep.getRayon();
    float strokePressure=strokeStep.getPressure();
    int strokeTransparency=strokeStep.getTransparency();
    float tmpPreviousX=0; 
    float tmpPreviousY=0;

    // déterminer previousx, previousy en fonction de la valeur de isPostDrawOperation
    if (isPostDrawOperation)
    {

      if (UtilsFunctions.pdopreviousX==0 && UtilsFunctions.pdopreviousY==0)
      {
        //println("init isPostDrawOperation");
        //  la brosse a été levée au paravant alors previousx et previousy ont été remis à 0
        // on récupère les dernières positions connues du pinceau si on est en mode mirroir
        UtilsFunctions.pdopreviousX=px;
        UtilsFunctions.pdopreviousY=py;
      }

      tmpPreviousX=UtilsFunctions.pdopreviousX;
      tmpPreviousY=UtilsFunctions.pdopreviousY;
    } else {
      if (UtilsFunctions.previousX==0 && UtilsFunctions.previousY==0)
      {
        //  println("init normal");
        //  la brosse a été levée au paravant alors previousx et previousy ont été remis à 0
        // on récupère les dernières positions connues du pinceau si on est en mode mirroir
        UtilsFunctions.previousX=px;
        UtilsFunctions.previousY=py;
      }

      tmpPreviousX=UtilsFunctions.previousX;
      tmpPreviousY=UtilsFunctions.previousY;
    }


    // on dessine
    customDraw(strokeStep, tmpPreviousX, tmpPreviousY);


    if (isPostDrawOperation)
    {
      // tant qu'on appuie sur le bouton droit, on conserve les ancienes positions
      UtilsFunctions.pdopreviousX=mx;
      UtilsFunctions.pdopreviousY=my;
    } else
    {
      // tant qu'on appuie sur le bouton droit, on conserve les ancienes positions
      UtilsFunctions.previousX=mx;
     UtilsFunctions.previousY=my;
    }
  }


  void recordStroke(StrokeStep strokeStep) {

    // au lacher de souris isNewStroke est vrai on crée alors un stroke
    // sinon on archive un strokestep

      // print(".");
    stroke.record(strokeStep);
  } 



  void playStrokeSession()
  {
    playSession=true;
    pointsArray=new Point2dArray();
  }

  /*
* playStrokeSessionFrame
   * play the stroke session
   *
   */


int getIncrementStroke()
{
  return incrementStroke;
}


  void playStrokeSessionFrame() {
    //println("executeStroke stroke arraylist size "+strokeList.size());
    if (!UtilsFunctions.strokeList.isEmpty())
    {
     

    

    
    noFill();
    
    
      isPlaying=true;
      pgDebug.noFill();
      // println("\n playStrokeSessionFrame "+ incrementStroke+"/"+UtilsFunctions.strokeList.size());
      if (incrementStroke<UtilsFunctions.strokeList.size()) {
        //récupérer le stroke
        Stroke item=UtilsFunctions.strokeList.get(incrementStroke);

        item.execute();
      } else
      {

        // fin des strokes
        //println("\nfin des strokes");
        playSession=false;
        isPlaying=false;
        incrementStroke=0;
        parent.stopRecording();
        return;
      }
    
  // 
   if (parent.isPaused)
    {
   // incrementStroke=0;
   //do nothing
  }
  else
  {  
      incrementStroke++;
    }
 
    }
  } 


  void startStrokeSession() {
    UtilsFunctions.strokeList=new ArrayList<Stroke>();
    recordCounter=0;
    isPlaying=false;
  }

  void executeStroke() {
    if (!UtilsFunctions.strokeList.isEmpty())
    {
      //println("executeStroke stroke arraylist size "+strokeList.get(strokeList.size()-1));
      // brushColor=#FF0000; utile pour le débug
      UtilsFunctions.strokeList.get(UtilsFunctions.strokeList.size()-1).execute();
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
  
  boolean getIsPlaying()
  {
    return isPlaying;
  }

  boolean isPostDrawOperation=false;
  void postDrawOperation(StrokeStep strokeStep)
  {

    if (strokeStep.getIsMirrored())
    {

   
      int middleX=WIDTH/2;
      int middleY=HEIGHT/2;
      int mmx=(2*middleX)-strokeStep.getX();
      int pmmx=(2*middleX)-strokeStep.getpX();
      int mmy=strokeStep.getY();
      int pmmy=strokeStep.getpY();
      int ray=strokeStep.getRayon();
      color col=strokeStep.getBrushColor();
      drawBrushStroke(new StrokeStep(
      this, strokeStep.getFrame(), 
      mmx, 
      mmy, 
      pmmx, 
      pmmy, 
      strokeStep.getPressure(), 
      strokeStep.getTransparency(), 
      strokeStep.getRayon(),
      strokeStep.getBrushColor(),
      strokeStep.getIsMirrored(), 
      strokeStep.getIsCleared()
        ));

      stroke(#000000, 50);
      ellipse(mmx, mmy, rayon, rayon);
    }
  }

  void mouseReleased()
  {
    //isNewStroke=true;
    //strokeList.add(stroke);
    UtilsFunctions.strokeList.add(stroke);
    stroke=new Stroke(this, pg);
    isNewStroke=false;
    //  println("stroke "+recordCounter);
    recordCounter++;
  }



/* 
DRAW 
*/

  void draw()
  {
    if (idle)
    { 
      return;
    }
    smooth();
    noFill();
    stroke(#000000, 50);
    ellipse(mouseX, mouseY, rayon, rayon);
    
    int mx =int(parent.zMousePosition.x);    // Equivalent to mouseX
  int my =int(parent.zMousePosition.y);    // Equivalent to mouseY
  //println("Mouse at "+mx+","+my);

 // println("Mouse at "+mx+","+my+" zoom : "+ zoomer.getZoomScale());
    noFill();
  rect(mx-10,my-10,20,20);
    

    showRadiusGizmo();
    pg.beginDraw();
    pg.stroke(brushcolor);
    pg.endDraw();

    if (mousePressed )
    {
      ShowDrawingGizmo();
    }


    if (playSession)
    {

      playStrokeSessionFrame();
      // incrementStroke++;
    }


    if ((mousePressed && (mouseButton ==LEFT))&&isPlaying==false) {


      StrokeStep tmpStroke=new StrokeStep(this, frameCount, mouseX, mouseY, pmouseX, pmouseY, tablet.getPressure(), transparency,rayon,brushColor, isXMirrored, false);
      isPostDrawOperation=false;
      drawBrushStroke(tmpStroke);
      recordStroke(tmpStroke);

      isPostDrawOperation=true;
      postDrawOperation(tmpStroke);
    } else
    {
      // mouseup
      UtilsFunctions.previousX=0;
      UtilsFunctions.previousY=0;
      UtilsFunctions.pdopreviousX=0;
      UtilsFunctions.pdopreviousY=0; 

      if (!isNewStroke&&!UtilsFunctions.strokeList.isEmpty())
      {
        isNewStroke=true;
      }
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
      "'previousX':"+UtilsFunctions.previousX+","+
      "'previousY':"+UtilsFunctions.previousY+","+
      "'storedCenterX':"+storedCenterX+","+
      "'storedCenterY':"+storedCenterY+","+
      "'brushSize':"+brushSize+","+
      "'brushColor':"+brushColor+","+
      "'pressure':"+pressure+",";
    return result;
  }
}

