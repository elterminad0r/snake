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


