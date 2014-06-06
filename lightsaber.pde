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
import java.awt.Frame;
import java.awt.BorderLayout;
import java.util.*;

// branch brush_cursor
Point2dArray pointsArray;
String version="beta 01";
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
static String DEBUG_INFO_TEXT="  (press d to hide)";
static String DEBUG_FRAMECOUNT="  framecount = ";

static String BRUSH_NAME_LINK="link";
static String BRUSH_NAME_SIMPLE="simple";
static String BRUSH_NAME_ERASE="erase";
static String BRUSH_NAME_RANDOM="random";
static String BRUSH_NAME_JPEN="Jpen";
static String BRUSH_NAME_MOTIF="motif";

static int DEBUG_FRAMECOUNT_X=WIDTH-350;
static int DEBUG_FRAMECOUNT_Y=HEIGHT-20;

PGraphics pg, pg2; 
ControlP5 cp5;
ControlFrame cf;
Frame cfFrame;
int def;
int brushTransparency=255;
String pressedKey;
BrushLink brushlink;
BrushSimple brushsimple;
BrushErase brusherase;

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
List<BrushBase> brushList;
int myColorBackground = color(0,0,0);
int knobValue = 100;
Tablet t;

void setup() {
  size(WIDTH, HEIGHT);
  frame.setLocation(200, 100);

  colorMode(RGB, 255);
  pg = createGraphics(WIDTH, HEIGHT);
  
  pointsArray=new Point2dArray();

  
  brushlink=new BrushLink(this,pg,pointsArray,BRUSH_NAME_LINK);
  brushsimple=new BrushSimple(this,pg,pointsArray, BRUSH_NAME_SIMPLE);
  brusherase=new BrushErase(this,pg,pointsArray,BRUSH_NAME_ERASE);

  brushrandom=new BrushRandom(this,pg,pointsArray,BRUSH_NAME_RANDOM);
  brushjpen=new BrushJpen(this,pg,pointsArray,BRUSH_NAME_JPEN);
  brushMotif=new BrushMotif(this,pg,pointsArray,BRUSH_NAME_MOTIF);
  
  brushList=new ArrayList<BrushBase>();
  brushList.add(brushjpen);
  brushList.add(brushMotif);
  brushList.add(brushlink);
  brushList.add(brushsimple);
  brushList.add(brushrandom);
  brushList.add(brusherase);
 
    cp5 = new ControlP5(this);
    cf = addControlFrame("Toolbox", 200,200);
  

  raduisGizmo=new RaduisGizmo(this);
  selectedBrush=brushjpen;
  selectedBrush.setRayon(8);
  showPointFlag=false;
  showDebugInfo=true;
  useCurveToDraw=false;


  dragimage = new DragImage("test.jpg",0,0);
  jFileChooser1 = new JFileChooser();
  jColorChooser=new JColorChooser();
  
//get current version from getversion.bat
  try{
    println(sketchPath("")+"getversion.bat");
    Process p = Runtime.getRuntime().exec(sketchPath("")+"getversion.bat");
   println("getversion.bat exécuté");
   }
   catch(IOException e)
   {
     println("EXCEPTION --->IOEXCEPTION - exécution à l'exécution de process p = Runtime.getRuntime()");
   }
//load the generated text file and put the content in version
  String lines[] = loadStrings("version.txt");
  version=lines[0];
  
   cfFrame.setLocation(frame.getLocation().x-220, frame.getLocation().y);
   cfFrame.setVisible(true);
  println("Lightsaber Bruno Bertogal janvier 2013   ");
  println("touche brosse 1 : simple 2 : link  3 :  4 5 6 : erase  ");
  println("touche haut : augmenter le rayon des liaisons ");
  println("touche bas : diminuer le rayon des liaisons ");
  println("backspace :  effacer ");
  println("s :  sauvegarder l'image ");
  println("d : debug info");
  println("Working Directory = " + System.getProperty("user.dir"));
  println("os = " + System.getProperty("os.name"));
  println("user.home = " + System.getProperty("user.home"));
  println("sketchpath = " + sketchPath(""));
    
}

