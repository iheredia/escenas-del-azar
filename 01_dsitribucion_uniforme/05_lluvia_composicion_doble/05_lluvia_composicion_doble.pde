ArrayList<Drop> drops = new ArrayList<Drop>();
Floor floor;

void setup() {
  size(900, 600);
  for (int i=0; i<200; i++) {
    Drop d = new Drop();
    drops.add(d);
  }
  noStroke();
  floor = new Floor();
}

void draw() {
  fill(10, 50);
  rect(0, 0, width, height);
  
  fill(130, 240, 240);
  for (int i=0; i<drops.size(); i++) {
    Drop d = drops.get(i);
    d.move();
    d.draw();
  }  
  floor.draw();
}

class Drop {
  float x, y;
  int size = 4;
  int speed = 6;
  
  Drop() {
    x = random(random(0, width/3), random(width*2/3, width));
    y = random(0, height);
  }

  void move() {
    y += speed;
    if (y > height) {
      floor.heights[int(x)] -= 2;
      x = random(random(0, width/3), random(width*2/3, width));
      y = 0;
    }
  }
  
  void draw() {
    ellipse(x, y, size, size);
  }
}

class Floor {
  float[] heights;

  Floor() {
    heights = new float[width];
    for (int x=0; x<width; x++) {
      heights[x] = height;
    }
  }

  void draw() {
    fill(255, 160, 3);
      for (int x=0; x<width; x++) {
        rect(x-1, heights[x], 3, height);
      }
  }  
}
