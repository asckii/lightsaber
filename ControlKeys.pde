import java.awt.event.KeyEvent;
boolean alt = false;
boolean  shift= false;
boolean ctrl = false;

boolean[] keys = new boolean[526];
int activeKey;
boolean tab = false;
boolean enter = false;
boolean bkspace = false;
boolean ret = false;
boolean esc = false;
boolean del = false;


public class ControlKeys {
  lightsaber parent;
  boolean[] keys = new boolean[526];
  public ControlKeys(Object theParent) {
    parent=((lightsaber)theParent);
  }

  void draw() {
 
  }

  boolean checkKey(int k)
  {
    if (keys.length >= k) {
      return keys[k];
    }
    return false;
  }

  int keySum()
  {
    int result=0;
    if (alt) result=result+2;
    if (shift) result=result+4;
    if (ctrl) result=result+8;
    return result;
  }

  void keyPressed()
  { 
    char character=(char)keyCode;//KeyEvent.getKeyText(keyCode).charAt(0);
   int ks=0 ;
 
     if (key == CODED) {
      if (keyCode == ALT) {alt = true;}else{alt = false;}; 
      if (keyCode == SHIFT) {shift = true;}else{shift = false;}; 
      if (keyCode == CONTROL) {ctrl = true;}else{ctrl = false;};
          println("coded"+key);
     
    }
  
    if ((keyCode != ALT)&&(keyCode != SHIFT)&&(keyCode != CONTROL))
    {
        if (keyCode == BACKSPACE) {bkspace = true;}else{bkspace = false;};
       
      if (keyCode == TAB) {tab = true;}else{tab = false;};
      if (keyCode == ENTER) {enter = true;}else{enter = false;};
      if (keyCode == RETURN) {ret = true;}else{ret = false;};
      if (keyCode == ESC) {esc = true;}else{esc = false;};
       
    // println(keyCode+" "+character+" " +KeyEvent.getKeyText(keyCode)+" "  +" alt "+alt+" ctrl "+ctrl+" shift "+shift + " keysum "+keySum()+" "+checkKey(key));

       if (bkspace)  parent.clearPg();
    }

    if ((keyCode != ALT)&&(keyCode != SHIFT)&&(keyCode != CONTROL))
    {
      
      ks=keySum();
      switch (character)
      {

      case '1':
        parent.changeBrush(brushjpen);
        break;

      case '2':
        parent.changeBrush(brushMotif);
        break;

      case '3':
        parent.changeBrush(brushlink);
        break;

      case '4':
        parent.changeBrush(brushsimple);
        break;

      case '5':
        parent.changeBrush(brushrandom);
        break;

      case '6':
        parent.changeBrush(brusherase);
        break;

      case 'D': //d
        parent.debugBar();
        break;

   case 'P': 
       if (ks==0) {
          println("playStrokeSession");
           parent.playStrokeSession();
          } else
          if (ks==8) {
            println("replay brush");
            parent.replayBrush();
           
          }
      if (ks==4) {
            println("replay brush");
            startStrokeSession();
           
          }
        break;

  

      case 'S'://save !!!
      if (ks==0) {
        parent.activateTransparency();
        } else
          if (ks==8) {
          
          }
          else
          if (ks==4) {
                      
          }
        
        break;

      case 'T':
        parent.switchTransparency();
        break;

      case 'N':
        if (keySum()==8) {
          parent.clearPg();
        }
        break;

      case 'R':// r
         parent.changeRaduis();
        break;
        
      

      case 'G': // g  grab drag and drop
         parent.grabImage();
        break;

      case 'H': // h visible true false
        parent.hideImage();
        break;

      case 'L':
         parent.loadImage();
        break; 

  case ' ':
   parent.changeRaduis();
         print('.');
        break; 
        
      case 'C':
        if (ks==0) {
           parent.pickColor();
           //println("pick color");
          } else
          if (ks==8) {
           // parent.chooseColor(); legacy
            changeColorWheel();
         // println("choose color");
           ctrl=false;
          }
        break;

      case 'X': 
        if (ks==0) {
           parent.changeFlip(true);
        } else
        if (ks==8) {
           parent.changeFlip(false);
           
        }
        break;

   
      case 'O': 
         parent.switchTransparency();
      break;
 
        
      

      case 'M': 
         parent.changeMirrorMode();
      break;


      
        default:
//println("traitement par défaut");
      }
      
      
      
      
    }
  }

  void keyReleased()
  { 

    keys[keyCode] = false;
  
    if (keyCode == ALT) alt = false; 
    if (keyCode == SHIFT) shift = false; 
    if (keyCode == CONTROL) ctrl = false;
   
  //println(  " alt "+alt+" ctrl "+ctrl+" shift "+shift );
       
   
  }
}

/*  case 'A':
 if (keySum()==0){
 println(" un simple A");
 }
 if (keySum()==2){
 println(" un A+alt");
 }
 if (keySum()==4){
 println(" un A+shift");
 }
 if (keySum()==8){
 println(" un A+ctrl");
 }
 break;*/

/*
void keyPressed() {
 pressedKey=str(keyCode); 
 selectedBrush.keyPressed();
 boolean isShiftPressed=false;
 
 switch(keyCode)
 {
 
 case 68: //d
 debugBar();
 break;
 
 case 83://o
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
 
 case 65:// a
 chooseColor();
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
 
 case 66: // .
 changeMirrorMode();
 break;
 
 
 case 513: // /
 startStrokeSession();
 break;
 
 }
 }
 */
