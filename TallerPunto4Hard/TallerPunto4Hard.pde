PImage img;
PShape shape;
PShader tex_sh;
PGraphics hist, res;

int[] histo = new int[256];

void setup() {

  size(1014, 500, P2D);  
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

  hist = createGraphics(512, 500, P2D);  
  hist.beginDraw();
  hist.fill(255);
  int maximum = max(histo);
  for (int k=0; k<256; k++) {
    float new_val = 400*(float(histo[k])/float(maximum));
    hist.rect(2*k, 500-new_val, 2, new_val);
  }
  
  PImage tex = hist.get();
  hist.endDraw();
  
  textureMode(NORMAL);  
  shape = createShape();
  shape.beginShape(QUAD_STRIP);
  shape.noStroke();
  shape.texture(tex);
  shape.vertex(0, 0, 0, 0);
  shape.vertex(500, 0, 1, 0);
  shape.vertex(0, 500, 0, 1);
  shape.vertex(500, 500, 1, 1);
  shape.endShape(CLOSE);
  
  tex_sh = loadShader("tex_frag.glsl", "tex_vert.glsl");  
}

void draw() {
  
  background(0);
  image(img, 0, 0);
  
  res = createGraphics(500, 500, P2D);  
  res.beginDraw();
  res.shader(tex_sh);
  res.shape(shape);
  res.endDraw();
  image(res, 502, 0);
}
