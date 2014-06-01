import javax.swing.JFileChooser;
import java.io.File;
import javax.swing.JOptionPane;
import javax.swing.JButton;
import javax.swing.JDialog;
import javax.swing.event.*;
import javax.swing.JColorChooser;
import java.awt.Color;
import javax.swing.JFileChooser;
import controlP5.*;
import g4p_controls.*;
import codeanticode.tablet.*;


Point2dArray pointsArray;

PGraphics pg, pg2;
ControlP5 cp5;

BrushLink brushlink;
BrushSimple brushsimple;
BrushErase brusherase;
BrushHelper brushhelper;
BrushRandom brushrandom;
BrushJpen brushjpen;
BrushBase selectedBrush;
BrushMotif brushMotif;

RaduisGizmo raduisGizmo;

JFileChooser jFileChooser1;
DragImage dragimage;
PImage img;

color brushcolor;
 JColorChooser jColorChooser;

static int WIDTH=1000, HEIGHT=600;

boolean showPointFlag;
boolean showDebugInfo;
boolean showRaduisGizmo;
boolean useCurveToDraw;

int myColorBackground = color(0,0,0);
int knobValue = 100;
Tablet t;

void setup() {
  println(this);
  size(WIDTH, HEIGHT);
  colorMode(RGB, 255);
  pg = createGraphics(WIDTH, HEIGHT);
   t= new Tablet(this); 
  pointsArray=new Point2dArray();

  brushlink=new BrushLink(pg,pointsArray," brush link ");
  brushsimple=new BrushSimple(pg,pointsArray, " brush simple ");
  brusherase=new BrushErase(pg,pointsArray," brush erase ");
  brushhelper=new BrushHelper(pg,pointsArray," brush  helper ");
  brushrandom=new BrushRandom(pg,pointsArray," brush random ");
  brushjpen=new BrushJpen(pg,pointsArray," brush Jpen ",t);
  brushMotif=new BrushMotif(pg,pointsArray," brush dd ",t);

  raduisGizmo=new RaduisGizmo();
  selectedBrush=brushjpen;
  selectedBrush.setRayon(8);
  showPointFlag=false;
  showDebugInfo=true;
  useCurveToDraw=false;


  dragimage = new DragImage("test.jpg",0,0);
  jFileChooser1 = new JFileChooser();

 //
 
  jColorChooser=new JColorChooser();
  println("Lightsaber Bruno Bertogal janvier 2013   ");
  println("touche brosse 1 : simple 2 : link  3 :  4 5 6 : erase  ");
  println("touche haut : augmenter le rayon des liaisons ");
  println("touche bas : diminuer le rayon des liaisons ");
  println("backspace :  effacer ");
  println("s :  sauvegarder l'image ");
  println("d : debug info");
  
  
}

