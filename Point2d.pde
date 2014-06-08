class Point2d
{
  int p2dx;
  int p2dy;

  Point2d()
  {
  }


  Point2d(int x, int y)
  {
    p2dx=x;
    p2dy=y;
  }

  int getX()
  {
    return p2dx;
  }

  int getY()
  {
    return p2dy;
  }
  String toString()
  {
    return this.getX()+" "+this.getY();
  }

  float distance(Point2d p)
  {
    return dist((float)this.getX(), (float)this.getY(), (float) p.getX(), (float) p.getY());
  }

  void display()
  {
    println(this.toString());
  }

  void draw() {
    ellipse(p2dx, p2dy, 8, 8);
  }

  void draw(PGraphics pg) {
    pg.stroke(204, 102, 0);
    pg.ellipse(p2dx, p2dy, 8, 8);
  }
}

