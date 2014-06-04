class RaduisGizmo 
{


  int storedCenterX,storedCenterY;
  int raduis=0;
  boolean visible=false;
  
  RaduisGizmo(Object parent)
  {
  storedCenterX=500;storedCenterY=300;
      stroke(#000000, 20);
      fill(#00ff00, 20);
      stroke(#000000, 20);
  
  }
  
  void keyPressed() {
  switch(keyCode)
  {
  case 87://w
  println(" w pressed");

  break;
  }
}
  
  
  void setLoc(int x, int y){
    storedCenterX=x;
     storedCenterY=y;
  }
void setVisible(boolean b)
  {
    visible=b;
  }
  
  boolean getVisible()
  {
    return visible;
  }
  
  
int getRaduis()
{

    return raduis;
}

void draw()
{
   

     if(visible)
    {

      fill(#00ff00, 60);
      stroke(#000000, 70);
      ellipse(mouseX, mouseY,10,10);
      ellipse(storedCenterX, storedCenterY,10,10);
      line( storedCenterX, storedCenterY,mouseX,mouseY);
        fill(#00ff00,40);
      stroke(#000000,60);
      float r=(float)dist(storedCenterX, storedCenterY,mouseX,mouseY);
      ellipse(storedCenterX, storedCenterY,r*2,r*2);
       raduis=(int)r*2;
       fill(#000000,100);
        text(" raduis = "+raduis/10,storedCenterX-40,storedCenterY-20);
      if ((mousePressed && (mouseButton == RIGHT)))
      {
      
         
        println(" validé "+r*2);
        visible=false;
      }
      else if (key==' '){
        visible=false;
      }
        
    }
    else
    {
      return;
    }
  
}



}
