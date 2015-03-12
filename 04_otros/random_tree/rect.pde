import java.util.*;

class Rectangle {
  float x, y, w, h, angle;
  int layer;
  float addAngle = PI/4;

  Rectangle() {}

  void setColor() {
    int brownHue = 40;
    int greenHue = 115;
    float hue = layer < 5 ? brownHue : greenHue;
    hue += random(-10, 10);
    
    float saturation = 90;
    float brightness = random(25, 45);
    color c = color(hue, saturation, brightness);
    fill(c);
  }

  void draw() {
    translate(x, y);
    rotate(-angle);

    setColor();
    rect(0, 0, w, -h);

    rotate(angle);
    translate(-x, -y);
  }
  
  ArrayList<Rectangle> nextRects() {
    addAngle += randomGaussian()*0.2;

    Rectangle leftRect = new Rectangle();
    leftRect.x = x + cos(HALF_PI + angle) * h;
    leftRect.y = y - sin(HALF_PI + angle) * h;
    leftRect.w = w * cos(addAngle);
    leftRect.angle = angle + addAngle;
    leftRect.h = leftRect.isGoingDown() ? h*0.6 : h*0.75;
    leftRect.layer = layer + 1;

    Rectangle rightRect = new Rectangle();
    rightRect.x = leftRect.x + cos(leftRect.angle) * leftRect.w;
    rightRect.y = leftRect.y - sin(leftRect.angle) * leftRect.w;
    rightRect.w = w * sin(addAngle);
    rightRect.angle = angle + addAngle - HALF_PI;
    rightRect.h = rightRect.isGoingDown() ? h*0.6 : h*0.75;
    rightRect.layer = layer + 1;
    
    ArrayList<Rectangle> rects = new ArrayList<Rectangle>();
    rects.add(leftRect);
    rects.add(rightRect);
    return rects;
  }
  
  boolean isGoingDown() {
    return cos(angle) < 0;
  }
}

