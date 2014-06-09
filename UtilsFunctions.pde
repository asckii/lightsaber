import java.io.File;
static class UtilsFunctions
{
  static List<Stroke> strokeList;
  static float pdopreviousX, pdopreviousY, previousX, previousY;
  UtilsFunctions()
  {
  }

  static String getHour()
  {
    String s = str(second());  
    String mn = str(minute());  
    String h = str(hour());  
    return h+mn+s;
  }

  static String  getDate()
  {
    String d = str(day());   
    String m = str(month());  
    String y = str(year());  
    return d+m+y;
  }
  
  static void createFolder(String directoryName)
  {
    
    File theDir = new File(directoryName);

  // if the directory does not exist, create it
  if (!theDir.exists()) {
    println("creating directory: " + directoryName);
    boolean result = false;

    try{
        theDir.mkdir();
        result = true;
     } catch(SecurityException se){
        System.out.println("-->SECURITY EXCEPTION !");  
     }        
     if(result) {    
       System.out.println("DIR created");  
     }
  }
  
  }
  
}

