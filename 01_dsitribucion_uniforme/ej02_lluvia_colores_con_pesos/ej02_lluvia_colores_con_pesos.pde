// Lluvia cuyos colores se eligen al azar del array 'colors' usando los pesos dados en 'weights' 
// Por ej, si los pesos son 75, 20 y 5, entonces aproximadamente cada 100 gotas, 75 seran del primer color, 20 del segundo y 5 del tercero
// La logica para traducir los colores y sus pesos se encuentra en la funcion 'randomColor'

color[] colors = { color(130, 240, 240), color(150, 25, 200), color(200, 0, 0) };
float[] weights = { 75, 20, 5 };
ArrayList<Drop> drops = new ArrayList<Drop>();
  
void setup() {
  size(900, 600);
  for (int i=0; i<200; i++) {
    Drop d = new Drop();
    drops.add(d);
  }
  noStroke();
}

void draw() {
  fill(10, 50);
  rect(0, 0, width, height);

  for (int i=0; i<drops.size(); i++) {
    Drop d = drops.get(i);
    d.move();
    d.draw();
  }  
}

class Drop {
  float x, y;
  int size = 4;
  int speed = 6;
  color c;
  
  Drop() {
    x = random(width*0.2, width*0.8);
    y = random(0, height);
    c = randomColor();
  }
  
  void move() {
    y += speed;
    if (y > height) {
      x = random(width*0.2, width*0.8);
      y = 0;
      c = randomColor();
    }
  }
  
  void draw() {
    fill(c);
    ellipse(x, y, size, size);
  }
}


color randomColor() {
  float totalSum = 0;
  for (int i=0; i<weights.length; i++) {
    totalSum += weights[i];
  }
  float r = random(totalSum);
  float partialSum = 0;
  for (int i=0; i<weights.length; i++) {
    partialSum += weights[i];
    if (r < partialSum) {
      return colors[i];
    }
  }
  return colors[colors.length-1];
}
