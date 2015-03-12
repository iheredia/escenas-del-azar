void setup() {
  size(900, 600);
  randomSeed(13);
  noStroke();
  colorMode(HSB, 360, 100, 100);
  noLoop();
}

void draw() {
  background(340);
  drawNoise(1, width/18, width*5/18);
  drawNoise(25, width*6/18, width*11/18);
  drawNoise(50, width*12/18, width*17/18); 
}

void drawNoise(int rectSize, int from, int to) {
  float xNoise = 0;
  for (int x=from; x<to; x+=rectSize) {
    for (int y=50; y<height-50; y+=rectSize) {
      float n = noise(xNoise, y*0.01);
      n = map(n, 0, 1, -20, 20);

      float h = 0;
      float s = 90;
      float b = 70 + n;

      color c = color(h, s, b);
      fill(c);
      rect(x, y, rectSize, rectSize);
    }
    xNoise += 0.01*rectSize;
  }
}
