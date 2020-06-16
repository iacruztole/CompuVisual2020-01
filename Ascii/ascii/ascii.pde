import processing.video.*;
Movie mov;

PImage[] images = new PImage[3];
// the image to asciify
PImage img;
int index = 0;
 
// sampling resolution: colors will be sampled every n pixels 
// to determine which character to display
int resolution = 5;
 
// array to hold characters for pixel replacement
char[] ascii;
 
void setup() {
  images[0] = loadImage("asuka.jpg");
  images[0].resize(0, 700);
  images[1] = loadImage("hitagi.jpg");
  images[1].resize(0, 700);
  mov = new Movie(this, "train.mp4");
  images[2] = mov;
  
  
  //img = loadImage("hitagi.jpg");
  
  
  size(1000, 700);
  noStroke();
 
  // build up a character array that corresponds to brightness values
  ascii = new char[256];
  //String letters = "#MN@#$o;:,. ";
  String letters = "#MN@#$o+;:,. ";
  for (int i = 0; i < 256; i++) {
    int index = int(map(i, 0, 256, 0, letters.length()));
    ascii[i] = letters.charAt(index);
  }
 
  PFont mono = createFont("Courier", resolution+2);
  textFont(mono);
 
  asciify(images[0]);
}
 
void asciify(PImage img) {
  
  background(255);
  fill(0);
  // since the text is just black and white, converting the image
  // to grayscale seems a little more accurate when calculating brightness
  img.filter(GRAY);
  img.loadPixels();
 
  // grab the color of every nth pixel in the image
  // and replace it with the character of similar brightness
  for (int y = 0; y < img.height; y += resolution) {
    for (int x = 0; x < img.width; x += resolution) {
      color pixel = img.pixels[y * img.width + x];
      text(ascii[int(brightness(pixel))], x, y);
    }
  }
}


void movieEvent(Movie m) {
  m.read();
  
}

void draw(){
  if(index == 2)
  {
    mov.filter(GRAY);
    asciify(mov);
  }
}

void keyPressed() {
  if(keyCode==LEFT) {
    index = (index+3-1)%3;
  }    
  else if (keyCode==RIGHT)
  {
    index = (index+1)%3;
  }
  
  switch (index) {
    case 2:
      mov.loop();
      break;
    default:
      mov.stop();
      asciify(images[index]);
    }
}
