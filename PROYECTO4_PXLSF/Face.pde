class Face {

  Rectangle r;

  boolean available;

  boolean delete;

  int timer = 127;

  int id;
  
  
  Face(int newID, int x, int y, int w, int h) {
    r = new Rectangle(x,y,w,h);
    available = true;
    delete = false;
    id = newID;
  }

  void display() {
    fill(0,0,255,timer);
    stroke(0,0,255);
    rect(r.x,r.y,r.width, r.height);
    
    fill(255,timer*2);
    text(""+id,r.x+10,r.y+30);
     for (int j = r.x; j < r.width; j+=10) {
      for (int i = r.y; i < r.height; i+=10) {
        color mC;
        mC = cam.get(r.x,r.y);
        noStroke();
        fill(mC);
        rect(r.x,r.y,10,10);
      }
    }
 
  }

  
  void update(Rectangle newR) {
    r = (Rectangle) newR.clone();
  }

  
  void countDown() {
    timer--;
  }

  
  boolean dead() {
    if (timer < 0) return true;
    return false;
  }
}
