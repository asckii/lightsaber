import org.gicentre.utils.colour.*;
import org.gicentre.utils.io.*;
import org.gicentre.utils.gui.*;
import org.gicentre.utils.multisketch.*;
import org.gicentre.utils.move.*;
import org.gicentre.utils.stat.*;
import org.gicentre.utils.*;
import org.gicentre.utils.network.*;
import org.gicentre.utils.spatial.*;
import org.gicentre.utils.geom.*;
import org.gicentre.utils.network.traer.animation.*;
import org.gicentre.utils.text.*;
import org.gicentre.utils.network.traer.physics.*;

import java.awt.AWTException;
import java.awt.Robot;


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

import org.gicentre.utils.move.*;
import java.text.NumberFormat;

import java.text.DecimalFormat;
import java.text.NumberFormat;

// ------------------ Sketch-wide variables --------------------

ZoomPan zoomer;    // This should be declared outside any methods.
PVector mousePos;  // Stores the mouse position.
// For pretty formatting of mouse coordinates.
NumberFormat formatter = new DecimalFormat("#.0");


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
String FRAMEFOLDER_PATH;
static int DEBUG_FRAMECOUNT_X=WIDTH-350;
static int DEBUG_FRAMECOUNT_Y=HEIGHT-20;
boolean isMirrored=false;
static Stroke stroke;
PGraphics pg, pgDebug,pgMarks; 
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
RaduisGizmo transparencyGizmo;
JFileChooser jFileChooser1;
JColorChooser jColorChooser;

DragImage dragimage;
PImage img;

color brushcolor;

