PImage img;
PFont font;
int scale = 10;
int cols, rows;

void setup() {
  size(1010, 500);  
  img = loadImage("gato.png");
  font = createFont("Consolas", 10);
}

void draw() {
  
  background(255);
  image(img, 0, 0);
  textFont(font, 1.4*scale);
  cols = img.width / scale;
  rows = img.height / scale;
  
  img.loadPixels();
  for(int i=0; i<cols; i++) {
    for(int j=0; j<rows; j++) {
      int x = i*scale;
      int y = j*scale;
      color c = img.pixels[x+img.width*y];
      color br = int((red(c)+green(c)+blue(c))/3);
      fill(br);
      text(letter(br),510+x,y);
    }
  }  
}

char letter(color bright) {
  String letters = "0MNBKAE5#tr<+-. ";
  int norm = int(bright/16);
  return letters.charAt(norm);
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      if (scale < 20) scale = scale + 5;
    } 
    if (keyCode == DOWN) {
      if (scale > 5) scale = scale - 5;
    }
  }
}
