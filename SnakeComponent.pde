class SnakeComponent {
  int x, y, relatprev, relataft;

  SnakeComponent(int x, int y, int relatprev, int relataft) {
    this.x = x;
    this.y = y;
    this.relatprev = relatprev;
    this.relataft = relataft;
  }

  void drawcomponent() {
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
