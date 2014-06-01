class BrushDd extends BrushBase
{
Draggable d;
  
  BrushDd(PGraphics p, Point2dArray p2,String n)
  {
    super(p,p2,n);
    d = new Draggable(50,50,60,25);
  }
  
  void keyPressed() {
  switch(keyCode)
  {
  case 87://w
  println(" w pressed");
  break;
  }
}
  




void draw() {
  
    if(idle)
    {
      return;
    }
  super.draw();
  pg.noFill();
 
  d.rollover(mouseX,mouseY);
  d.drag(mouseX,mouseY);
  d.display();
   
}

void mousePressed() {
  d.clicked();
  println("mousepressed !! ");
}

void mouseReleased() {
  d.stopDragging();
  println("mouseReleased !! ");
}



}

