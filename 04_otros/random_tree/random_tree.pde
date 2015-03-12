PythagoreanTree tree;
int seed = 14;
void setup() {
  size(900, 600);  
  colorMode(HSB, 360, 100, 100, 100);
  noStroke();
  background(#eeeeee);
  randomSeed(seed);
  tree = new PythagoreanTree();
}

void draw() {
  tree.drawNextLayer();
}

void keyPressed() {
  if (keyCode == RIGHT) {
    background(#eeeeee);
    seed++;
    randomSeed(seed);
    tree.reGenerate();
  } else if (keyCode == LEFT) {
    background(#eeeeee);
    seed--;
    randomSeed(seed);
    tree.reGenerate();    
  }
}

