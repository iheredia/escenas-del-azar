// Coordenadas de la pantalla elegidas al azar
// Los puntos rojos siguen una distribucion uniforme, donde cada coordenada x e y esta restringida segun los parametros de random()
// Los puntos azules siguen una distribucion normal, donde cada coordenada x e y tiene un centro y una distancia, y se obtienen mediante 'centro + randomGaussian() * distancia/3'

void setup() {
  size(900, 600);
  randomSeed(7);
  background(255);
}

void draw() {
  int size = 11;
  int spread = height/5;
  
  noStroke();
  rectMode(CORNER);
  fill(255, 255, 255, 3);
  rect(0, 0, width, height);
  
  uniformRandom(spread, size);
  normalRandom(spread, size);
}

void uniformRandom(int spread, int size) {
  int center_x = width/4;
  int center_y = height/2;
  
  stroke(0);
  noFill();
  rectMode(CENTER);  
  rect(center_x, center_y, spread*2, spread*2);
  
  noStroke();
  fill(200, 0, 0);
  float x = center_x + random(-spread, spread);
  float y = center_y + random(-spread, spread);
  ellipse(x, y, size, size);

}

void normalRandom(int spread, int size) {
  int center_x = width*3/4;
  int center_y = height/2;
  
  stroke(0, 0, 0, 10);
  noFill();
  ellipse(center_x, center_y, spread*2, spread*2);
  
  noStroke();
  fill(0, 0, 200);
  float x = center_x + randomGaussian()*spread/3;
  float y = center_y + randomGaussian()*spread/3;
  ellipse(x, y, size, size);
}
