class Bullet extends GameObject
{
  int link;
  int score;
  float speedX;
  float speedY;
  float gravity;
  
  Bullet(PVector pos, float speedX, float speedY)
  {
    this.speedX = speedX;
    this.speedY = speedY;
    this.pos = new PVector(pos.x, pos.y);
    this.size = width/30;
    this.gravity = unit/2;
    this.link = 0;
    this.score = 0;
  }
  
  void render()
  {
    pushMatrix();
    translate(pos.x, pos.y);
    
    if(speedY > 0)
    {
      fill(200);
      stroke(200);
    }
    else
    {
      fill(150);
      stroke(150);
    }
    
    ellipse(0, 0, size, size);
    popMatrix();
  }
  
  void move()
  {
    pos.x = pos.x-speedX;
    pos.y = pos.y-speedY;
    
    if(pos.x > width-size/2 || pos.x < 0+size/2)
    {
      if(pos.y > 0-unit*100)
      {
        Wave w = new Wave(pos);
        Objects.add(w);
      }
      speedX = -speedX;
    }
    
    if(speedY > -unit*40)
    {
      speedY = speedY-gravity;
    }
  }
  
  void addScore()
  {
    if(link >= 3)
    {
      combo = combo + link*2;
      links = link;
      textTrans = 200;
      score = link * 2;
    }
    else
    {
      combo = combo + link;
      score = link;
    }
  }
  
  void destroy()
  {
    if(pos.y > height)
    {
      addScore();
      Score s = new Score(score, pos.x);
      Objects.add(s);
      Objects.remove(this);
    }
  }
}