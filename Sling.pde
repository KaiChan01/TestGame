int lives;
int spawn;
int stages;
int combo;
int textTrans;
int links;
int second;
int spawnCount;
int currentMin;
int startMin;
int lastMin;

PFont font;
float Xspeed;
float Yspeed;
float unit;
boolean clicked;
PVector mouse;

Basket bask;


ArrayList<GameObject> Objects = new ArrayList<GameObject>();

void setup()
{
  fullScreen(P2D);
  smooth();
  stages = 0;
  font = createFont("airstrike.ttf",width/10);
  textFont(font);
  unit = height/width;
  bask = new Basket();
  clicked = false;
  combo = 0;
  textTrans = 0;
  links = 0;
  spawnCount = 500;
  lives = 3;
  spawn = 1;
  startMin = minute();
  lastMin = 0;
}

void draw()
{
  switch (stages)
  {
    //Menu
    case 0:
    {
      background(240);
      textAlign(CENTER);
      
      // hover colour
      if(mouseY < height/3+100 && mouseY > height/3-100 && mouseX < width/2+200 && mouseX > width/2-200)
      {
          stages = 1;
      }
      else
      {
        fill(0);
      }
      
      text("Play", width/2, height/3);
      break;
    }
    
    //The gameplay
    case 1:
    {
      //println("x = " + mouseX + "y = " + mouseY);
      background(240);
      textSize(width/10);
      mouse = new PVector(mouseX, mouseY);
      //draw some poles
      
      strokeWeight(4);
      stroke(0);
      line(width/5-unit*10,bask.center.y, bask.pos.x, bask.pos.y);
      line((width/5*4)-unit*10, bask.center.y, bask.pos.x, bask.pos.y);
      strokeWeight(1);
      fill(51,25,0);
      rectMode(CORNER);
      rect(width/5-unit*20, bask.center.y-(unit*10), 2*(unit*20), height/3);
      rect((width/5*4)-unit*20, bask.center.y-(unit*10), 2*(unit*20), height/3);
      
      spawn();
      
      if(combo > 0)
      {
        fill(0,153,76);
        text(combo, width/2, (height/7)*6);
      }
      
      bask.render();
      
      for(int i = Objects.size()-1; i >= 0; i--)
      {
        GameObject o = Objects.get(i);
        o.render();
        o.move();
        o.destroy();
        
        //println(Objects.size());
      }
      
      collision();
      showCombo();
      drawLives();
      
      if(lives < 1)
      {
        Objects.clear();
        stages = 2;
      }
      break;
    }
    
    case 2:
    {
      fill(0);
      text("Game Over", width/2, (height/3)*1);
      println("running");
      break;
    }
  }
}


void collision()
{
  for(int i = 0; i < Objects.size(); i++)
  {
    GameObject a = Objects.get(i);
    if(a instanceof Bullet)
    {
      for(int j = 0; j < Objects.size(); j++)
      {
        GameObject b = Objects.get(j);
        if(b instanceof Block)
        {
          if(a.pos.dist(b.pos) < b.size)
          {
            Bullet A = (Bullet) a;
            A.link++;
            //Mad casting
            Block block = (Block) b;
            block.party();
            Objects.remove(b);
          }
        }
      }
    }
  }
}

void showCombo()
{
  stroke(255,51,51,textTrans);
  fill(255,51,51,textTrans);
  text(links + " Combo!!", width/2, height/2);
  
  if(textTrans > 0)
  {
    textTrans -= 2;
  }
}

void clearObjects()
{
  Objects.clear();
}

void spawn()
{
  currentMin = minute()%startMin;
  
  if(currentMin != lastMin)
  {
    if(spawnCount > 250)
    {
      spawnCount = spawnCount - lastMin*50;
      lastMin = currentMin;
    }
  }

  println(spawnCount);
  
  spawn = (int) random(0, spawnCount);
  if(spawn < 5)
  {
     Block b = new Block();
     Objects.add(b);
  }
}

void mouseDragged()
{
  if(stages == 1)
  {
    if(mouse.dist(bask.pos) < bask.size)
    {
      clicked = true;
    }
  
    if(clicked == true)
    {
      if(mouse.dist(bask.center) < (width/4)*2)
      {
        bask.pos = mouse;
      }
    }
  }
} 

void drawLives()
{
  for(int i = 0; i < lives; i++)
  {
    stroke(2550,0,0);
    fill(2550,0,0);
    ellipse((unit*40)*(i+1),unit*40, unit*30, unit*30);
  }
}

void displayScore()
{
  
}

void mouseReleased()
{
  if(stages == 1)
  {
    if(clicked == true)
    {
      Xspeed = map(bask.pos.x - bask.center.x, -300, 300, -50, 50); 
      Yspeed = map(bask.pos.y - bask.center.y, 0, 300, 0, 50);
    
      Bullet bull = new Bullet(bask.center, Xspeed, Yspeed);
      Objects.add(bull);
    }
  
    clicked = false;
    bask.pos = bask.center;
  }
}