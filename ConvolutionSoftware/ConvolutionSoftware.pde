import processing.video.*;
Movie mov, mov2;
PGraphics pg;
PImage image, imageT;
PImage[] images = new PImage[3];
PImage[] imagesT = new PImage[3];
int index;
int[][] current;
float normal;
int size;
boolean average;

int normalUnSharpMasking = -256;
int[][] kernelUnSharpMasking = { {1, 4, 6, 4, 1},
                                 {4, 16, 24, 16, 4},
                                 {6, 24, -476, 24, 6},
                                 {4, 16, 24, 16, 4},
                                 {1, 4, 6, 4, 1}};
int[][] kernelSuavisado = { {1, 1, 1, 1, 1},
                            {1, 4,  4, 4, 1},
                            {1, 4, 12, 4, 1},
                            {1, 4,  4, 4, 1},
                            {1, 1,  1, 1, 1}};
                                 
int[][] kernelEdgeDetection1 = { { 1, 0, -1},
                                 { 0, 0,  0},
                                 {-1, 0,  1}  };
                                 
int[][] kernelEdgeDetection2 = {  {0,  1, 0},
                                  {1, -4, 1},
                                  {0,  1, 0}  };
                                  
int[][] kernelEdgeDetection3 = {  {-1, -1, -1},
                                  {-1,  8, -1},
                                  {-1, -1, -1}  };
                                  
int[][] kernelSharpen = {  { 0, -1,  0},
                           {-1,  5, -1},
                           { 0, -1,  0}  };
                           
int[][] kernelIdentity = { {0, 0, 0},
                           {0, 1, 0},
                           {0, 0, 0}  };
                           
int normalBoxBlur = 9;
int[][] kernelBoxBlur = {  {1, 1, 1},
                           {1, 1, 1},
                           {1, 1, 1}  };

int normalGaussianBlur = 16;
int[][] kernelGaussianBlur ={{1, 2, 1},
                             {2, 4, 2},
                             {1, 2, 1}  };
int[][] kernelExample ={ {-2, -1, 0},
                         {-1,  1, 1},
                         { 0,  1, 2}  };
                         
int[][] kernelEdgeDetectionV ={{0, -1, 0},
                               {0,  2, 0},
                               {0, -1, 0}  };
                               
int[][] kernelEdgeDetectionH ={{ 0, 0,  0},
                               {-1, 2, -1},
                               { 0, 0,  0}  };
                               
int[][] kernelBorder ={{ 0, 0,  0},
                       {-1, 1,  0},
                       { 0, 0,  0}  };

int[][] kernelNorth = {{ 1,  1,  1},
                       { 1, -2,  1},
                       {-1, -1, -1}  };
                       
boolean hardware;
void setup()
{ 
  size(1200, 500);
  pg = createGraphics(1160, 460);
  String img = "hitagi.jpg";
  images[0] = loadImage("asuka.jpg");
  imagesT[0] = loadImage("asuka.jpg");
  //image = loadImage(img);
  //image.resize(600,0);
  images[1] = loadImage("hitagi.jpg");
  imagesT[1] = loadImage("hitagi.jpg");
  //imageT = loadImage(img);
  //imageT.resize(600, 0);
  mov = new Movie(this, "train.mp4");
  mov2 = new Movie(this, "train.mp4");
  images[2] = mov;
  imagesT[2] = mov2;
  /*
  pg.beginDraw();
  pg.background(100);
  pg.image(images[index], 0, 0);
    //transformation
  pg.image(imagesT[index], 600, 0);
  pg.endDraw();
  image(pg,20,20);*/
  Convolution(kernelIdentity, 3, 1, false);
}

void draw(){
  
  background(100);
  Convolution(current, size, normal, average);
  pg.beginDraw();
  pg.background(100);
  pg.image(images[index], 0, 0);
  pg.image(imagesT[index], 600, 0);
  pg.endDraw();
  image(pg,20,20);
  text("FPS " + frameRate, 5, 20);
}