boolean saveVideo=false;
boolean isPaused=false;
boolean saveTransparency=false;
boolean showPointFlag;
boolean showDebugInfo;
boolean showRaduisGizmo;
boolean useCurveToDraw;
List<BrushBase> brushList;
int myColorBackground = color(0, 0, 0);
int knobValue = 100;
Tablet t;
ControlKeys controlKeys;
boolean isColorWheelShowed=false;
PImage colorWheel;
int colorWheelX=0;
int colorWheelY=0;
boolean flipVertical=false;
boolean flipHorizontal=false;
Robot robot;
// --------------------- Initialisation ------------------------
void setup() {
  
  size(WIDTH, HEIGHT);
  
   try { 
    robot = new Robot();
  } 
  catch (AWTException e) {
    e.printStackTrace();
  }
   robot.mouseMove(320, 200);
  
  
  frame.setLocation(200, 100);
  //noCursor();
  // --------------------- Zoomer Initialisation ------------------------
  zoomer = new ZoomPan(this);  // Initialise the zoomer.
  zoomer.setMouseMask(SHIFT);  // Only zoom if the shift key is down.
   zoomer.setMaxZoomScale(500.0);
zoomer.setMinZoomScale(0.12) ;

  // Monitor end of zoom/pan events.
  zoomer.addZoomPanListener(new MyListener());

  colorMode(RGB, 255);
  pg = createGraphics(WIDTH, HEIGHT);
  pgDebug = createGraphics(WIDTH, HEIGHT);
   pgMarks = createGraphics(WIDTH, HEIGHT);
  pointsArray=new Point2dArray();

  controlKeys=new ControlKeys(this);
  // --------------------- Brushes Initialisation ------------------------
  brushlink=new BrushLink(this, pg, pointsArray, BRUSH_NAME_LINK);
  brushsimple=new BrushSimple(this, pg, pointsArray, BRUSH_NAME_SIMPLE);
  brusherase=new BrushErase(this, pg, pointsArray, BRUSH_NAME_ERASE);

  brushrandom=new BrushRandom(this, pg, pointsArray, BRUSH_NAME_RANDOM);
  brushjpen=new BrushJpen(this, pg, pointsArray, BRUSH_NAME_JPEN);
  brushMotif=new BrushMotif(this, pg, pointsArray, BRUSH_NAME_MOTIF);

  brushList=new ArrayList<BrushBase>();
  brushList.add(brushjpen);
  brushList.add(brushMotif);
  brushList.add(brushlink);
  brushList.add(brushsimple);
  brushList.add(brushrandom);
  brushList.add(brusherase);

  // --------------------- stroke Initialisation ------------------------
  stroke=new Stroke(brushjpen, pg);

  cp5 = new ControlP5(this);
  cf = addControlFrame("Toolbox", 200, 200);


  raduisGizmo=new RaduisGizmo(this, "raduis", 1000);
  transparencyGizmo=new RaduisGizmo(this, "transparency", 255);
  selectedBrush=brushjpen;
  selectedBrush.setRayon(8);
  showPointFlag=false;
  showDebugInfo=true;
  useCurveToDraw=false;

  dragimage = new DragImage("test.jpg", 0, 0);
  colorWheel =loadImage("colorWheel.png");
  jFileChooser1 = new JFileChooser();
  jColorChooser=new JColorChooser();

open("rundll32 SHELL32.DLL,ShellExec_RunDLL " + sketchPath("")+"getversion.bat "+ sketchPath("")+" "+ sketchPath("")+"version.txt");

 
   
  
  //load the generated text file and put the content in version
  String lines[] = loadStrings("version.txt");
  if (lines.length>0)
  {
  version=lines[0];
  }

  String tmpp=sketchPath("")+"\\tmp";
  UtilsFunctions.createFolder(tmpp );
  FRAMEFOLDER_PATH=tmpp+ '\\'+UtilsFunctions.getDate();
  UtilsFunctions.createFolder(FRAMEFOLDER_PATH);


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


// --------------------- keys  ------------------------
void keyReleased()
{ 
  controlKeys.keyReleased();
  
}

void keyPressed() {
  controlKeys.keyPressed();
  pressedKey=str(keyCode); 
  selectedBrush.keyPressed();
  
  
}

// --------------------- change boolean values ------------------------
public void changeIsPaused()
{
  isPaused=!isPaused;
}

public void  changeMirrorMode() {
  isMirrored=!isMirrored;
  println("isMirrored "+isMirrored);
}
public void playStrokeSession() {
  isPaused=false;
  selectedBrush.commandClear();
  println("play stroke session");
  selectedBrush.playStrokeSession();
}


public void startStrokeSession() {
  clearPg();
  println("new stroke session");
  selectedBrush.startStrokeSession();
}

public void replayBrush() {

  selectedBrush.executeStroke();
}

public void changeFlip(boolean b)
{

  if (b)
  {
    flipHorizontal=!flipHorizontal;
  } else
  {
    flipVertical=!flipVertical;
  }
}

public void changeBrush(BrushBase brush)
{
  selectedBrush=brush;
  selectedBrush.setBrushColor(brushcolor);
  // cf.setSliderTransparency(selectedBrush.getTransparency());
}

public void switchTransparency()
{
  saveTransparency=!saveTransparency;
}

public void activateTransparency()
{
  if (saveTransparency)
  {
    saveByJDialog(true);
  } else
  {
    saveByJDialog(false);
  }
}

public void debugBar() {
  if (showDebugInfo)
  {
    showDebugInfo=false;
    redraw();
  } else
  {
    showDebugInfo=true;
    redraw();
  }
}

public void hideImage() {
  dragimage.setVisible(!dragimage.getVisible());
}

void grabImage() {
  if (dragimage.getActivateDragImage())
  {
    dragimage.setActivateDragImage(false);
    selectedBrush.setIdle(false);
  } else
  {
    dragimage.setActivateDragImage(true);
    selectedBrush.setIdle(true);
  }
}
void stopRecording()
{
  saveVideo();
  saveVideo=false;
  frameIncrement=0;
 
  
}

void changeSaveVideo()
{
  saveVideo=!saveVideo;
  println(saveVideo);
    frameIncrement=0;
}

// --------------------- change boolean values ------------------------
void pickColor() {
  println("color = "+ (get( mouseX, mouseY)+ " "+selectedBrush.getBrushColor() ));
  selectedBrush.setBrushColor(get( mouseX, mouseY) );
  ;
}


void saveVideo()
{
   if (saveVideo){
  println("creating video");
  String[] arg={"rundll32 SHELL32.DLL,ShellExec_RunDLL ","ffmpeg","-r","1/0.1", "-i", FRAMEFOLDER_PATH,"/frame-%03d.png", "-c:v", "libx264", "-y", "-r",  "30", "-pix_fmt", "yuv420p", "out.mp4"};
  open("rundll32 SHELL32.DLL,ShellExec_RunDLL "+sketchPath("")+"ffmpeg.exe -r 1/0.1 -i "+FRAMEFOLDER_PATH+"/frame-%03d.png -c:v libx264 -y -r  30 -pix_fmt yuv420p "+FRAMEFOLDER_PATH+"\\out.mp4");
  
   }
}

void loadImage() {
  String f="";
  jFileChooser1.setDialogTitle(LOAD_FILE_TEXT);

  //jFileChooser1.setFileFilter(new SimpleFileFilter("jpg"));
  jFileChooser1.setCurrentDirectory(new File(DEFAULT_LOADING_DIRECTORY));
  // try catch ici
  if (jFileChooser1.showOpenDialog(this) == JFileChooser.APPROVE_OPTION) {
    try {
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
  } else
  {
    println("opération annulée");
  }
  println(" fichier "+f);
}

void changeTransparency()
{
  if (!transparencyGizmo.getVisible()) {
    transparencyGizmo.setVisible(true);
    transparencyGizmo.setLoc(mouseX, mouseY);
    selectedBrush.setIdle(true);
  } else
  {
    selectedBrush.setIdle(false);
  }
}

void changeRaduis()
{
  if (!raduisGizmo.getVisible()) {
    raduisGizmo.setVisible(true);
    raduisGizmo.setLoc(mouseX, mouseY);
    selectedBrush.setIdle(true);
  } else
  {
    selectedBrush.setIdle(false);
  }
}
void changeColorWheel()
{
  isColorWheelShowed=!isColorWheelShowed;
  colorWheelX=mouseX-colorWheel.width/2;
  colorWheelY=mouseY-colorWheel.height/2;
}

void setBrushIdle(boolean b)
{
  selectedBrush.setIdle(b); 
  println("brushidle "+b);
}

// --------------------- functions  ------------------------
void clearPg()
{
  pg.beginDraw();
  pg.clear();
  pointsArray=new Point2dArray();
  pg.endDraw();
  selectedBrush.IsCleared();
  image(pg, 0, 0);
}

void chooseColor()
{
  Color selectedBrushColor=new Color( (int)red(brushcolor), (int)green(brushcolor), (int) blue(brushcolor));
  Color c = jColorChooser.showDialog(this, COLOR_CHOOSER_TEXT, selectedBrushColor);
  try {
    brushcolor=color(c.getRed(), c.getGreen(), c.getBlue(), 255);
    selectedBrush.setBrushColor(brushcolor);
  }
  catch( NullPointerException e)
  {
    println(NULL_POINTER_EXCEPTION_TEXT);
  }
}
// ------------------ saveByJDialog --------------------


void  saveByJDialog(boolean transparent)
{ 

  String savename=SAVE_FOLDER+SAVE_NAME+"-"+UtilsFunctions.getDate()+"_"+UtilsFunctions.getHour()+".png";
  JFileChooser chooser = new JFileChooser();
  File f = new File(savename);

  try {
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
        tmppg.rect(0, 0, WIDTH, HEIGHT);
      }

      tmppg.image(pg, 0, 0);


      if (showDebugInfo )
      {
        tmppg.noSmooth();
        tmppg.fill(0, 102, 153);
        tmppg.text(UtilsFunctions.getDate()+" - Lightsaber_"+version, DEBUG_FRAMECOUNT_X, DEBUG_FRAMECOUNT_Y);
        tmppg.smooth();
      }

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

  if (showDebugInfo )
  {
    pgDebug.clear();
    pgDebug.noSmooth();
    pgDebug.fill(0, 102, 153);
    pgDebug.text(DEBUG_X_TEXT+mouseX+DEBUG_Y_TEXT+mouseY+DEBUG_TYPE_TEXT+selectedBrush.getName()+DEBUG_RADUIS_TEXT+selectedBrush.getRayon()+DEBUG_SAVETRANSPARENCY_TEXT+saveTransparency+DEBUG_PRESSEDKEY_TEXT+ " "+
      pressedKey + "saveVideo"+
      saveVideo+DEBUG_INFO_TEXT, 50, 50);
        if (selectedBrush.getIsPlaying()) {
         pgDebug.fill(255, 0, 0); 
       pgDebug.text("> Playing strokes "+selectedBrush.getIncrementStroke()+"/"+UtilsFunctions.strokeList.size(),10,20);
   }
    pgDebug.fill(0, 102, 153);
    pgDebug.text(DEBUG_FRAMECOUNT+frameCount, 50, 63);
    
    pgDebug.fill(0, 102, 153);
    pgDebug.text(UtilsFunctions.getDate()+" - Lightsaber_"+version, DEBUG_FRAMECOUNT_X, DEBUG_FRAMECOUNT_Y);
      pgDebug.beginDraw();
      pgDebug.endDraw();
      image(pgDebug, 0, 0);
  } 
  //
}

// ------------------ mouse --------------------



void mousePressed() {
  //saveVideo=false;
  dragimage.clicked();
  if ((mousePressed && mouseButton == RIGHT)  )
  {
    //selectedBrush.setIdle(false);
  }
}



void mouseReleased() {
  transparencyGizmo.mouseReleased();
  raduisGizmo.mouseReleased();
  selectedBrush.mouseReleased();
  dragimage.stopDragging();
}


void changeScale()
{
  if (flipVertical)
  {

    imageFlip(pg, 300, 600, "v");
    flipVertical=false;
  }

  if (flipHorizontal)
  {

    imageFlip(pg, 300, 600, "h");
    flipHorizontal=false;
  }
}

void drawMirrorMarks()
{
  pgMarks.beginDraw();
  pgMarks.line( WIDTH/2, 0, WIDTH/2, HEIGHT);

  int margin=40;
  int lineLength=60;

  Point2d rep;
  int ht=(HEIGHT-(margin*2))/8;

  for (int i=0; i<=8; i++) {
    rep=new Point2d(WIDTH/2, (margin+ht*i));
    //rep.draw();

    switch(i)
    {
    case 0:
    case 4:
    case 8:
      lineLength=60;
      break;

    case 6:
    case 2:
    case 1:
      lineLength=60;
      break;

    default:
      lineLength=20;
    }

    drawHorizontalMarks(rep, lineLength);
   
  }
  rep=new Point2d(WIDTH/2, (margin+ht*1+ht/3));
  drawHorizontalMarks(rep, lineLength);
  rep=new Point2d(WIDTH/2, (margin+ht*6-ht/2));
  drawHorizontalMarks(rep, lineLength);
  rep=new Point2d(WIDTH/2, (margin+ht*7-ht/2));
 drawHorizontalMarks(rep, lineLength);
   pgMarks.endDraw();
   
}

void showColorWheel() {
  if (isColorWheelShowed)
  {
    image(colorWheel, colorWheelX, colorWheelY);
  }
}

void drawHorizontalMarks(Point2d rep, int lineLength)
{
  pgMarks.line(rep.getX()-lineLength, rep.getY(), rep.getX()+lineLength, rep.getY());
}

// ------------------ ************************** Processing Draw  ****************************************** --------------------
PVector zMousePosition ;
PVector zpMousePosition ;
void draw() {
  background(BACKGROUND_FILL);
  pushMatrix();    // Store a copy of the unzoomed screen transformation.
  zoomer.transform(); // début du pan zoom
// mouse position after zooming
zMousePosition = zoomer.getMouseCoord();
  int mx =int(zMousePosition.x);    // Equivalent to mouseX
  int my =int(zMousePosition.y);    // Equivalent to mouseY
  //println("Mouse at "+mx+","+my);

 // println("Mouse at "+mx+","+my+" zoom : "+ zoomer.getZoomScale());
    noFill();
  rect(mx-10,my-10,20,20);
  

  selectedBrush.setMirrored(isMirrored);
  if (isMirrored)
  {

    drawMirrorMarks();
    pgMarks.beginDraw();
    pgMarks.endDraw();
    image(pgMarks,0,0);
  }




  pg.beginDraw();

  pg.endDraw();
  changeScale();
  image(pg, 0, 0);
  noFill();
  stroke(6);
  rect (0-6,0-6,WIDTH+6,HEIGHT+6);
    
  selectedBrush.draw();

  //  Get the mouse position taking into account any zooming and panning.
  mousePos = zoomer.getMouseCoord();
  
  // Do some drawing that will not be zoomed or panned.
  popMatrix();   // Restore the unzoomed screen transformation.
  
  if(showDebugInfo){
  debugInfo();
  }
  
  showPause();
  dragimage.display();
  showColorWheel();
  drawGizmos();
    pgDebug.beginDraw();
  pgDebug.endDraw();
 //
 
 
  cfFrame.setLocation(frame.getLocation().x-220, frame.getLocation().y);
  
  //saveframe
  if (saveVideo && selectedBrush.getIsPlaying())
  {
      formatter = new DecimalFormat("000");
      String number = formatter.format(frameIncrement);
     // System.out.println("frameIncrement : " + number);
    saveFrame(FRAMEFOLDER_PATH+'\\'+"frame"+"-"+number+".png");
    frameIncrement++;
  }
  zpMousePosition=new PVector(zMousePosition.x,zMousePosition.y);
}



int  frameIncrement=0;


void resetZoom(){
zoomer.reset();
}


// ------------------ gizmo pause gui  --------------------
void showPause()
{
  if (selectedBrush.getIsPlaying()&&showDebugInfo==true)
  {
    if (isPaused) {
      pgDebug.fill(255, 0, 0);
      pgDebug.text ("PAUSE ON (press B)", 20, 80);
    } else {
      pgDebug.fill(150, 0, 0);
      pgDebug.text ("PAUSE OFF (press B)", 20, 80);
    };
    
  pgDebug.beginDraw();
  pgDebug.endDraw();
  image(pgDebug,0,0);
    noFill();
  }
}



void drawGizmos()
{
  if (raduisGizmo.getVisible()) {
    raduisGizmo.draw();
    selectedBrush.setRayon(raduisGizmo.getRaduis());
  }

  if (transparencyGizmo.getVisible()) {
    transparencyGizmo.draw();
    selectedBrush.setTransparency(transparencyGizmo.getRaduis());
  }
}

// ----------------------------------------------------menuAction-------------------------------------------------------------------------------------
void menuAction(ControlEvent theEvent)
{  
  // println("theEvent = "+theEvent.getController().getName());
  // println("theEvent = "+ theEvent.getController().getId());
  int id=theEvent.getController().getId();
  if (id>=0 && id<brushList.size())
  {
    changeBrush(brushList.get(id));
  }
  if(id==999) exitApplication();
  if(id==998) appFolderApplication();
  if(id==997) appFolderTmpApplication();
  if(id==996) appPlayApplication();
  if(id==995) appClearFolderApplication();
  if(id==994) appRecordApplication();
}
// ----------------------------------------------------ControlFrame-------------------------------------------------------------------------------------
ControlFrame addControlFrame(String theName, int theWidth, int theHeight) {
  
  cfFrame = new Frame(theName);
  ControlFrame p = new ControlFrame(this, brushList, theWidth, theHeight);
  cfFrame.add(p);
  p.init();
  cfFrame.setTitle(theName);
  cfFrame.setSize(200, 300);
 
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

// ------------------ other functions  --------------------
//app
void appFolderApplication()
{
  open("start "+sketchPath(""));
}

//app
void appFolderTmpApplication()
{
 open("start "+FRAMEFOLDER_PATH);
println("start "+FRAMEFOLDER_PATH);
}

//app
void appPlayApplication()
{
  if(UtilsFunctions.verifyFileExist(FRAMEFOLDER_PATH+'\\'+"out.mp4"))
  {
  open("start "+FRAMEFOLDER_PATH+'\\'+"out.mp4");
  }
  else
  {
    println(" nothing to play !");
  }
}


//app
void appRecordApplication()
{
saveVideo=true;
playStrokeSession();
}


void appClearFolderApplication()
{
 String[] fileList=UtilsFunctions.listFilesInFolder(FRAMEFOLDER_PATH);
 for(int i=0;i<fileList.length;i++)
 {
   println("deleting "+ fileList[i]);
   UtilsFunctions.deleteFile( FRAMEFOLDER_PATH+'\\'+fileList[i]);
 }
}

//Quit
void exitApplication()
{
  println("exiting gracefully ;)");
  exit();
}

//imageFlip function by nick lally
//paste function at the bottom of your sketch, and use like this: imageFlip(imageName,x,y,"mode")
//modes are "v", "v2", "h", "h2"
//"v" mirrors vertically, "v2" mirrors top half vertically
//"h" mirrors horizontally, "h2" mirrors left half horizontally
void imageFlip(PImage imageName, int xPos, int yPos, String mode) {
  //"v2" flips the top half of the image across the x-axis
  if (mode == "v2") {
    imageName.loadPixels();
    for (int i = 0; i < imageName.height; i++) {
      for (int j = 1; j < imageName.width; j++) {
        imageName.pixels[(imageName.height - 1 - i)*(imageName.width) + j] = imageName.pixels[i*(imageName.width) + j];
      }
    }
    imageName.updatePixels();
    image(imageName, xPos, yPos);

    //"v" flips the entire image across the x-axis
  } else if (mode == "v") {
    imageName.loadPixels();
    int tempImage[] = new int[imageName.width*imageName.height];
    for (int i = 0; i < imageName.width*imageName.height; i++) {
      tempImage[i] = imageName.pixels[i];
    }

    for (int i = 0; i < imageName.height; i++) {
      for (int j = 1; j < imageName.width; j++) {
        imageName.pixels[(imageName.height - 1 - i)*(imageName.width) + j] = tempImage[i*(imageName.width) + j];
      }
    }
    imageName.updatePixels();
    image(imageName, xPos, yPos);

    //"h2" flips the left half of the image across the y-axis
  } else if (mode == "h2") {
    imageName.loadPixels();
    for (int i = 0; i < imageName.height; i++) {
      for (int j = 1; j < imageName.width; j++) {
        imageName.pixels[i*imageName.width + j] = imageName.pixels[(i+1)*(imageName.width) - j];
      }
    }
    imageName.updatePixels();
    image(imageName, xPos, yPos); 

    //"h" flips the entire image across the y-axis
  } else if (mode == "h") {
    imageName.loadPixels();
    int tempImage[] = new int[imageName.width*imageName.height];
    for (int i = 0; i < imageName.width*imageName.height; i++) {
      tempImage[i] = imageName.pixels[i];
    }
    for (int i = 0; i < imageName.height; i++) {
      for (int j = 1; j < imageName.width; j++) {
        imageName.pixels[(i+1)*(imageName.width) - j] = tempImage[i*imageName.width + j];
      }
    }
    imageName.updatePixels();
    image(imageName, xPos, yPos);
  } else {
    println("No mirror direction specified!");
    println("Use v, v2, h, or h2 for the 4th argument");
  }
} 

// -------------------------- Nested classes --------------------------
// Simple class to show how the end of a zoom or pan event can be monitored.
class MyListener implements ZoomPanListener
{
  void panEnded()
  {
    setBrushIdle(false);
    println("Panning stopped");
  }
  
  void zoomEnded()
  {
    setBrushIdle(false);
    println("Zooming stopped");
  }
}

