class RaduisGizmo 
{


  int storedCenterX, storedCenterY;
  int raduis=0;
  boolean visible=false;
  lightsaber parent;
  String name; 
  int maxRaduis;
  RaduisGizmo(Object pa,String s,int max)
  {
    maxRaduis=max;
    name=s;
    parent=((lightsaber)pa);
    storedCenterX=500;
    storedCenterY=300;
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


 void setMaxRaduis(int i) {
    maxRaduis=i;
  }
  
  int getMaxRaduis()
  {

    return maxRaduis;
  }


 void setName(String s) {
    name=s;
  }
  
  String getName()
  {

    return name;
  }

  void setLoc(int x, int y) {
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


void mouseReleased() {
//println("mousereleased");
  if (validate){
     
         validate=false;
        println(" validé 2 ");
       parent.setBrushIdle(false);
     
      }
}

boolean validate=false;
  void draw()
  {
    


    if (visible)
    {
 float r=(float)dist(storedCenterX, storedCenterY, parent.zMousePosition.x, parent.zMousePosition.y);
      
       if(r*2>maxRaduis)
       {
         r=(float)maxRaduis/2;
       }  
       
      println("r="+r);
      fill(#00ff00, 60);
      stroke(#000000, 70);
      ellipse(parent.zMousePosition.x, parent.zMousePosition.y, 10, 10);
      ellipse(storedCenterX, storedCenterY, 10, 10);
      line( storedCenterX, storedCenterY, parent.zMousePosition.x, parent.zMousePosition.y);
      fill(#00ff00, 40);
      stroke(#000000, 60);
     
     //
      ellipse(storedCenterX, storedCenterY, r*2, r*2);
      raduis=(int)r*2;
     
      //limit ellipse in red without fill
      noFill();
      stroke(#FF0000, 50);    
      ellipse(storedCenterX, storedCenterY, maxRaduis, maxRaduis);
       
       fill(#000000, 80);
      text(name+" = "+raduis, storedCenterX-40, storedCenterY-20);
      if ((mousePressed && (mouseButton == LEFT )))
      {


        println(" validé "+r*2);
        visible=false;
       validate=true;
      } 
    } else
    {
      return;
    }
  }
}

