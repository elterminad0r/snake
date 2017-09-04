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