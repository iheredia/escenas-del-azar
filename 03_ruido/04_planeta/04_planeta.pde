Planet p;
float angle = 0;
float r = 120;

void setup() {
  size(900, 600, OPENGL);
  strokeWeight(6);
  noiseSeed(4);
  
  p = new Planet(width/2, height/2, -r, r);
}

void draw() {
  clear();
  background(20);
  p.draw();
  p.rotate(angle);
  angle += 0.03;
  camera(width/2.0, height/2.0-r*2, r, width/2.0, height/2.0-r, 0, 0, 1, 0);
}



