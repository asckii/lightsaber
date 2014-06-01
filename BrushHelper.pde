class BrushHelper extends BrushBase
{

  
  BrushHelper(PGraphics p, Point2dArray p2,String n)
  {
    super(p,p2,n);
   
  }
  
  void keyPressed() {
  switch(keyCode)
  {
  case 87://w
  println(" w pressed");
       makeCircleFlag=true;
  break;
  }
}
  
 void drawBrushStroke()
{
}
  
void parameterCircle()
{
    if(circleConstructionFlag==false)
    {
      
    storedCenterX=mouseX;storedCenterY=mouseY;
      stroke(#000000, 20);
    
      fill(#00ff00, 20);
      stroke(#000000, 20);
      ellipse(mouseX, mouseY,50, 50);
      circleConstructionFlag=true;
      
    
    } 
    else
    {
      fill(#00ff00, 20);
      stroke(#000000, 20);
      ellipse(mouseX, mouseY,10,10);
      ellipse(storedCenterX, storedCenterY,10,10);
      line( storedCenterX, storedCenterY,mouseX,mouseY);
        fill(#00ff00,10);
      stroke(#000000,10);
      float r=(float)dist(storedCenterX, storedCenterY,mouseX,mouseY);
      ellipse(storedCenterX, storedCenterY,r*2,r*2);
      
      
      if ((mousePressed && (mouseButton == RIGHT)) || key==' ')
      {
        circleConstructionFlag=false;
        makeCircleFlag=false;
      
        makeCircle(storedCenterX,storedCenterY, r);
       // println(" validé "+r*2);
      }
      else if ((mousePressed && (mouseButton == LEFT)))
      {
        circleConstructionFlag=false;
        makeCircleFlag=false;
      }
    }
}

void draw()
{
    super.draw();
    if (  makeCircleFlag==true)
  {
    parameterCircle();
  }
}


void makeCircle(float mx,float my,float r)
{
  pg.noFill();
  pg.beginShape();
    
  for (int i=0; i<370;i=i+10)
  {
    float x= mx+sin(i*PI/180)*r;
    float y=my+cos(i*PI/180)*r;
    pg.stroke(brushColor);
   // println(" "+x+" "+y+" "+r);
    pg.curveVertex(x, y);
    Point2d   tmpPt;
    Point2d pt=new Point2d((int)x, (int) y);
    pointsArray.add(pt);
  }

 pg.endShape(CLOSE);
}
}
