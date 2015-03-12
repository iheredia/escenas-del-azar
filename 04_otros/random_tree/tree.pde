import java.util.*;

class PythagoreanTree {
  ArrayList<Rectangle> currentLayer;
  float maxLayer = 14;

  PythagoreanTree() {
    reGenerate();
  }

  void drawNextLayer() {
    for (int i=0; i<min(500, currentLayer.size()); i++) {
      int n = round(random(currentLayer.size()/2));
      Rectangle rect = currentLayer.remove(n);
      rect.draw();
      if (rect.h > 1) {
        currentLayer.addAll(rect.nextRects());
      }
    }
  }

  void reGenerate() {
    Rectangle rect = new Rectangle();
    rect.x = width*0.45;
    rect.y = height*0.95;
    rect.angle = 0;
    rect.w = width*0.1;
    rect.h = height*0.2;
    rect.layer = 1;

    currentLayer = new ArrayList<Rectangle>();
    currentLayer.add(rect);
  }
}
