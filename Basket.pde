class Basket extends GameObject
{
  PVector center;
  
  Basket()
  {
    this.center = new PVector(width/2,(height/4)*3);
    this.pos = new PVector(width/2,(height/4)*3);
    this.size = unit*100;
  }
  
  void render()
  {
    pushMatrix();
    translate(pos.x,pos.y);
    stroke(255);
    fill(255,178,102);
    ellipse(0,0,size,size);
    stroke(102,51,0);
    fill(255,0,0);
    ellipse(0,0,size/2,size/2);
    popMatrix();
  }
}