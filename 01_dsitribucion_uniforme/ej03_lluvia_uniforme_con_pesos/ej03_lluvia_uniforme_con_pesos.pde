// Lluvia que cae con distintas intensidades
// La logica para elegir donde cae la lluvia esta en la funcion 'randomArea'

ArrayList<Drop> drops = new ArrayList<Drop>();
Floor floor;

void setup() {
  size(900, 600);
  for (int i=0; i<200; i++) {
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
    x = randomArea();
    y = random(height);
  }
  
  void move() {
    y += speed;
    if (y > height) {
      floor.heights[int(x)] -= 2;
      x = randomArea();
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

float randomArea() {
  // Intervalos en los cuales caera lluvia:
  float[][] intervals = { 
    { 0, width*0.2 }, 
    { width*0.3, width*0.6 },
    { width*0.9, width }
  } ;
  // Pesos relativos para cada intervalo
  // Por ej, teniendo pesos 4, 2 y 1, en el primer intervalo caera el doble de lluvia que en el segundo, y cuatro veces mas que en el tercero. 
  // A su vez, en el segundo intervalo caera el doble que en el tercero 
  float[] weights = { 4, 2, 1 };
  
  float totalSum = 0;
  for (int i=0; i<weights.length; i++) {
    totalSum += weights[i] * (intervals[i][1] - intervals[i][0]);
  }
  float r = random(totalSum);
  float partialSum = 0;
  for (int i=0; i<weights.length; i++) {
    partialSum += weights[i] * (intervals[i][1] - intervals[i][0]);
    if (r < partialSum) {
      return random(intervals[i][0], intervals[i][1]);
    }
  }
  return random(intervals[intervals.length-1][0], intervals[intervals.length-1][1]);
}