/*
menu actions
**/




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
    changeBrush(brushMotif);
    break;
    
    case 53:// 5
     changeBrush(brushjpen);
    break;
    
    case 54:// 6
    changeBrush(brusherase);
    break;  
    
    case 55:// 7
    
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
    
    case 87: //w
   changeFlip(false);
    break;
    
     case 88: // x
   changeFlip(true);
    break;
    
      case 44: // ?
   replayBrush();
    break;
  
   case 59: // .
     playStrokeSession();
    break;

case 513: // /
   startStrokeSession();
    break;

  }
}

public void playStrokeSession(){
  //ointsArray=new Point2dArray();
   clearPg();
    println("play stroke session");
 selectedBrush.playStrokeSession();
}

public void startStrokeSession(){
  clearPg();
  println("new stroke session");
 selectedBrush.startStrokeSession();
}

public void replayBrush(){
  pointsArray=new Point2dArray();
 selectedBrush.executeStroke();
}

public void changeFlip(boolean b)
{
  
  if(b)
  {
  flipHorizontal=!flipHorizontal;
  }
  else
  {
    flipVertical=!flipVertical;
  }
}

public void changeBrush(BrushBase brush)
{
    selectedBrush=brush;
    selectedBrush.setBrushColor(brushcolor);
     cf.setSliderTransparency(selectedBrush.getTransparency());
}

public void switchTransparency()
{
  saveTransparency=!saveTransparency;
}

public void activateTransparency()
{
  if(saveTransparency)
  {
    saveByJDialog(true);
  } else
  {
    saveByJDialog(false);
  }
}

