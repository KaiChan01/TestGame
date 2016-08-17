class Block extends GameObject
{
  float speed;
  float rotSpeed;
  int rot;
  int partNum;
  color c;
  
  Block()
  {
    this.partNum = (int)random(4, 10);
    this.rot = (int)random(0,2);
    this.size = unit*100;
    this.speed = random(unit, 5*unit);
    this.rotSpeed = 0;
    this.pos = new PVector(random(size/2, width-(size/2)), 0-size);
    this.c = color(random(100,255),random(100,255),random(100,255));
  }
  
  void render()
  {
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(rotSpeed);
    rectMode(CENTER);
    stroke(c);
    fill(c);
    rect(0, 0, size, size);
    popMatrix();
  }
  
  void move()
  {
    pos.y += speed;

    switch (rot)
    {
      case 0:
      {
        rotSpeed += 0.01f;
      }
      
      case 1:
      {
        rotSpeed += 0.02f;
      }
      
      case 2:
      {
        rotSpeed += 0.03f;
      }
    }
  }
  
  void party()
  {
    /*for(int i = 0; i < partNum; i++)
    {
      Particle p = new Particle(c, pos);
      Objects.add(p);
    }*/
    
    WaveTest w = new WaveTest(pos, c);
    Objects.add(w);
  }
  
  void destroy()
  {
    if(pos.y > height+size)
    {
      Objects.remove(this);
      lives--;
    }
  }
}