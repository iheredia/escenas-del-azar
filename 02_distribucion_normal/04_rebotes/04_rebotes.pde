Ball deterministicBall;
Ball normalBall;

void setup() {
  size(900, 600);
  background(255);
  deterministicBall = new Ball(width*0.25, color(200, 0, 0), false);
  normalBall = new Ball(width*0.75, color(0, 0, 200), true);
}

void draw() {
  fill(255, 255, 255, 2);
  rect(0, 0, width, height);

  stroke(0);
  strokeWeight(8);
  line(width/2, 0, width/2, height);
  
  deterministicBall.move();
  deterministicBall.draw();
  normalBall.move();
  normalBall.draw();     
}


class Ball {
  float x;
  float y = height/2;
  float angle = PI*0.21;
  float speed = 5;
  color c;
  float size = 15;
  float deviation = 0.01;
  boolean normal;
  
  Ball(float x_, color c_, boolean n_) {
    x = x_;
    c = c_;
    normal = n_;
  }
  
  void move() {
    x += cos(angle) * speed;
    y -= sin(angle) * speed;
    boolean bounceBottom = y >= height - size/2;
    boolean bounceTop = y <= size/2;
    boolean bounceLeft, bounceRight;
    if (normal) {
      bounceLeft = x <= width/2.0 + size/2.0;
      bounceRight = x >= width - size/2.0;
    } else {
      bounceLeft = x <= size/2.0;
      bounceRight = x >= width/2.0 - size/2.0;
    }
    if (bounceBottom || bounceTop) {
      angle = -angle;
      angle += normal ? randomGaussian() * deviation : 0;
    } 
    if (bounceLeft || bounceRight) {
      angle = PI - angle;
      angle += normal ? randomGaussian() * deviation : 0;
    }
  }
  
  void draw() {
    noStroke();
    fill(c);
    ellipse(x, y, size, size);
  }
  
}
