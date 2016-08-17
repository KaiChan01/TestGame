class Score extends GameObject
{
  int score;
  float gravity;
  float speedY;
  
  Score(int score, float posX)
  {
    this.score = score;
    this.pos = new PVector(posX, height+unit*30);
    println(posX);
    this.speedY = unit*30;
    this.gravity = unit/2;
  }
  
  void render()
  {
    pushMatrix();
    translate(pos.x, pos.y);
    stroke(0,51,0);
    fill(0,51,0);
    text("+" + score, 0,0);
    popMatrix();
  }
  
  void move()
  {
    pos.y = pos.y-speedY;
    
    if(speedY > -unit*70)
    {
      speedY = speedY-gravity;
    }
  }
    
  void destroy()
  {
    if(pos.y > height+unit+20)
    {
      Objects.remove(this);
    }
  }
}