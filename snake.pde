float cellSize;
int onFrame;
int xlen, ylen;
PFont f;
boolean paused, gg, ez;

Food food;

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

  if (newdir % 4 != (snake.dir + 2) % 4 & newdir != 0) {
    snake.pend_dir = newdir;
  }
}

void draw() {
  if (!paused) {
    if (onFrame % 10 == 0) {
      snake.doFrame();

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
      //rect(1, 0.6, 6, 0.4);


      stroke(0, 255, 0);
      fill(0, 255, 0);
      textFont(f, 1);
      println("score " + String.valueOf(snake.body.size() - 5));
      text("score " + String.valueOf(snake.body.size() - 5), 1, 1);
    }

    onFrame++;
  }
}
