import processing.video.*;
Movie mov;
PImage img;
String[] currentImg = {"asuka.jpg", "hitagi.jpg", "train.mp4"};
String[] kernels = {"Saturation", "Edge1", "Edge2", "Edge3","Sharpen", "SSaturation", "GaussianBlur", "Box Blur", "UnSharpMasking"};
PShader kernel;
PShape frame, original;
int index = 0;
int indexImg = 0;
int total = 9;

final float[] Saturation = { -1.0, -1.0, -1.0,
                             -1.0,  9.0, -1.0,
                             -1.0, -1.0, -1.0 }; 

final float[] Edge1 = {  -1.0, -1.0, -1.0,
                         -1.0, 8.0, -1.0, -1.0, -1.0, -1.0 };

final float[] Edge2 = { 1.0, 0.0, -1.0, 0.0, 0.0,  0.0, -1.0, 0.0,  1.0 };
                                 
final float[] Edge3 = { 0.0,  1.0, 0.0,1.0, -4.0, 1.0, 0.0,  1.0, 0.0 };
 
final float[] kernelSharpen = { 0.0, -1.0, 0.0, -1.0, 5.0, -1.0, 0.0, -1.0, 0.0 }; 
                   
final float[] SSaturation ={  1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0 }; 
 
final float[] GaussianBlur = { 1.0, 2.0, 1.0, 2.0, 4.0, 2.0, 1.0, 2.0, 1.0 };
final  float gblurN = 16;


final  float normalBoxBlur = 9;
final float[] kernelBoxBlur = {1.0, 1.0, 1.0,1.0, 1.0, 1.0,1.0, 1.0, 1.0,};

final float normalUnSharpMasking = -256.0;
final float[] kernelUnSharpMasking = { 1.0, 4.0, 6.0, 4.0, 1.0,
                                      4.0, 16.0, 24.0, 16.0, 4.0,
                                      6.0, 24.0, -476.0, 24.0, 6.0,
                                      4.0, 16.0, 24.0, 16.0, 4.0,
                                      1.0, 4.0, 6.0, 4.0, 1.0};

void setup(){
  size(1000, 500, P2D);
  mov = new Movie(this, "train.mp4");
  original = createShape(RECT, 0, 0, 500, 500);
  frame = createShape(RECT, 500, 0, 500, 500);
  loadImage();
  kernel = loadShader("Convolution.glsl");
}

void movieEvent(Movie m) {
  m.read();
}

void loadImage(){
  if(indexImg == 2){
    
    mov.loop();
    original.setTexture(mov);
    frame.setTexture(mov);
  }
  else
  {
    mov.pause();
    img = loadImage(currentImg[indexImg]); // Load the original image
    img.resize(500, 500);       
    original.setTexture(img);       
    frame.setTexture(img);
  }
}

void draw(){
  float[] matrix;
  float scalar = 1.0;
  int size = 3;
  switch (index) {
    case 0:
      matrix = Saturation;
    break;
    case 1:
      matrix = Edge1;
    break;
    case 2:
      matrix = Edge2;
    break;
    case 3:
      matrix = Edge3;
    break;
    case 4:
      matrix = kernelSharpen;
    break;  
    case 5:
      matrix = SSaturation;
    break;  
    case 6:
      matrix = GaussianBlur;
      scalar = gblurN;
    break;
    case 7:
      matrix = kernelBoxBlur;
      scalar = normalBoxBlur;
    break;
    case 8:
      matrix = kernelUnSharpMasking;
      scalar = normalUnSharpMasking;
      size = 5;
    break;
    default:
      matrix = new float[0];
    break;
  }
    kernel.set("matrix", matrix);
    kernel.set("scalar", scalar);
    kernel.set("size", size);   
  
  shader(kernel);
  shape(frame);
  
  resetShader();
  shape(original);
  text(kernels[index] + " - FPS " + frameRate, 5, 20);
}

void keyPressed() {
  if(keyCode==LEFT) {
    index = (index+total-1)%total;
  }    
  else if (keyCode==RIGHT)
  {
    index = (index+1)%total;
  } 
  else if(keyCode == UP || keyCode == DOWN)
  {
    if(keyCode == UP)
    {
      indexImg = (indexImg+1)%currentImg.length;
    }
    else 
    {
      indexImg = (indexImg+currentImg.length-1)%currentImg.length;
    }
    loadImage();
  }
}
