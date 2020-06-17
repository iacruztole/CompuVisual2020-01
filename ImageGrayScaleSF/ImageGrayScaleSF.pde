import processing.video.*;

Movie myMovie3;
Movie myMovie4;
PImage imagen1;
PImage imagen2;
PImage imagen3;
PImage imagen4;
PGraphics pg1;
PGraphics pg2;
PGraphics pg3;
PGraphics pg4;
int op;


void setup(){
  size (1310,990);  //definir tamaño de la ventana
  pg1 = createGraphics (640,480);
  pg2 = createGraphics (640,480);
  pg3 = createGraphics (640,480);
  pg4 = createGraphics (640,480);
  
  imagen1 = loadImage("imagen.jpg");
  imagen2 = createImage(imagen1.width, imagen1.height, RGB);
  imagen3 = createImage(imagen1.width, imagen1.height, RGB);
  imagen4 = createImage(imagen1.width, imagen1.height, RGB);
  myMovie3 = new Movie(this, "videoprueba.mp4");
  myMovie3.loop();
  
}

void movieEvent(Movie myMovie3) {
  myMovie3.read();
  
  switch (key) { 
      case '1':   
        grayToScaleVid(1);
        break;
      case '2':   
        grayToScaleVid(2);
        break;
      case '3':
        grayToScaleVid(3);
        
        break;
      case '4':
        grayToScaleVid(4);
        break;
      case '5':
        grayToScaleVid(5);
        break;
      case '6':
        grayToScaleVid(6);
        break;
      case '7':
        grayToScaleVid(7);
        break;
      case '8':
        grayToScaleVid(8);
        break;
      case '9':
        brighnessThresholdVid();
        break;
    }
   
}

void draw(){
  g.background(45,87,44);
  pg1.beginDraw();
  pg1.background(100);
  pg1.image(imagen1,0,0);
  pg1.endDraw();
  
  pg2.beginDraw();
  pg2.background(100);
  pg2.image(imagen2,0,0);
  pg2.endDraw();
  
  pg3.beginDraw();
  pg3.background(100);
  pg3.image(myMovie3,0,0);
  pg3.endDraw();
  
  pg4.beginDraw();
  pg4.background(100);
  pg4.image(imagen4,0,0);
  pg4.endDraw();
  
  image (pg1,10,10);
  image (pg2,660,10);
  image (pg3, 10, 500);
  image (pg4, 660, 500);

}

void grayToScaleImg(int opcion){
  imagen1.loadPixels();
  for (int pixel = 0; pixel < imagen1.width * imagen2.height; pixel++){
    color c = imagen1.pixels[pixel];
    
    switch (opcion) { 
      case 1:   
        imagen2.pixels[pixel] =color((red(c)+green(c)+blue(c))/3);
        break;
      case 2:   
        imagen2.pixels[pixel] =color(0.2989*red(c)+ 0.5870*green(c)+ 0.1140*blue(c));
        break;
      case 3:
        float[] values1 = { red(c),green(c),blue(c)};
        imagen2.pixels[pixel] =color (max(values1));
        break;
      case 4:
        float[] values2 = { red(c),green(c),blue(c)};
        imagen2.pixels[pixel] =color ((max(values2) + min(values2))/2);
        break;
      case 5:
        imagen2.pixels[pixel] =color(0.2989*red(c)+ 0.701*green(c)+ 0.087*blue(c));
        break;
      case 6:
        imagen2.pixels[pixel] =color(0.2126*red(c)+ 0.7152*green(c)+ 0.0722*blue(c));
        break;
      case 7:
        imagen2.pixels[pixel] =color(0.2627*red(c)+ 0.6780*green(c)+ 0.0593*blue(c));
        break;
      case 8:
        imagen2.pixels[pixel] =color(255 - red(c), 255 - green(c), 255 - blue(c));
        break;
    }
    
    
    
    
  }
  imagen2.updatePixels();
}


void grayToScaleVid(int opcion){
  myMovie3.loadPixels();
  for (int pixel = 0; pixel < myMovie3.width * myMovie3.height; pixel++){
    color c = myMovie3.pixels[pixel];
    switch (opcion) { 
      case 1:   
        imagen4.pixels[pixel] =color((red(c)+green(c)+blue(c))/3);
        break;
      case 2:   
        imagen4.pixels[pixel] =color(0.2989*red(c)+ 0.5870*green(c)+ 0.1140*blue(c));
        break;
      case 3:
        float[] values1 = { red(c),green(c),blue(c)};
        imagen4.pixels[pixel] =color (max(values1));
        break;
      case 4:
        float[] values2 = { red(c),green(c),blue(c)};
        imagen4.pixels[pixel] =color ((max(values2) + min(values2))/2);
        break;
      case 5:
        imagen4.pixels[pixel] =color(0.2989*red(c)+ 0.701*green(c)+ 0.087*blue(c));
        break;
      case 6:
        imagen4.pixels[pixel] =color(0.2126*red(c)+ 0.7152*green(c)+ 0.0722*blue(c));
        break;
      case 7:
        imagen4.pixels[pixel] =color(0.2627*red(c)+ 0.6780*green(c)+ 0.0593*blue(c));
        break;
      case 8:
        imagen4.pixels[pixel] =color(255 - red(c), 255 - green(c), 255 - blue(c));
        break;
    }
  }
  imagen4.updatePixels();
}


void brighnessThresholdImg(){
  imagen1.loadPixels();
  float threshold = 127;

  for (int pixel = 0; pixel < imagen1.width * imagen2.height; pixel++){
    color c = imagen1.pixels[pixel];
    if (brightness(c) > threshold) {
        imagen2.pixels[pixel]  = color(255);  // White
      }  else {
        imagen2.pixels[pixel]  = color(0);    // Black
      }
  }
  imagen2.updatePixels();
}

void brighnessThresholdVid(){
  myMovie3.loadPixels();
  float threshold = 127;

  for (int pixel = 0; pixel < myMovie3.width * myMovie3.height; pixel++){
    color c = myMovie3.pixels[pixel];
    if (brightness(c) > threshold) {
        imagen4.pixels[pixel]  = color(255);  // White
      }  else {
        imagen4.pixels[pixel]  = color(0);    // Black
      }
  }
  imagen4.updatePixels();
}

  



void keyPressed() {

  switch (key) { 
      case '1':   
        grayToScaleImg(1);
        grayToScaleVid(1);
        break;
      case '2':   
        grayToScaleImg(2);
        grayToScaleVid(2);
        break;
      case '3':
        grayToScaleImg(3);
        grayToScaleVid(3);
        
        break;
      case '4':
        grayToScaleImg(4);
        grayToScaleVid(4);
        break;
      case '5':
        grayToScaleImg(5);
        grayToScaleVid(5);
        break;
      case '6':
        grayToScaleImg(6);
        grayToScaleVid(6);
        break;
      case '7':
        grayToScaleImg(7);
        grayToScaleVid(7);
        break;
      case '8':
        grayToScaleImg(8);
        grayToScaleVid(8);
        break;
      case '9':
        brighnessThresholdImg();
        brighnessThresholdVid();
        break;
    }
  

  
}
