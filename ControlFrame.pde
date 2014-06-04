

// the ControlFrame class extends PApplet, so we 
// are creating a new processing applet inside a
// new frame with a controlP5 object loaded
import java.util.*;
import java.awt.Frame;
public class ControlFrame extends PApplet {

  int h, w;
  List<BrushBase> brushList;
  ControlP5 cp5;
  Object parent;
  Frame frame;
  int bgcolor = 100;
  
    public ControlFrame(Object theParent,List<BrushBase> bList, int theWidth, int theHeight) {
    parent = theParent;
    w = theWidth;
    h = theHeight;

    brushList=bList;
   println(" création "+this.getLayout());
  }

  public void setup() {
    size(h, w);
    frameRate(25);
    cp5 = new ControlP5(this);
    cp5.addSlider("transparency").plugTo(parent,"brushTransparency").setRange(0, 255).setPosition(10,10).setValue(255);
   // cp5.addSlider("def").plugTo(parent,"def").setRange(0, 255).setPosition(10,30);
    // create a new button with name 'buttonA'
   
   Iterator<BrushBase> it = brushList.iterator();
   int i=0;
   int j=0;
   int id=0;
   
      while(it.hasNext()){
        
      BrushBase brush=it.next();
       cp5.addButton(brush.getName())
       .setValue(id)
       .setId(id)
       .setPosition(10+j*50,50+i*50)
       .setSize(45,45)
       ;
       id++;
      if (j>=1){j=0;i++;}else{j++;};
     
    }
     
  }

public void setSliderTransparency(float f)
{
   cp5.getController("transparency").setValue(f);
}


public void controlEvent(ControlEvent theEvent) {
((lightsaber)parent).menuAction(theEvent);
}


  public ControlP5 control() {
    return cp5;
  }

  public void draw() {
      background(bgcolor);
  }

  
}













