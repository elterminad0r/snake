float cellSize;
int onFrame;
int xlen, ylen;
PFont f;
boolean paused, gg, ez;

/*

  1
2   4
  3

*/

class Food {
  int x, y;

  Food() {
    boolean taken = true;

    while(taken) {
      taken = false;

      this.x = (int)(random(width / (2 * cellSize))) * 2;
      this.y = (int)(random(height / (2 * cellSize))) * 2;

      for (SnakeComponent s: snake.body) {
        if (this.collides(s)) {
          taken = true;
        }
      }

      if (this.x > xlen | this.y > ylen) {
        taken = true;
      }
    }
  }

  boolean collides(SnakeComponent s) {
    return (s.x == this.x & s.y == this.y);
  }

  boolean collides(int x, int y) {
    return (x == this.x & y == this.y);
  }

  void drawfood() {
    stroke(255);
    fill(255);
    ellipse(this.x + 0.5, this.y + 0.5, 1, 1);
  }
}

Food food;

class SnakeComponent {
  int x, y, relatprev, relataft;

  SnakeComponent(int x, int y, int relatprev, int relataft) {
    this.x = x;
    this.y = y;
    //println(this.x, this.y);
    this.relatprev = relatprev;
    this.relataft = relataft;
  }

  void drawcomponent() {
    /*pushMatrix();

    translate(this.x + 0.5, this.y + 0.5);

    if (this.relatprev == 0) {
      this.drawtail();
    } else if (this.relataft == 0) {
      this.drawhead();
    } else if (abs(this.relatprev - this.relataft) == 2) {
      this.drawstraight();
    } else {
      this.drawcurve();
    }

    popMatrix();*/

    rect(this.x, this.y, 1, 1);
  }

  void drawstraight() {
    rotate((relatprev % 2) * PI);

    rect(-0.5, -0.25, cellSize, 0.5);
  }

  void drawcurve() {
    switch (relatprev * relataft) {
      case 6:
        rotate(QUARTER_PI);
        break;
      case 12:
        rotate(HALF_PI);
        break;
      case 4:
        rotate(HALF_PI + QUARTER_PI);
        break;
    } 

    rect(0, -0.25, 0.25, 0.5);
    rect(0, 0.25, 0.5 + 0.25, 0.25);

    arc(-0.25, 0.25, 0.5, 0.5, 0, HALF_PI);

    stroke(0);
    fill(0);

    arc(-0.5, 0.5, 0.25, 0.25, 0, HALF_PI);

    stroke(255);
    fill(255);
  }

  void drawtail() {
    rotate((3 - this.relataft) * HALF_PI);

    rect(-0.25, 0, 0.5, 0.5);
    triangle(-0.25, 0, 0, -0.25, 0.25, 0);
  }

  void drawhead() {
    rotate((3 - this.relatprev) * HALF_PI);

    rect(-0.25, 0, 0.5, 0.5);

    arc(0, 0, 0.5, 0.5, PI, 2 * PI);
  }

  boolean collides(int x, int y) {
    return (this.x == x & this.y == y);
  }
}

class Snake {
  ArrayList<SnakeComponent> body = new ArrayList<SnakeComponent>();
  int dir = 4;
  int pend_dir = 4;
  boolean doGrow = false;
  int size;

  Snake(int size) {
    this.size = size;

    this.body.add(new SnakeComponent(0, 0, 0, 4));

    for (int i = 1; i < size - 1; i++) {
      this.body.add(new SnakeComponent(2 * i, 0, 2, 4));
    }

    this.body.add(new SnakeComponent(2 * (size - 1), 0, 2, 0));
  }

  void drawsnake() {
    for (int i = 0; i < this.body.size(); i++) {
      float rth = i / (this.body.size() * 1.0) * 2 * PI;
      float gth = rth + 2 * PI / 3;
      float bth = rth + 4 * PI / 3;
      
      float r = (sin(rth) + 1) * 255 / 2.0;
      float g = (sin(gth) + 1) * 255 / 2.0;
      float b = (sin(bth) + 1) * 255 / 2.0;

      stroke(r, g, b);
      fill(r, g, b);
      this.body.get(i).drawcomponent();
    }
  }

  void doFrame() {
    this.dir = this.pend_dir;
    SnakeComponent h = this.body.get(this.body.size() - 1);
    h.relataft = dir;

    int xdiff, ydiff;

    switch (this.dir) {
      case 1:
        xdiff = 0;
        ydiff = 2;
        break;
      case 2:
        xdiff = -2;
        ydiff = 0;
        break;
      case 3:
        xdiff = 0;
        ydiff = -2;
        break;
      case 4:
        xdiff = 2;
        ydiff = 0;
        break;
      default:
        xdiff = 0;
        ydiff = 0;

    }


    if ((!doGrow) & (!ez)) {
      this.body.remove(0);
      this.body.get(0).relatprev = 0;
    } else {
      doGrow = false;
    }

    int tx = h.x + xdiff;
    int ty = h.y + ydiff;

    if (food.collides(tx, ty)) {
      doGrow = true;
      food = new Food();
    }

    if (!gg) {
    for (SnakeComponent s: this.body) {
      if (s.collides(tx, ty)) {
        setup();
        break;
      }
    }
    }

    if (tx < 0 | ty < 0 | tx > xlen | ty > ylen) {
      setup();
    }

    this.body.add(new SnakeComponent(tx, ty, (this.dir + 2) % 4, 0));

  }
}

Snake snake;

void setup() {
  size(1500, 800);

  frameRate(60);

  stroke(255);
  fill(255);
  
  f = createFont("Arial", 1, true);

  cellSize = 25;

  xlen = (int)(width / cellSize) - 2;
  ylen = (int)(height / cellSize) - 2;

  onFrame = 0;
  
  paused = false;
  ez = false;
  gg = false;

  if (xlen % 2 == 0) {
    xlen -= 1;
  }
  if (ylen % 2 == 0) {
    ylen -= 1;
  }

  snake = new Snake(5);
  food = new Food();
}

void keyPressed() {
  int newdir;

  switch (keyCode) {
    case LEFT:
      newdir = 2;
      break;
    case UP:
      newdir = 3;
      break;
    case RIGHT:
      newdir = 4;
      break;
    case DOWN:
      newdir = 1;
      break;
    case 'R':
      setup();
      newdir = 0;
      break;
    case 'P':
    case ' ':
      paused = !paused;
      newdir = 0;
      break;
    case 'X':
      ez = !ez;
      newdir = 0;
      break;
    case 'Z':
      gg = !gg;
      newdir = 0;
      break;
    default:
      newdir = 0;
      break;
  }
  
  //println(newdir);

  if (newdir % 4 != (snake.dir + 2) % 4 & newdir != 0) {
    snake.pend_dir = newdir;
  }
}

void draw() {
  if(!paused) {
  if (onFrame % 10 == 0) {
  snake.doFrame();

  //println(food.x, food.y);

  scale(cellSize);
  translate(0.75, 0.75);

  background(100);
  stroke(0);
  fill(0);
  rect(0, 0, xlen, ylen);
  stroke(255);
  fill(255);

  snake.drawsnake();
  food.drawfood();

  stroke(0);
  fill(0);
  rect(1, 0.6, 6, 0.4);
  
   
  stroke(0, 255, 0);
  fill(0, 255, 0);
  textFont(f, 1);
  text("score " + String.valueOf(snake.body.size() - 5), 1, 1);
  }
  
  onFrame++;
  }
}