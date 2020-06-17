PImage img;
PGraphics hist;

int[] histo = new int[256];

void setup() {

  size(1014, 500);  
  hist = createGraphics(512, 500);
  
  img = loadImage("gato.png");
  img.loadPixels();
  
  for(int i=0; i<img.width; i++) {
    for (int j=0; j<img.height; j++) {
      color col = color(img.pixels[i+j*img.width]);
      int value = int((red(col)+green(col)+blue(col))/3);
      constrain(value, 0, 255);
      histo[value]++;
    }
  }
  noLoop();
  
}

void draw() {
  
  background(0);
  image(img, 0, 0);
  
  hist.beginDraw();
  hist.fill(255);
  int maximum = max(histo);
  for (int k=0; k<256; k++) {
    float new_val = 400*(float(histo[k])/float(maximum));
    hist.rect(2*k, 500-new_val, 2, new_val);
  }
  hist.endDraw();
  image(hist, 502, 0);
  
}
