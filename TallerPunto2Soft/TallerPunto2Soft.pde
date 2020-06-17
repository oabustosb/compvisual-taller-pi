PImage img, high, low;
PGraphics res;
int FLAG = 1;

float[][] high_pass = { {-1,-1,-1}, {-1,9,-1}, {-1,-1,-1} };
float[][] low_pass = { {0.1,0.1,0.1}, {0.1,0.1,0.1}, {0.1,0.1,0.1} };

void setup() {  
  size(598, 298);
  img = loadImage("perrito.jpg");  
  res = createGraphics(300, 300);
}

void draw() {
  background(0);  
  image(img, -1, -1);
  text("Imagen original", 10, 20); 
  
  res.beginDraw();
  if (FLAG == 0) {
    low = createImage(300, 300, RGB);
    low.loadPixels();
    for(int i=1; i<img.width-1; i++) {
      for(int j=1; j<img.height-1; j++) {
        color c = convolution(img, i, j, low_pass);
        int pixloc = i + img.width*j;
        low.pixels[pixloc] = c;
      }
    }
    low.updatePixels();
    res.image(low, -1, -1);
  }
  
  if (FLAG == 1) {
    high = createImage(300, 300, RGB);
    high.loadPixels();
    for(int i=1; i<img.width-1; i++) {
      for(int j=1; j<img.height-1; j++) {
        color c = convolution(img, i, j, high_pass);
        int pixloc = i + img.width*j;
        high.pixels[pixloc] = c;
      }
    }
    high.updatePixels();
    res.image(high, -1, -1);
  }
  res.endDraw();
  
  image(res, 301, 0);
  if (FLAG == 0) text("Filtro BoxBlur", 310, 20);
  if (FLAG == 1) text("Filtro EdgeDetection", 310, 20);
}

void keyPressed() {
  if (key == '1' && FLAG == 0) FLAG = 1;
  else if (key == '0' && FLAG == 1) FLAG = 0;
}

color convolution(PImage image, int x, int y, float[][] filter) {
  
  float r_tot = 0;
  float g_tot = 0;
  float b_tot = 0;
  
  for(int i=0; i<3; i++) {
    for(int j=0; j<3; j++) {
      
      int xloc = x+i-1;
      int yloc = y+j-1;
      int pixloc = xloc + image.width*yloc;
      
      r_tot += red(image.pixels[pixloc])*filter[i][j];
      g_tot += green(image.pixels[pixloc])*filter[i][j];
      b_tot += blue(image.pixels[pixloc])*filter[i][j];     
    }
  }
  
  float r_norm = constrain(r_tot, 0, 255);
  float g_norm = constrain(g_tot, 0, 255);
  float b_norm = constrain(b_tot, 0, 255);  
  return color(r_norm, g_norm, b_norm);

}
