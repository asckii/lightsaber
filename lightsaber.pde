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

// branch brush_cursor
Point2dArray pointsArray;
static int WIDTH=1000, HEIGHT=600;
static String DEFAULT_LOADING_DIRECTORY="C:\\Users\\bruno\\Desktop\\temp_web";
static String SAVE_FOLDER="C:\\Users\\bruno\\Desktop\\";
static String SAVE_NAME="sketche";
static String LOAD_FILE_TEXT=" load a file";
static int BACKGROUND_FILL=204;
static String COLOR_CHOOSER_TEXT=" choose a color ";
static String NULL_POINTER_EXCEPTION_TEXT=" null pointer execption occured ";
static String DEBUG_X_TEXT="  X= ";
static String DEBUG_Y_TEXT="  Y= ";
static String DEBUG_TYPE_TEXT="  |  brush type ";
static String DEBUG_RADUIS_TEXT="  | raduis ";
static String DEBUG_SAVETRANSPARENCY_TEXT="| save transparent = ";
static String DEBUG_PRESSEDKEY_TEXT="  | pressedKey ";
static String DEBUG_INFO_TEXT="(press d to hide)";
PGraphics pg, pg2; 
ControlP5 cp5;
String pressedKey;
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
JColorChooser jColorChooser;

DragImage dragimage;
PImage img;

color brushcolor;



boolean saveTransparency=false;
boolean showPointFlag;
boolean showDebugInfo;
boolean showRaduisGizmo;
boolean useCurveToDraw;

int myColorBackground = color(0,0,0);
int knobValue = 100;
Tablet t;

void setup() {
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
  pressedKey=str(keyCode); 
 selectedBrush.keyPressed();

  switch(keyCode)
  {
  
    case 68:
     debugBar();
    break;
  
    case 83:
    activateTransparency();
    break;
  
    case 79:// backspace
     switchTransparency();
    break;

    case 8:// backspace
     clearPg();
    break;
 
    case 49:// 1
    changeBrush(brushsimple);
    break;
    
    case 50:// 2
      changeBrush(brushlink);
    break;
    
    case 51:// 3
     changeBrush(brushrandom);
    break;
    
    case 52:// 4
    changeBrush(brushhelper);
    break;
    
    case 53:// 5
     changeBrush(brushjpen);
    break;
    
    case 54:// 6
    changeBrush(brusherase);
    break;  
    
    case 55:// 7
    changeBrush(brushMotif);
    break;  
  
    case 65:// a
      chooseColor();
    break;

    case 82:// r
    changeRaduis();
    break;
    
    case 71: // g  grab drag and drop
    grabImage();
    break;
    
    case 72: // h visible true false
     hideImage();
     break;
     
    case 76: // l
     loadImage();
    break; 
    
    case 67: // c
    pickColor();
    break;

  }
}

void changeBrush(BrushBase brush)
{
    selectedBrush=brush;
    selectedBrush.setBrushColor(brushcolor);
}

void switchTransparency()
{
  saveTransparency=!saveTransparency;
}

void activateTransparency()
{
  if(saveTransparency)
  {
    saveByJDialog(true);
  } else
  {
    saveByJDialog(false);
  }
}

void debugBar(){
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
}

void hideImage(){
 dragimage.setVisible(!dragimage.getVisible()); 
}

void grabImage(){
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
}

void pickColor(){
   println("color = "+ (get( mouseX, mouseY)+ " "+selectedBrush.getBrushColor() ));
         selectedBrush.setBrushColor(get( mouseX, mouseY) );
}


void loadImage(){
String f="";
        jFileChooser1.setDialogTitle(LOAD_FILE_TEXT);

        //jFileChooser1.setFileFilter(new SimpleFileFilter("jpg"));
        jFileChooser1.setCurrentDirectory(new File(DEFAULT_LOADING_DIRECTORY));
        // try catch ici
        if (jFileChooser1.showOpenDialog(this) == JFileChooser.APPROVE_OPTION) {
            f=(jFileChooser1.getSelectedFile().getAbsolutePath()); //si un fichier est selectionné, récupérer le fichier puis sont path et l'afficher dans le champs de texte
        }
        
        if (f.length()>2)
        {
        dragimage.initImage(f);
        dragimage.setVisible(true);
        selectedBrush.setIdle(true);
        }
        else
        {
          println("opération annulée");
        }
        println(" fichier "+f);
}

void clearPg()
{
  pg.beginDraw();
  pg.fill(BACKGROUND_FILL);

  pg.background(0, 0);
  pointsArray=new Point2dArray();
  pg.endDraw();
  image(pg, 0, 0);
}

void changeRaduis()
{
  if (!raduisGizmo.getVisible()){
  raduisGizmo.setVisible(true);
  raduisGizmo.setLoc(mouseX,mouseY);
  selectedBrush.setIdle(true);

}
else
{
  selectedBrush.setIdle(false);
}

}

void chooseColor()
{
Color selectedBrushColor=new Color( (int)red(brushcolor),(int)green(brushcolor),(int) blue(brushcolor));
Color c = jColorChooser.showDialog(this, COLOR_CHOOSER_TEXT, selectedBrushColor);
  try {
    brushcolor=color(c.getRed(),c.getGreen(),c.getBlue(),255);
    selectedBrush.setBrushColor(brushcolor);
  }
  catch( NullPointerException e)
  {
    println(NULL_POINTER_EXCEPTION_TEXT);
  }

}



void  saveByJDialog(boolean transparent)
{ 
  String savename=SAVE_FOLDER+SAVE_NAME+"-"+UtilsFunctions.getDate()+"_"+UtilsFunctions.getHour()+".png";
  JFileChooser chooser = new JFileChooser();
  File f = new File(savename);
  chooser.setSelectedFile(f);
  chooser.setFileFilter(chooser.getAcceptAllFileFilter());
  int returnVal = chooser.showSaveDialog(null);
  if (returnVal == JFileChooser.APPROVE_OPTION) 
  {

    PGraphics tmppg = createGraphics(WIDTH, HEIGHT);
    tmppg.beginDraw();
    tmppg.fill(BACKGROUND_FILL);
    
      if (!transparent)
      {
      
      tmppg.rect(0, 0,WIDTH, HEIGHT);
      }
    
    tmppg.image(pg, 0, 0);
    tmppg.endDraw();
   
    tmppg.save(chooser.getCurrentDirectory()+"\\"+ chooser.getSelectedFile().getName());
  
  }
 
  //
}

void saveJavascript()
{    
  String savename=SAVE_NAME+"-"+UtilsFunctions.getDate()+"_"+UtilsFunctions.getHour()+".jpg";
  save(savename);// js builds
}



void debugInfo()
{
  if (showDebugInfo)
  {
    fill(0, 102, 153);
    text(DEBUG_X_TEXT+mouseX+DEBUG_Y_TEXT+mouseY+DEBUG_TYPE_TEXT+selectedBrush.getName()+DEBUG_RADUIS_TEXT+selectedBrush.getRayon()+DEBUG_SAVETRANSPARENCY_TEXT+saveTransparency+DEBUG_PRESSEDKEY_TEXT+pressedKey +DEBUG_INFO_TEXT, 50, 50);
  }
  else
  {
     
  }
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


void draw() {
  background(BACKGROUND_FILL);
 
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