public void debugBar(){
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

public void hideImage(){
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
          ;
}


void loadImage(){
String f="";
        jFileChooser1.setDialogTitle(LOAD_FILE_TEXT);

        //jFileChooser1.setFileFilter(new SimpleFileFilter("jpg"));
        jFileChooser1.setCurrentDirectory(new File(DEFAULT_LOADING_DIRECTORY));
        // try catch ici
        if (jFileChooser1.showOpenDialog(this) == JFileChooser.APPROVE_OPTION) {
           try{
         f=(jFileChooser1.getSelectedFile().getAbsolutePath()); //si un fichier est selectionné, récupérer le fichier puis sont path et l'afficher dans le champs de texte
           }
           catch (Exception e)
         {
          e.printStackTrace();
           println("EXCEPTION --->");
         }
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
  pg.clear();
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

 try{
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
    tmppg.noSmooth();
    tmppg.fill(0, 102, 153);
    tmppg.text(UtilsFunctions.getDate()+" - Lightsaber_"+version,DEBUG_FRAMECOUNT_X,DEBUG_FRAMECOUNT_Y);
    tmppg.smooth();
    tmppg.endDraw();
   
    tmppg.save(chooser.getCurrentDirectory()+"\\"+ chooser.getSelectedFile().getName());
  
  }
 }
 catch(Exception e)
 {
   println("--->EXCEPTION");
 }
 
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
    text(DEBUG_FRAMECOUNT+frameCount,50,63);
    pg.fill(0, 102, 153);
    text(UtilsFunctions.getDate()+" - Lightsaber_"+version,DEBUG_FRAMECOUNT_X,DEBUG_FRAMECOUNT_Y);

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
  selectedBrush.mouseReleased();
 dragimage.stopDragging();
}
boolean flipVertical=false;
boolean flipHorizontal=false;

void changeScale()
{
   if (flipVertical)
  {

  imageFlip(pg,300,600,"v");
 flipVertical=false;
  
  }
  
  if (flipHorizontal)
  {

  imageFlip(pg,300,600,"h");
 flipHorizontal=false;
  
  }
}



void draw() {
  background(BACKGROUND_FILL);
 selectedBrush.setTransparency(brushTransparency);
  dragimage.display();
  
  debugInfo();
  

  
 if (raduisGizmo.getVisible()){
  raduisGizmo.draw();
  selectedBrush.setRayon(raduisGizmo.getRaduis());
  }

  pg.beginDraw();
   

  pg.endDraw();
  
  changeScale();
  image(pg, 0, 0);
  selectedBrush.draw();

  cfFrame.setLocation(frame.getLocation().x-220, frame.getLocation().y);
  
}


void menuAction(ControlEvent theEvent)
{  
 // println("theEvent = "+theEvent.getController().getName());
 // println("theEvent = "+ theEvent.getController().getId());
 int id=theEvent.getController().getId();
 if(id>=0 && id<brushList.size())
  changeBrush(brushList.get(id));
}

ControlFrame addControlFrame(String theName, int theWidth, int theHeight) {
  cfFrame = new Frame(theName);
  ControlFrame p = new ControlFrame(this,brushList, theWidth, theHeight);
  cfFrame.add(p);
  p.init();
  cfFrame.setTitle(theName);
  cfFrame.setSize(200,300);
 
  cfFrame.setResizable(false);
   // comment this out to turn OS chrome back on
  cfFrame.setUndecorated(true); 
  // comment this out to not have the window "float"
  cfFrame.setAlwaysOnTop(true);
  
  return p;
}

public void controlEvent(ControlEvent theEvent) {
  //println("lightsaber theEvent = "+theEvent);

}



//imageFlip function by nick lally
//paste function at the bottom of your sketch, and use like this: imageFlip(imageName,x,y,"mode")
//modes are "v", "v2", "h", "h2"
//"v" mirrors vertically, "v2" mirrors top half vertically
//"h" mirrors horizontally, "h2" mirrors left half horizontally
void imageFlip(PImage imageName, int xPos, int yPos, String mode){
  //"v2" flips the top half of the image across the x-axis
  if(mode == "v2"){
    imageName.loadPixels();
    for(int i = 0; i < imageName.height; i++){
      for(int j = 1; j < imageName.width; j++){
        imageName.pixels[(imageName.height - 1 - i)*(imageName.width) + j] = imageName.pixels[i*(imageName.width) + j];
      }
    }
    imageName.updatePixels();
    image(imageName,xPos,yPos);
 
  //"v" flips the entire image across the x-axis
  }else if(mode == "v"){
    imageName.loadPixels();
    int tempImage[] = new int[imageName.width*imageName.height];
    for(int i = 0; i < imageName.width*imageName.height; i++){
     tempImage[i] = imageName.pixels[i];
    }
 
    for(int i = 0; i < imageName.height; i++){
      for(int j = 1; j < imageName.width; j++){
        imageName.pixels[(imageName.height - 1 - i)*(imageName.width) + j] = tempImage[i*(imageName.width) + j];
      }
    }
    imageName.updatePixels();
    image(imageName,xPos,yPos);
 
  //"h2" flips the left half of the image across the y-axis
  }else if(mode == "h2"){
    imageName.loadPixels();
    for(int i = 0; i < imageName.height; i++){
      for(int j = 1; j < imageName.width; j++){
        imageName.pixels[i*imageName.width + j] = imageName.pixels[(i+1)*(imageName.width) - j];
      }
    }
    imageName.updatePixels();
    image(imageName,xPos,yPos); 
 
  //"h" flips the entire image across the y-axis
  }else if(mode == "h"){
    imageName.loadPixels();
    int tempImage[] = new int[imageName.width*imageName.height];
    for(int i = 0; i < imageName.width*imageName.height; i++){
     tempImage[i] = imageName.pixels[i];
    }
    for(int i = 0; i < imageName.height; i++){
      for(int j = 1; j < imageName.width; j++){
        imageName.pixels[(i+1)*(imageName.width) - j] = tempImage[i*imageName.width + j];
      }
    }
    imageName.updatePixels();
    image(imageName,xPos,yPos);
  } else {
    println("No mirror direction specified!");
    println("Use v, v2, h, or h2 for the 4th argument");
  }
} 
