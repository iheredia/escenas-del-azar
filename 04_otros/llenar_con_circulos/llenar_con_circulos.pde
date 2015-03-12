// Se quiere llenar la pantalla con circulos que no se superpongan, y cuyas coordenadas esten elegidas al azar
// Si se eligen coordenadas al azar sin restricciones y despues se chequea si se puede dibujar ahi (es decir, no se superpone con un circulo ya dibujado) se puede llegar a esperar muuucho tiempo hasta que se llene todo el espacio
// En cambio, si se lleva registro de los puntos en los cuales esta permitido dibujar, en cada iteracion se elige un punto al azar dentro de estos y el programa llena toda la pantalla sin problemas

boolean spaceLeft = true;
ArrayList<Circle> circles;
ArrayList<PVector> coords;

void setup() {
  size(900, 600);
  noStroke();
  background(220, 240, 240);
  fill(100, 0, 120);
    
  circles = new ArrayList<Circle>();
  coords = new ArrayList<PVector>();
  for (int x=0; x<width; x++) {
    for (int y=0; y<height; y++) {
      PVector p = new PVector(x, y);
      coords.add(p);
    }
  }
}

void draw() {
  if (spaceLeft) {
    //PVector p = randomCoords();
    PVector p = popRandom();
    Circle c = new Circle(p.x, p.y);
    if (c.canBeDraw) {
      c.draw();
      circles.add(c);
    }
  } else {
    fill(0, 0, 200, 50);
    rect(0, 0, width, height);
    noLoop();
  }
}

PVector randomCoords() {
  float x = random(width);
  float y = random(height);
  PVector p = new PVector(x, y);
  return p;
}

PVector popRandom() {
  int i = floor(random(coords.size()));
  return coords.get(i);
}

class Circle {
  float x, y, diam;
  float maxDiam = 300;
  float minDiam = 10;
  float distanceBetween = 4;
  boolean canBeDraw;

  Circle(float x_, float y_) {
    x = x_;
    y = y_;
    setDiam();
    updateCoords();
  }
  
  void setDiam() {
    diam = maxDiam;
    for (int i=0; i<circles.size(); i++) {
      Circle circle = circles.get(i);
      float distance = dist(x, y, circle.x, circle.y) - circle.diam/2.0;
      diam = min(diam, distance*2);
    }
    diam -= distanceBetween;
    canBeDraw = diam >= minDiam;
  }
  
  void updateCoords() {
    ArrayList<PVector> temp = new ArrayList<PVector>();
    for (int i=0; i<coords.size(); i++) {
      PVector p = coords.get(i);
      float distance = dist(x, y, p.x, p.y);
      if (distance >= diam/2 + distanceBetween) {
        temp.add(p);
      }
    }
    coords = temp;
    spaceLeft = coords.size() > 0;
  }
  
  boolean inside(PVector p) {
    return dist(x, y, p.x, p.y) <= diam/2;
  }
  
  void draw() {
    ellipse(x, y, diam, diam);
  }
}
