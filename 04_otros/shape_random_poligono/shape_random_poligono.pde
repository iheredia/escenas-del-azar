Polygon triangle, pentagon, hexagon, heptagon, cross;

void setup() {
  size(900, 600);
  noStroke();
  background(255);
  
  triangle = new RegularPolygon(3, 120);
  pentagon = new RegularPolygon(5, 120);
  hexagon = new RegularPolygon(6, 120);
  heptagon = new RegularPolygon(7, 120);
}

void draw() {
  fill(255, 5);
  rect(0, 0, width, height);
  int size = 9;
    
  PVector p = triangle.randomInsidePoint();
  fill(200, 0, 0);
  ellipse(width/4 + p.x, height/4 + p.y, size, size);
  
  p = pentagon.randomInsidePoint();
  fill(0, 0, 200);
  ellipse(width*3/4 + p.x, height/4 + p.y, size, size);
  
  p = hexagon.randomInsidePoint();
  fill(0, 200, 0);
  ellipse(width/4 + p.x, height*3/4 + p.y, size, size);
  
  p = heptagon.randomInsidePoint();
  fill(200, 0, 200);
  ellipse(width*3/4 + p.x, height*3/4 + p.y, size, size);
}

class Polygon {
  
  ArrayList<PVector> vertexPoints = new ArrayList<PVector>();
  ArrayList<PVector> insidePoints = new ArrayList<PVector>();
  float minX, maxX, minY, maxY;
  PGraphics img;
  int border = 10;
    
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
    p = new PVector(p.x + minX - border/2, p.y + minY - border/2);
    return p;
  }
}

class RegularPolygon extends Polygon {
  
  RegularPolygon(int vertices, int radius) {
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
