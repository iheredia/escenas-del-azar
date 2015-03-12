// Lluvia cuya posicion x esta dada por una distribucion uniforme
// Al iniciar el sketch se inicializan tantas gotas como 'rainAmount'
// Cada vez que una gota se va de la pantalla, le asigna una nueva coordenada x al azar y se resetea su altura
// En la base de la pantalla se muestra la lluvia acumulada

ArrayList<Drop> drops = new ArrayList<Drop>();
Floor floor;
int rainAmount = 200;

void setup() {
  size(900, 600);
  for (int i=0; i<rainAmount; i++) {
    Drop d = new Drop();
    drops.add(d);
  }
  floor = new Floor();
  noStroke();
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
    x = random(width);
    y = random(height);
  }
  
  void move() {
    y += speed;
    if (y > height) {
      floor.heights[int(x)] -= 2;
      y = 0;
      x = random(width);
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
