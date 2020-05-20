import processing.video.*;

// Size of each cell in the grid
int cellSize = 20;
// Number of columns and rows in our system
int cols, rows;
// Variable for capture device
Capture video;


void setup() {
  size(1920, 1080);
  frameRate(30);
  cols = width / cellSize;
  rows = height / cellSize;
  colorMode(RGB, 255, 255, 255, 100);
 
  // This the default video input, see the GettingStartedCapture 
  // example if it creates an error
  video = new Capture(this, width, height);
  
  // Start capturing the images from the camera
  video.start();  
  
  background(0);
}


void draw() { 
  if (video.available()) {
    video.read();
    video.loadPixels();
  
    // Begin loop for columns
    for (int i = 0; i < cols; i++) {
      // Begin loop for rows
      for (int j = 0; j < rows; j++) {
      
        // Where are we, pixel-wise?
        int x = i*cellSize;
        int y = j*cellSize;
        int loc = (video.width - x - 1) + y*video.width; // Reversing x to mirror the image
      
        float r = red(video.pixels[loc]);
        // Make a new color with an alpha component
        color c = color(r, 4, 85, 4);
        // changement de couleurs et de l'alpha pour faire du rouge, du bleu et un mouvement plus lent au niveau de l'alpha
        
        pushMatrix();
        translate(x+cellSize/1, y+cellSize/1.7);
        // Rotation formula based on brightness
        rotate((2 * PI * brightness(c) / 255.0));
        rectMode(RADIUS);
        // déplacement de la position du rectangle
        
        fill(c);
        // remplissage avec la variable c
        noStroke();        
        rect(mouseX, 0, cellSize+0.01, cellSize+0.09);    
        popMatrix();
      }
    }
  }
}
