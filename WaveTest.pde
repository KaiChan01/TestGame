class WaveTest extends GameObject
{
  int trans;
  int cenTrans;
  int change;
  float waveSize;
  float center;
  float center2;
  color wave;
  
  WaveTest(PVector position, color c)
  {
    this.pos = position;
    this.center = unit*40;
    this.center2 = unit*30;
    this.trans = 255;
    this.cenTrans = 0;
    this.change = 5;
    this.waveSize = unit*100;
    this.wave = c;
    
  }
  
  void render()
  {
    pushMatrix();
    translate(pos.x, pos.y);
    stroke(wave,trans);
    fill(wave,trans);
    ellipse(0, 0, waveSize, waveSize);
    
    stroke(230, cenTrans);
    fill(230, cenTrans);
    ellipse(0, 0, center, center);
    
    stroke(wave,trans);
    fill(wave,trans);
    ellipse(0, 0, center2, center2);
    popMatrix();
  }
  
  void move()
  {
      waveSize += unit*2;
      trans -= 2;
      
      if(cenTrans > 255)
      {
        change = -change;
      }
      
      cenTrans += change;
  }
  
  void destroy()
  {
    if(trans <= 0)
    {
      Objects.remove(this);
      //rewind();
    }
  }
}