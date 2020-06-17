import processing.video.*;

Movie movie;
PImage result;
PFont font;
int scale = 10;
int cols, rows;

int FLAG = 1;
float[][] high_pass = { {-1,-1,-1}, {-1,9,-1}, {-1,-1,-1} };
float[][] low_pass = { {0.1,0.1,0.1}, {0.1,0.1,0.1}, {0.1,0.1,0.1} };

void setup() {
  
  size(970, 400);
  movie = new Movie(this, "video.mp4");
  movie.play();
  
  result = createImage(480, 360, RGB);
  font = createFont("Consolas", 10);
}

void draw() {
  
  background(0);
  image(movie, 0, 0);
  movie.loadPixels();
  
  
  if (FLAG == 1) {
    result.loadPixels();
    for (int i = 0; i < movie.pixels.length; i++) {
      color col = color(movie.pixels[i]);
      int gray_rgb = int(( blue(col) + green(col) + red(col) ) / 3);
      result.pixels[i] = color(gray_rgb);
    }
    result.updatePixels();
    image(result, 490, 0);
  }
  
  if (FLAG == 2) {
    result.loadPixels();
    for (int i = 0; i < movie.pixels.length; i++) {
      color col = color(movie.pixels[i]);
      int gray_luma = int( 0.114*blue(col) + 0.587*green(col) + 0.299*red(col) );
      result.pixels[i] = color(gray_luma);
    }
    result.updatePixels();
    image(result, 490, 0);
  }
  
  if(FLAG == 3) {
    result.loadPixels();
    for(int i=1; i<movie.width-1; i++) {
      for(int j=1; j<movie.height-1; j++) {
        color c = convolution(movie, i, j, high_pass);
        int pixloc = i + result.width*j;
        result.pixels[pixloc] = c;
      }
    }
    result.updatePixels();
    image(result, 490, 0);
  }
  
  if(FLAG == 4) {
    result.loadPixels();
    for(int i=1; i<movie.width-1; i++) {
      for(int j=1; j<movie.height-1; j++) {
        color c = convolution(movie, i, j, low_pass);
        int pixloc = i + result.width*j;
        result.pixels[pixloc] = c;
      }
    }
    result.updatePixels();
    image(result, 490, 0);
  }
  
  if(FLAG == 5) {
    textFont(font, 1.4*scale);
    cols = movie.width / scale;
    rows = movie.height / scale;

    for(int i=0; i<cols; i++) {
      for(int j=0; j<rows; j++) {
        int x = i*scale;
        int y = j*scale;
        color c = movie.pixels[x+movie.width*y];
        color br = int((red(c)+green(c)+blue(c))/3);
        fill(c);
        text(letter(br),490+x,y);
      }
    }
    
  }
  fill(255);
  textFont(font, 2*scale);
  text("FrameRate: "+str(this.frameRate), 380, 370);
}

void movieEvent(Movie movie) {
  movie.read();
}

void keyPressed () {
  if (key == CODED) {
    if (keyCode == UP) FLAG = 1;
    if (keyCode == DOWN) FLAG = 2;
    if (keyCode == LEFT) FLAG = 3;
    if (keyCode == RIGHT) FLAG = 4;
    if (keyCode == SHIFT) FLAG = 5;
  }
}

char letter(color bright) {
  String letters = "0MNBKAE5#tr<+-. ";
  int norm = int(bright/16);
  return letters.charAt(15-norm);
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
