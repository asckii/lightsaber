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
  




static boolean verifyFileExist(String s){
  
  File f = new File(s);
 boolean b;
    if(f.exists()){
      b=true;
    }else{
      b=false;
    }
    return b;
}

  
  
static String[] listFilesInFolder(String s){
      // Directory path here
  String path = s; 
 
  String files;
  File folder = new File(path);
  File[] listOfFiles = folder.listFiles(); 
 String[] filelist=new String[listOfFiles.length];
  for (int i = 0; i < listOfFiles.length; i++) 
  {
 
   if (listOfFiles[i].isFile()) 
   {
   files = listOfFiles[i].getName();
      filelist[i]=files;
         
       
     }
  }
return filelist;
}
  
  
  static boolean deleteFile(String s)
  {
     boolean b=false;
    try{
 
        File file = new File(s);
        
        if(file.delete()){
          System.out.println(file.getName() + " is deleted!");
          b=true;
        }else{
          System.out.println("Delete operation is failed.");
          b=false;
        }
 
      }catch(Exception e){
 
        e.printStackTrace();
    
      }
      return b;
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

