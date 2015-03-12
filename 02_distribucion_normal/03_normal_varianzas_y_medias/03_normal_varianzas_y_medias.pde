ArrayList<Walker> walkers; 

void setup() {
  size(900, 600);
  frame.setResizable(true);
  randomSeed(4);
  background(255);
  frameRate(40);
  walkers = new ArrayList<Walker>();
  for (int i=0; i<150; i++) {
    Walker w = new Walker(width*0.8, height*0.2, 40, 40);
    walkers.add(w);
  }
  for (int i=0; i<150; i++) {
    Walker w = new Walker(width*0.2, height*0.5, 60, 100);
    walkers.add(w);
  }
  for (int i=0; i<150; i++) {
    Walker w = new Walker(width*0.7, height*0.7, 50, 20);
    walkers.add(w);
  }
  background(40);
}

void draw() {
  fill(40, 40);
  rect(0, 0, width, height);
  for (int i=0; i<walkers.size(); i++) {
    Walker w = walkers.get(i);
    w.step();
    w.draw();
  }
}

class Walker {
  float x, y;
  
  Walker(float centerX, float centerY, float dvx, float dvy) {
    x = randomGaussian() * dvx + centerX;
    y = randomGaussian() * dvy + centerY;
  }

  void draw() {
    noStroke();
    fill(60, 255, 160); // verde
    ellipse(x, y, 7, 7);
    fill(255, 255, 60); // amarillo
    ellipse(x, y, 4, 4);
  }
  
  void step() {
    x += randomGaussian() * 4/3.0;
    y += randomGaussian() * 4/3.0;
  }
}