void Convolution(int[][] kernel, int tam, float normal, boolean avg){
  current = kernel;
  this.normal = normal;
  size = tam;
  average = avg;
  int borde = tam/2;
  PImage image = images[index];
  PImage imageT = imagesT[index];
  image.loadPixels();
  imageT.loadPixels();
  //Recorrer los pixeles
  for (int y = borde; y < image.height-borde; y++) { //No se toman en cuenta los bordes
    for (int x = borde; x < image.width-borde; x++) { // en ambos sentidos
      float sumRed = 0; //Suma de cada pixel en rojo
      float sumGreen = 0; //Suma de cada pixel en verde
      float sumBlue = 0; //Suma de cada pixel en azul
      
      for (int ky = -borde; ky <= borde; ky++) {
        for (int kx = -borde; kx <= borde; kx++) {
          // Calcular la posicion del pixel
          int pos = (y + ky)*image.width + (x + kx);
          //obtener los valores en cada expectro del color
          float redVal = red(image.pixels[pos]);
          float greenVal = green(image.pixels[pos]);
          float blueVal = blue(image.pixels[pos]);
          
          // Multiplicar los pixeles adyacentes
          sumRed += kernel[ky+borde][kx+borde] * redVal;
          sumGreen += kernel[ky+borde][kx+borde] * greenVal;
          sumBlue += kernel[ky+borde][kx+borde] * blueVal;
        }
      }
      //Se colocan los valores calculados por rango de color y se normalizan
      //Si se debe poner en gris, se calcula el promedio de los 3 y se coloca normalizado
      if(avg)
      {
        float avgVal = (sumRed + sumGreen + sumBlue)/(3 * normal);
        imageT.pixels[y*image.width + x] = color(avgVal, avgVal, avgVal);
      }else
      {        
        imageT.pixels[y*image.width + x] = color(sumRed/normal, sumGreen/normal, sumBlue/normal);
      }
    }
  }
  // State that there are changes to imageT.pixels[]
  imageT.updatePixels();
}

void keyPressed(){
  //Make every transformation a unique key
  //Put the variables in the shader if it is hardware, or apply the convolution if it is in software
  if(keyCode==LEFT) {
    index = (index+3-1)%3;
    Convolution(current, size, normal, average);
  }    
  else if (keyCode==RIGHT)
  {
    index = (index+1)%3;
    Convolution(current, size, normal, average);
  }
  
  switch (index) {
    case 2:
      mov.loop();
      mov2.loop();
      break;
    default:
      mov.stop();
      mov2.stop();
  }
  if(key == 'v')
   {
     Convolution(kernelEdgeDetectionV, 3, 1, true);
   }
   else if(key == 'h')
   { //<>//
       Convolution(kernelEdgeDetectionH, 3, 1, true); 
   }
   else if(key == '1')
   {
       Convolution(kernelEdgeDetection1, 3, 1, true); 
   }
   else if(key == '2')
   {
     
       Convolution(kernelEdgeDetection2, 3, 1, true);
     
   }
   else if(key == '3')
   {
     
       Convolution(kernelEdgeDetection3, 3, 1, true);
     
   }
   else if(key == 's')
   {
       Convolution(kernelSharpen, 3, 1, false);
     
   }
   else if(key == 'o')
   {
       Convolution(kernelIdentity, 3, 1, false);
   }
   else if(key == 'b')
   {
       Convolution(kernelBoxBlur, 3, normalBoxBlur, false);
   }
   else if(key == 'g')
   {
     Convolution(kernelGaussianBlur, 3, normalGaussianBlur, false);
   }
   else if(key == 'u')
   {
       Convolution(kernelUnSharpMasking, 5, normalUnSharpMasking, false);
   }
   else if(key == 'e')
   {
       Convolution(kernelExample, 3, 1, false);
   }
   else if(key == 'v')
   {
       Convolution(kernelBorder, 3, 1, false);
   }
   else if(key == 'n')
   {
       Convolution(kernelNorth, 3, 1, false);
   }
   else if(key == 'z')
   {
       Convolution(kernelSuavisado, 5, 1, false);
   }
} //<>//

void movieEvent(Movie m) {
  m.read();
}
