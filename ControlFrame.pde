

// the ControlFrame class extends PApplet, so we 
// are creating a new processing applet inside a
// new frame with a controlP5 object loaded
import java.util.*;
import java.awt.Frame;
public class ControlFrame extends PApplet {

  int h, w;
  List<BrushBase> brushList;
  ControlP5 cp5;

  Frame frame;
  int bgcolor = 100;
 lightsaber parent; 
  public ControlFrame(Object theParent, List<BrushBase> bList, int theWidth, int theHeight) {
    parent=((lightsaber)theParent); 
    w = theWidth;
    h = theHeight;
    brushList=bList;
  }

  public void setup() {
    
    size(h, w);
    frameRate(25);
    cp5 = new ControlP5(this);
    //cp5.addSlider("transparency").plugTo(parent, "brushTransparency").setRange(0, 255).setPosition(10, 10).setValue(255);


    Iterator<BrushBase> it = brushList.iterator();
    int i=0;
    int j=0;
    int id=0;
// brosses
    while (it.hasNext ()) {

      BrushBase brush=it.next();
      cp5.addButton(brush.getName())
        .setValue(id)
          .setId(id)
            .setPosition(10+j*50, 50+i*50)
              .setSize(45, 45)
                ;
      id++;
      if (j>=1) {
        j=0;
        i++;
      } else {
        j++;
      };
    }
    
     cp5.addButton("quit")
        .setValue(999)
          .setId(999)
            .setPosition(170, 10)
              .setSize(45, 15)
                ;
                  cp5.addButton("app")
        .setValue(998)
          .setId(998)
            .setPosition(170, 30)
              .setSize(45, 15)
                ;
                
          cp5.addButton("tmp")
        .setValue(997)
          .setId(997)
            .setPosition(170, 50)
              .setSize(45, 15)
                ;
                
                
         cp5.addButton("play")
        .setValue(996)
          .setId(996)
            .setPosition(170, 80)
              .setSize(45, 15)
                ;   
          
          
          cp5.addButton("clear")
        .setValue(995)
          .setId(995)
            .setPosition(170, 100)
              .setSize(45, 15)
                ;     
            
               cp5.addButton("record")
        .setValue(994)
          .setId(994)
            .setPosition(170, 120)
              .setSize(45, 15)
                ;      
    
   /*  cp5.addButton("play")
        .setValue(7)
          .setId(7)
            .setPosition(10, 200)
              .setSize(45, 15)
                ;
      cp5.addButton("pause")
        .setValue(8)
          .setId(8)
            .setPosition(60, 200)
              .setSize(45, 15)
                ;*/
       // create a toggle
  cp5.addToggle("video")
     .setPosition(10,200)
     .setSize(20,10)
     ;         
                
    
   
  }

  public void setSliderTransparency(float f)
  {
   // cp5.getController("transparency").setValue(f);
  }


  public void controlEvent(ControlEvent theEvent) {
    parent.menuAction(theEvent);
  }


  public ControlP5 control() {
    return cp5;
  }

  public void draw() {
    background(bgcolor);
     fill(selectedBrush.getBrushColor());
    
    rect (120,50,20,20);
    
  }
}













