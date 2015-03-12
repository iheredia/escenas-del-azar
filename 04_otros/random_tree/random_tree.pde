// Implementacion aleatoria de un arbol pitagorico: http://es.wikipedia.org/wiki/%C3%81rbol_de_Pit%C3%A1goras
// Con el teclado se puede mover entre distintas semillas, usando las flechas izquierda y derecha

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

