class DragImage extends Draggable {
  PImage img;
  boolean activateDragImage=false;
  boolean visible=false;
  int transparency=255;

  DragImage(String s, float tempX, float tempY) {
    x = tempX;
    y = tempY;

    offsetX = 0;
    offsetY = 0;
    initImage(s);
  }

  void setActivateDragImage(boolean b)
  {
    activateDragImage=b;
  }

  boolean  getActivateDragImage()
  {
    return activateDragImage;
  }

  void initImage(String s)
  {   
    img= loadImage(s);
    w = img.width;
    h = img.height;
  }


  void setTransparency(int i)
  {
    transparency=i;
  }

  int setTransparency()
  {
    return transparency;
  }


  void setVisible(boolean b)
  {
    visible=b;
  }

  boolean  getVisible()
  {
    return visible;
  }

  void display() {

    if (!visible)
    {
      return;
    }


    if (activateDragImage)
    {
      rollover(mouseX, mouseY);
      drag(mouseX, mouseY);
      stroke(255, 255, 0);
    } else
    {
      stroke(125, 125, 125);
    }
    background(204);
    rect(x-1, y-1, w+1, h+1);

    // tint(255,255,255, transparency);
    image(img, x, y);
  }
}

