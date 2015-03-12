// Ejemplo de como, al elegir coordenadas que tengan una distribucion normal, si la varianza en una coordenada es mayor que en la otra, los puntos caen dentro de una elipse

ArrayList<Walker> walkers; 

void setup() {
  size(900, 600);
  randomSeed(4);
  background(255);
  frameRate(40);
  walkers = new ArrayList<Walker>();
  for (int i=0; i<200; i++) {
    Walker w = new Walker();
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
  
  Walker() {
    float deviationX = 200;
    float deviationY = 50;
    x = randomGaussian() * deviationX + width/2;
    y = randomGaussian() * deviationY + height/2;
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
