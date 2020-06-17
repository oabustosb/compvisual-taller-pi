PImage img, rgb, luma;
PGraphics res;
int FLAG = 1;

void setup() {
  
  size(602,300);
  img = loadImage("perrito.jpg");
  img.loadPixels();
  
  rgb = createImage(300, 300, RGB);  
  luma = createImage(300, 300, RGB);
  
  res = createGraphics(300, 300);
}

void draw() {
  background(0);  
  image(img, 0, 0);
  text("Imagen original", 10, 20); 
  
  res.beginDraw();
  if (FLAG == 0) {
    rgb.loadPixels();
    for (int i = 0; i < img.pixels.length; i++) {
      color col = color(img.pixels[i]);
      //Promedio del los tres canales
      int gray_rgb = int(( blue(col) + green(col) + red(col) ) / 3);
      rgb.pixels[i] = color(gray_rgb);
    }
    rgb.updatePixels();
    res.image(rgb, 0, 0);
  }
  
  if (FLAG == 1) {
    luma.loadPixels();
    for (int i = 0; i < img.pixels.length; i++) {
      color col = color(img.pixels[i]);
      //Formula de la Luma segun BT.601 de la ITU
      int gray_luma = int( 0.114*blue(col) + 0.587*green(col) + 0.299*red(col) );
      luma.pixels[i] = color(gray_luma);
    }
    luma.updatePixels();
    res.image(luma, 0, 0);
  }
  res.endDraw();
  
  image(res, 302, 0);
  if (FLAG == 0) text("Promedio RGB", 310, 20);
  if (FLAG == 1) text("Fórmula Luma", 310, 20);
}

void keyPressed() {
  if (key == '1' && FLAG == 0) FLAG = 1;
  else if (key == '0' && FLAG == 1) FLAG = 0;
}
