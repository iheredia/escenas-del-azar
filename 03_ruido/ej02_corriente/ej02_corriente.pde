// Segun noise() en cada momento decido si cada circulo se mueve hacia arriba o hacia abajo

ArrayList<Circle> circles;

void setup() {
  size(900, 600);
  noStroke();
  background(20, 0, 0);
  
  circles = new ArrayList<Circle>();
  for (int i=0; i<100; i++) {
    Circle c = new Circle();
    circles.add(c);
  }
}

void draw() {
  fill(0, 30);
  rect(0, 0, width, height);
  for (int i=0; i<circles.size(); i++) {
    Circle c = circles.get(i);
    c.move();
    c.draw();
  }
}

class Circle {
  float x, y;
  
  Circle() {
    x = random(width);
    y = random(height);
  }

  void move() {
    x++;
    if (x > width + 10) {
      x = -10;
      y = random(height);
    }
  }
  
  void draw() {
    fill(200, 0, 0);
    float n = noise(x*0.005, y*0.01)*50;
    ellipse(x, y + n, 8, 8);
  }
}
