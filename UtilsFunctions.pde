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
}