void keyPressed() {
  println(" key " + keyCode); 
selectedBrush.keyPressed();

  switch(keyCode)
  {
  
  case 68:
    if (showDebugInfo)
    {
      showDebugInfo=false;
      redraw();
    }
    else
    {
      showDebugInfo=true;
      redraw();
    }
    break;

  case 83:
   showDebugInfo=false;
    saveByJDialog();
    
  break;

case 8:// backspace
 clearPg();
break;
 
case 49:// 1
 selectedBrush=brushsimple;
  selectedBrush.setBrushColor(brushcolor);
break;
case 50:// 1
 selectedBrush=brushlink;
  selectedBrush.setBrushColor(brushcolor);
break;
case 51:// 1
  selectedBrush=brushrandom;
   selectedBrush.setBrushColor(brushcolor);
break;
case 52:// 1
  selectedBrush=brushhelper;
   selectedBrush.setBrushColor(brushcolor);
break;
case 53:// 1
 selectedBrush=brushjpen;
  selectedBrush.setBrushColor(brushcolor);
break;
case 54:// 1
 selectedBrush=brusherase;
  selectedBrush.setBrushColor(brushcolor);
break;  
  case 55:// 1
 selectedBrush=brushMotif;
  selectedBrush.setBrushColor(brushcolor);
break;  
  
case 65:// 1

  chooseColor();
break;



case 82:// r

if (!raduisGizmo.getVisible()){
  raduisGizmo.setVisible(true);
  raduisGizmo.setLoc(mouseX,mouseY);
  selectedBrush.setIdle(true);

}
else
{
  selectedBrush.setIdle(false);
}

break;


case 71: // g  grab drag and drop

      if (dragimage.getActivateDragImage())
      {
        dragimage.setActivateDragImage(false);
        selectedBrush.setIdle(false);
      }
      else
      {
        dragimage.setActivateDragImage(true);
        selectedBrush.setIdle(true);
      }
      
      
      
      break;
      
      case 72: // h visible true false
    
        dragimage.setVisible(!dragimage.getVisible());
      

 
        break;
      
         case 18: // alt h visible true false
         selectedBrush.setBrushColor( get( mouseX, mouseY ));
         
        break;
      
      case 76: // l load image
        
       String f="";
        jFileChooser1.setDialogTitle(" Charger fichier ");

        //jFileChooser1.setFileFilter(new SimpleFileFilter("jpg"));
        jFileChooser1.setCurrentDirectory(new File("C:\\Users\\bruno\\Desktop\\temp_web"));
        // try catch ici
        if (jFileChooser1.showOpenDialog(this) == JFileChooser.APPROVE_OPTION) {
            f=(jFileChooser1.getSelectedFile().getAbsolutePath()); //si un fichier est selectionné, récupérer le fichier puis sont path et l'afficher dans le champs de texte
        }
        
        if (f.length()>2)
        {
        dragimage.initImage(f);
        //dragimage.setActivateDragImage(true);
        dragimage.setVisible(true);
        selectedBrush.setIdle(true);
        }
        else
        {
          println("opération annulée");
        }
        println(" fichier "+f);
        
      break; 






  }
}


void clearPg()
{
  pg.beginDraw();
  pg.fill(204);

  pg.background(0, 0);
  pointsArray=new Point2dArray();
  pg.endDraw();
  image(pg, 0, 0);
}



void chooseColor()
{
println( (int)red(brushcolor)+" "+(int)green(brushcolor)+" "+(int) blue(brushcolor));
Color selectedBrushColor=new Color( (int)red(brushcolor),(int)green(brushcolor),(int) blue(brushcolor));
Color c = jColorChooser.showDialog(this, "Choose a Color", selectedBrushColor);
try {
brushcolor=color(c.getRed(),c.getGreen(),c.getBlue(),255);
selectedBrush.setBrushColor(brushcolor);
}
catch( NullPointerException e)
{
  println("nullpointer exeption");
}

}

void  saveByJDialog()
{

  if ( showDebugInfo==true)
  {
    //print("---");
    //showDebugInfo=false;
   
    //redraw();
   
  }

  int d = day();   
  int m = month();  
  int y = year();  
  int s = second();  
  int mn = minute();  
  int h = hour();    

  String savename="sketche-"+d+m+y+"_"+h+mn+s+".jpg";
  JFileChooser chooser = new JFileChooser();
  File f = new File(savename);
  chooser.setSelectedFile(f);
  chooser.setFileFilter(chooser.getAcceptAllFileFilter());
  int returnVal = chooser.showSaveDialog(null);
  if (returnVal == JFileChooser.APPROVE_OPTION) 
  {
    save(chooser.getCurrentDirectory()+"\\"+ chooser.getSelectedFile().getName());

    println(" sauvegarde de "+chooser.getCurrentDirectory()+"\\"+ chooser.getSelectedFile().getName() );
  }
 
  //
}

void saveJavascript()
{
  int d = day();   
  int m = month();  
  int y = year();  
  int s = second();  
  int mn = minute();  
  int h = hour();    
  String savename="sketche-"+d+m+y+"_"+h+mn+s+".jpg";
  save(savename);// js builds
}

void debugInfo()
{
  if (showDebugInfo)
  {
   
    fill(0, 102, 153);
    text(" x= "+mouseX+" y= "+mouseY+" name "+selectedBrush.getName()+" Rayon "+selectedBrush.getRayon()+" (press d to hide)", 50, 50);
  }
  else
  {
     println(" showdebug "+showDebugInfo);
  }
}



