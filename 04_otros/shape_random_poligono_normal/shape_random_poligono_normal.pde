// Con la idea de elegir puntos al azar dentro de formas mas complejas, se eligen puntos al azar dentro de triangulos
// El primer caso elige puntos solo dentro del triangulo rojo, mientras que el segundo agregan un pequeño error a las coordenadas del triangulo azul mediante una distribucion normal (i.e. llamando a randomGaussian() )

RegularPolygon uniformTriangle, normalTriangle;

void setup() {
  size(900, 600);
  noStroke();
  background(255);
  
  uniformTriangle = new RegularPolygon(3, 160, "uniform");
  normalTriangle = new RegularPolygon(3, 140, "normal");
}

void draw() {
  fill(255, 2);
  rect(0, 0, width, height);
  int size = 9;
  PVector p = uniformTriangle.randomInsidePoint();
  fill(200, 0, 0);
  ellipse(width/4 + p.x, height/2 + p.y, size, size);
  
  p = normalTriangle.randomInsidePoint();
  fill(0, 0, 200);
  ellipse(width*3/4 + p.x, height/2 + p.y, size, size);
}

class Polygon {
  
  ArrayList<PVector> vertexPoints = new ArrayList<PVector>();
  ArrayList<PVector> insidePoints = new ArrayList<PVector>();
  float minX, maxX, minY, maxY;
  PGraphics img;
  int border = 10;
  String mode;
    
  void startPoint(float x, float y) {
    minX = x;
    maxX = x;
    minY = y;
    maxY = y;
    addPoint(x, y);
  }
  
  void addPoint(float x, float y) {
    minX = min(x, minX);
    minY = min(y, minY);
    maxX = max(x, maxX);
    maxY = max(y, maxY);
    PVector p = new PVector(x, y);
    vertexPoints.add(p);
  }
  
  void finalPoint(float x, float y) {
    addPoint(x, y);
    createPolygonImage();
    searchInsidePoints();
  }
  
  void createPolygonImage() {
    int imgWidth = round(maxX - minX + border);
    int imgHeight = round(maxY - minY + border);
    img = createGraphics(imgWidth, imgHeight);
    img.beginDraw();
    img.background(255);
    img.noStroke();
    img.fill(0);
    img.beginShape();
    for (int i=0; i<vertexPoints.size(); i++) {
      PVector p = vertexPoints.get(i);
      float x = p.x - minX + border/2;
      float y = p.y - minY + border/2;
      img.vertex(x, y);
    }
    img.endShape(CLOSE);
    img.endDraw();
  }
  
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
  
  PVector randomInsidePoint() {
    int i = floor(random(insidePoints.size()));
    PVector p = insidePoints.get(i);
    float x = p.x + minX - border/2;
    float y = p.y + minY - border/2;
    if (mode == "normal") {
      x += randomGaussian() * 10;
      y += randomGaussian() * 10;
    }
    p = new PVector(x, y);
    return p;
  }
}

class RegularPolygon extends Polygon {
  
  RegularPolygon(int vertices, int radius, String mode_) {
    mode = mode_;
    float startAngle = vertices % 2 == 0 ? 0 : -HALF_PI;
    for (int i=0; i<vertices; i++) {
      float x = cos(startAngle + TWO_PI*i/vertices) * radius;
      float y = sin(startAngle + TWO_PI*i/vertices) * radius;
      if (i==0) {
        startPoint(x, y);
      } else if (i == vertices-1) {
        finalPoint(x, y);
      } else {
        addPoint(x, y);
      }
    }
  }
}
