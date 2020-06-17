PImage img;
PShape shape;
PGraphics res;
PShader rgb_sh, luma_sh;
int FLAG = 1;

void setup() {
  
  size(602, 300, P2D);
  img = loadImage("perrito.jpg");
  textureMode(NORMAL);
  
  res = createGraphics(300, 300, P2D);
  
  shape = createShape();
  shape.beginShape(QUAD_STRIP);
  shape.noStroke();
  shape.texture(img);
  shape.vertex(0, 0, 0, 0);
  shape.vertex(300, 0, 1, 0);
  shape.vertex(0, 300, 0, 1);
  shape.vertex(300, 300, 1, 1);
  shape.endShape(CLOSE);
  
  rgb_sh = loadShader("rgb_frag.glsl", "vert.glsl");
  luma_sh = loadShader("luma_frag.glsl", "vert.glsl");
}

void draw() {
  background(50);
  image(img, 0, 0);
  text("Imagen original", 10, 20); 
  
  res.beginDraw();
  if (FLAG == 0) {    
    res.shader(rgb_sh);
    res.shape(shape);  
  }  
  if (FLAG == 1) {
    res.shader(luma_sh);
    res.shape(shape);
  }
  res.resetShader();
  res.endDraw();
  
  image(res, 302, 0);
  if (FLAG == 0) text("Promedio RGB", 310, 20);
  if (FLAG == 1) text("Fórmula Luma", 310, 20);
}

void keyPressed() {
  if (key == '1' && FLAG == 0) FLAG = 1;
  else if (key == '0' && FLAG == 1) FLAG = 0;
}