void draw() {
  background(204);
  dragimage.display();
  debugInfo();
  

  
 if (raduisGizmo.getVisible()){
  raduisGizmo.draw();
  selectedBrush.setRayon(raduisGizmo.getRaduis());
  }
 
 
 
  pg.beginDraw();
  pg.endDraw();
  image(pg, 0, 0);
  selectedBrush.draw();

}

void mousePressed() {
   dragimage.clicked();
   if ((mousePressed && mouseButton == RIGHT)  )
   {
       selectedBrush.setIdle(false);
   }
}

void mouseReleased() {
 dragimage.stopDragging();
 
}



































/*
a list of all methods available for the Knob Controller
use ControlP5.printPublicMethodsFor(Knob.class);
to print the following list into the console.

You can find further details about class Knob in the javadoc.

Format:
ClassName : returnType methodName(parameter type)
 
controlP5.Knob : Knob setConstrained(boolean) 
controlP5.Knob : Knob setDragDirection(int) 
controlP5.Knob : Knob setMax(float) 
controlP5.Knob : Knob setMin(float) 
controlP5.Knob : Knob setNumberOfTickMarks(int) 
controlP5.Knob : Knob setRadius(float) 
controlP5.Knob : Knob setRange(float) 
controlP5.Knob : Knob setResolution(float) 
controlP5.Knob : Knob setScrollSensitivity(float) 
controlP5.Knob : Knob setSensitivity(float) 
controlP5.Knob : Knob setShowRange(boolean) 
controlP5.Knob : Knob setStartAngle(float) 
controlP5.Knob : Knob setTickMarkLength(int) 
controlP5.Knob : Knob setTickMarkWeight(float) 
controlP5.Knob : Knob setValue(float) 
controlP5.Knob : Knob setViewStyle(int) 
controlP5.Knob : Knob showTickMarks(boolean) 
controlP5.Knob : Knob shuffle() 
controlP5.Knob : Knob snapToTickMarks(boolean) 
controlP5.Knob : Knob update() 
controlP5.Knob : boolean isConstrained() 
controlP5.Knob : boolean isShowRange() 
controlP5.Knob : boolean isShowTickMarks() 
controlP5.Knob : float getAngle() 
controlP5.Knob : float getRadius() 
controlP5.Knob : float getRange() 
controlP5.Knob : float getResolution() 
controlP5.Knob : float getStartAngle() 
controlP5.Knob : float getTickMarkWeight() 
controlP5.Knob : float getValue() 
controlP5.Knob : int getDragDirection() 
controlP5.Knob : int getNumberOfTickMarks() 
controlP5.Knob : int getTickMarkLength() 
controlP5.Knob : int getViewStyle() 
controlP5.Controller : CColor getColor() 
controlP5.Controller : ControlBehavior getBehavior() 
controlP5.Controller : ControlWindow getControlWindow() 
controlP5.Controller : ControlWindow getWindow() 
controlP5.Controller : ControllerProperty getProperty(String) 
controlP5.Controller : ControllerProperty getProperty(String, String) 
controlP5.Controller : Knob addCallback(CallbackListener) 
controlP5.Controller : Knob addListener(ControlListener) 
controlP5.Controller : Knob bringToFront() 
controlP5.Controller : Knob bringToFront(ControllerInterface) 
controlP5.Controller : Knob hide() 
controlP5.Controller : Knob linebreak() 
controlP5.Controller : Knob listen(boolean) 
controlP5.Controller : Knob lock() 
controlP5.Controller : Knob plugTo(Object) 
controlP5.Controller : Knob plugTo(Object, String) 
controlP5.Controller : Knob plugTo(Object[]) 
controlP5.Controller : Knob plugTo(Object[], String) 
controlP5.Controller : Knob registerProperty(String) 
controlP5.Controller : Knob registerProperty(String, String) 
controlP5.Controller : Knob registerTooltip(String) 
controlP5.Controller : Knob removeBehavior() 
controlP5.Controller : Knob removeCallback() 
controlP5.Controller : Knob removeCallback(CallbackListener) 
controlP5.Controller : Knob removeListener(ControlListener) 
controlP5.Controller : Knob removeProperty(String) 
controlP5.Controller : Knob removeProperty(String, String) 
controlP5.Controller : Knob setArrayValue(float[]) 
controlP5.Controller : Knob setArrayValue(int, float) 
controlP5.Controller : Knob setBehavior(ControlBehavior) 
controlP5.Controller : Knob setBroadcast(boolean) 
controlP5.Controller : Knob setCaptionLabel(String) 
controlP5.Controller : Knob setColor(CColor) 
controlP5.Controller : Knob setColorActive(int) 
controlP5.Controller : Knob setColorBackground(int) 
controlP5.Controller : Knob setColorCaptionLabel(int) 
controlP5.Controller : Knob setColorForeground(int) 
controlP5.Controller : Knob setColorValueLabel(int) 
controlP5.Controller : Knob setDecimalPrecision(int) 
controlP5.Controller : Knob setDefaultValue(float) 
controlP5.Controller : Knob setHeight(int) 
controlP5.Controller : Knob setId(int) 
controlP5.Controller : Knob setImages(PImage, PImage, PImage) 
controlP5.Controller : Knob setImages(PImage, PImage, PImage, PImage) 
controlP5.Controller : Knob setLabelVisible(boolean) 
controlP5.Controller : Knob setLock(boolean) 
controlP5.Controller : Knob setMax(float) 
controlP5.Controller : Knob setMin(float) 
controlP5.Controller : Knob setMouseOver(boolean) 
controlP5.Controller : Knob setMoveable(boolean) 
controlP5.Controller : Knob setPosition(PVector) 
controlP5.Controller : Knob setPosition(float, float) 
controlP5.Controller : Knob setSize(PImage) 
controlP5.Controller : Knob setSize(int, int) 
controlP5.Controller : Knob setStringValue(String) 
controlP5.Controller : Knob setUpdate(boolean) 
controlP5.Controller : Knob setValueLabel(String) 
controlP5.Controller : Knob setView(ControllerView) 
controlP5.Controller : Knob setVisible(boolean) 
controlP5.Controller : Knob setWidth(int) 
controlP5.Controller : Knob show() 
controlP5.Controller : Knob unlock() 
controlP5.Controller : Knob unplugFrom(Object) 
controlP5.Controller : Knob unplugFrom(Object[]) 
controlP5.Controller : Knob unregisterTooltip() 
controlP5.Controller : Knob update() 
controlP5.Controller : Knob updateSize() 
controlP5.Controller : Label getCaptionLabel() 
controlP5.Controller : Label getValueLabel() 
controlP5.Controller : List getControllerPlugList() 
controlP5.Controller : PImage setImage(PImage) 
controlP5.Controller : PImage setImage(PImage, int) 
controlP5.Controller : PVector getAbsolutePosition() 
controlP5.Controller : PVector getPosition() 
controlP5.Controller : String getAddress() 
controlP5.Controller : String getInfo() 
controlP5.Controller : String getName() 
controlP5.Controller : String getStringValue() 
controlP5.Controller : String toString() 
controlP5.Controller : Tab getTab() 
controlP5.Controller : boolean isActive() 
controlP5.Controller : boolean isBroadcast() 
controlP5.Controller : boolean isInside() 
controlP5.Controller : boolean isLabelVisible() 
controlP5.Controller : boolean isListening() 
controlP5.Controller : boolean isLock() 
controlP5.Controller : boolean isMouseOver() 
controlP5.Controller : boolean isMousePressed() 
controlP5.Controller : boolean isMoveable() 
controlP5.Controller : boolean isUpdate() 
controlP5.Controller : boolean isVisible() 
controlP5.Controller : float getArrayValue(int) 
controlP5.Controller : float getDefaultValue() 
controlP5.Controller : float getMax() 
controlP5.Controller : float getMin() 
controlP5.Controller : float getValue() 
controlP5.Controller : float[] getArrayValue() 
controlP5.Controller : int getDecimalPrecision() 
controlP5.Controller : int getHeight() 
controlP5.Controller : int getId() 
controlP5.Controller : int getWidth() 
controlP5.Controller : int listenerSize() 
controlP5.Controller : void remove() 
controlP5.Controller : void setView(ControllerView, int) 
java.lang.Object : String toString() 
java.lang.Object : boolean equals(Object) 

*/




