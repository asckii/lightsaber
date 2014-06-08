class Stroke
{

  ArrayList<StrokeStep> strokeStepList;
  BrushBase brush;
  int previousX;
  int previousY;
  int mX;
  int mY;

  Stroke(BrushBase b, PGraphics pg)
  {
    strokeStepList=new ArrayList<StrokeStep>();
    brush=b;
  }

  void record(StrokeStep strokeStep)
  {

    strokeStepList.add(strokeStep);
  }

  void execute() {

    if (!strokeStepList.isEmpty() )
    {



      for (StrokeStep strokeStep : strokeStepList) {

        brush=strokeStep.getBrush();
        ;
        //print(" * "+ brush.getName()+" ");
        if (strokeStep.getIsCleared()) {
          brush.commandClear();
        } else 
        {


          if (strokeStep.getIsMirrored())
          {

            // println("deux opérations");
            brush.setIsPostDrawOperation(false);
            drawBrushStroke(strokeStep);
            brush.setIsPostDrawOperation(true);
            postDrawOperation(strokeStep);
          } else
          {
            drawBrushStroke(strokeStep);
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

  void drawBrushStroke(StrokeStep strokeStep) {

    brush.drawBrushStroke(strokeStep);
  }
  void postDrawOperation(StrokeStep strokeStep) {

    brush.postDrawOperation(strokeStep);
  } 


  void draw()
  {
    pg.beginDraw();

    pg.rect (50, 80, 50, 50);
    pg.endDraw();

    println("stroke draw");
  }

  String toString()
  {
    String listStrokes="";
    if (!strokeStepList.isEmpty())
    {
      for (StrokeStep object : strokeStepList) {
        listStrokes=listStrokes+object.toString();
      }
    } 
    return listStrokes;
  }
}

