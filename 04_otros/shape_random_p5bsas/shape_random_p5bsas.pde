RandomShape p5bsas;

void setup() {
  size(900, 600);
  noStroke();
  background(0);
  
  p5bsas = new RandomShape();
  p5bsas.img = createGraphics(width, height);
  
  p5bsas.img.beginDraw();
  p5bsas.img.background(255);
  p5bsas.img.fill(0);
  p5bsas.img.textAlign(CENTER, CENTER);
  p5bsas.img.textSize(width/6);
  p5bsas.img.text("P5 BSAS", width/2, height/2);
  p5bsas.img.endDraw();
  p5bsas.searchInsidePoints();
}

void draw() {
  fill(10, 5);
  rect(0, 0, width, height);
  int size = 10;  
  PVector p = p5bsas.randomInsidePoint();
  fill(210, 40, 180);
  ellipse(p.x - width/10, p.y - height*0.3, size, size);

  float shapeNoise = 5;
  p = p5bsas.randomInsidePoint(shapeNoise);
  fill(70, 100, 235);
  ellipse(p.x, p.y, size, size);

  shapeNoise = 10;
  p = p5bsas.randomInsidePoint(shapeNoise);
  fill(75, 235, 140);
  ellipse(p.x + width/10, p.y + height*0.3, size, size);
}

class RandomShape {
  
  ArrayList<PVector> insidePoints = new ArrayList<PVector>();
  PGraphics img;
  
  void searchInsidePoints() {
    img.loadPixels();
    for (int i=0; i<img.pixels.length; i++) {
      color c = img.pixels[i];
      if (brightness(c) < 100) {
        float x = i % img.width;
        float y = i / img.width;
        PVector p = new PVector(x, y);
        insidePoints.add(p);
      }
    }
  }
  
  PVector randomInsidePoint(float deviation) {
    int i = floor(random(insidePoints.size()));
    PVector p = insidePoints.get(i);
    float x = p.x;
    float y = p.y;
    if (deviation > 0) {
      x += randomGaussian() * deviation;
      y += randomGaussian() * deviation;
    }
    p = new PVector(x, y);
    return p;
  }
  
  PVector randomInsidePoint() {
    return randomInsidePoint(0);
  }
}
