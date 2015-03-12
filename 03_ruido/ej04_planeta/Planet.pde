class Planet {
  float centerX, centerY, centerZ, r, angle;
  ArrayList<PVector> points = new ArrayList<PVector>();
  HashMap<PVector, Integer> colors = new HashMap<PVector, Integer>();
  
  Planet(float x, float y, float z, float rad) {
    centerX = x;
    centerY = y;
    centerZ = z;
    r = rad;
    
    for (float rho=0; rho<TWO_PI; rho+=0.01) {
      for (float theta=0; theta<PI; theta+=0.02) {
        float py = cos(rho)*r;
        float px = sin(rho)*cos(theta)*r;
        float pz = sin(rho)*sin(theta)*r;
        color c = heightColorAt(px, py, pz);
        PVector p = new PVector(px, py, pz);
        points.add(p);
        colors.put(p, c);
      }
    }
  }
  
  void rotate(float a) {
    angle = a;
  }
  
  void draw() {
    translate(centerX, centerY, centerZ);
    rotateY(angle);
    for (int i=0; i<points.size(); i++) {
      PVector p = points.get(i);
      color c = colors.get(p);;
      stroke(c);
      point(p.x, p.y, p.z);
    }
    rotateY(-angle);
    translate(-centerX, -centerY, -centerZ);
  }

}

color heightColorAt(float x, float y, float z) {
  float noiseSensitivity = 0.02;
  int displacement = 200;
  x = displacement + x * noiseSensitivity;
  y = displacement + y * noiseSensitivity;
  z = displacement + z * noiseSensitivity;
  float n = noise(x, y, z);
  color c;
  color deepBlue = color(10, 10, 50);
  color lightBlue = color(40, 220, 160);
  color plainYellow = color(180, 240, 90);
  color highBrown = color(160, 40, 0);
  float seaCut = 0.5;
  float landCut = 0.55;
  if (n < seaCut) {
    n = map(n, 0, seaCut, 0, 1);
    c = lerpColor(deepBlue, lightBlue, n);
  } else if (n < landCut) {
    n = map(n, seaCut, landCut, 0, 1);
    c = lerpColor(lightBlue, plainYellow, n);
  } else {
    n = map(n, landCut, 1, 0, 1);
    c = lerpColor(plainYellow, highBrown, n);
  }
  return c;
}
