//definisco i tre cerchi iniziali
circle c1 = new circle(200,150,100);
circle c2 = new circle(486, 350, 85);
circle c3 = new circle(211, 500, 92);
solApollonio cs1 = new solApollonio(c1,c2,c3,1,1,1);
solApollonio cs2 = new solApollonio(c1,c2,c3,-1,1,1);
solApollonio cs3 = new solApollonio(c1,c2,c3,1,-1,1);
solApollonio cs4 = new solApollonio(c1,c2,c3,1,1,-1);
solApollonio cs5 = new solApollonio(c1,c2,c3,-1,1,-1);
solApollonio cs6 = new solApollonio(c1,c2,c3,1,-1,-1);
solApollonio cs7 = new solApollonio(c1,c2,c3,-1,-1,1);
solApollonio cs8 = new solApollonio(c1,c2,c3,-1,-1,-1);

//specifica le caratteristiche della finestra
void setup() {
  size(1200, 760, P3D); //dimensioni in px e renderer (P3D funziona sul web)
  frameRate(30); //framerate
  background(255);
}
//crea la finestra con cui interagire
void draw() {
  smooth();//abilita antialiasing
  c1.drawCircle(); //disegno il primo cerchio
  c2.drawCircle(); //disegno il secondo cerchio
  c3.drawCircle(); //disegno il terzo cerchio
  //disegno le soluzioni
  cs1.drawSol();
  cs2.drawSol();
  cs3.drawSol();
  cs4.drawSol();
  cs5.drawSol();
  cs6.drawSol();
  cs7.drawSol();
  cs8.drawSol();
}

//creo la classe cerchio e le relative funzioni
class circle {
  float positionX; //posizione x
  float positionY; //posizione y
  float radius; //raggio
  
  //constructor
  circle(float x,float y,float r) {
    positionX = x;
    positionY = y;
    radius = r;
  }
  
  //funzione che disegna il cerchio
  void drawCircle() { 
    ellipseMode(CENTER); //le coordinate rappresentano il centro del cerchio
    ellipse (positionX, positionY, radius*2, radius*2); //formula che crea il cerchio, r*2 perché nell'ellipse rappresenta il diametro
  }
}

//crea la funzione che risolve il problema di apollonio per i dati valori
class solApollonio {
    //dichiarazione variabili
    float X;
    float Y;
    float R;
    
    //constructor
    solApollonio(circle c1, circle c2, circle c3, int s1, int s2, int s3) {
    //calcoli
    float x1 = c1.positionX;
    float y1 = c1.positionY;
    float r1 = c1.radius;
    float x2 = c2.positionX;
    float y2 = c2.positionY;
    float r2 = c2.radius;
    float x3 = c3.positionX;
    float y3 = c3.positionY;
    float r3 = c3.radius;
    
    float v11 = 2*x2 - 2*x1;
    float v12 = 2*y2 - 2*y1;
    float v13 = x1*x1 - x2*x2 + y1*y1 - y2*y2 - r1*r1 + r2*r2;
    float v14 = 2*s2*r2 - 2*s1*r1;
 
    float v21 = 2*x3 - 2*x2;
    float v22 = 2*y3 - 2*y2;
    float v23 = x2*x2 - x3*x3 + y2*y2 - y3*y3 - r2*r2 + r3*r3;
    float v24 = 2*s3*r3 - 2*s2*r2;
 
    float w12 = v12/v11;
    float w13 = v13/v11;
    float w14 = v14/v11;
 
    float w22 = v22/v21-w12;
    float w23 = v23/v21-w13;
    float w24 = v24/v21-w14;
 
    float P = -w23/w22;
    float Q = w24/w22;
    float M = -w12*P-w13;
    float N = w14 - w12*Q;
 
    float a = N*N + Q*Q - 1;
    float b = 2*M*N - 2*N*x1 + 2*P*Q - 2*Q*y1 + 2*s1*r1;
    float c = x1*x1 + M*M - 2*M*x1 + P*P + y1*y1 - 2*P*y1 - r1*r1;
 
    // Find a root of a quadratic equation. This requires the circle centers not
    // to be e.g. colinear
    float D = b*b-4*a*c;
    float rs = (-b-sqrt(D))/(2*a);
    float xs = M + N * rs;
    float ys = P + Q * rs;
    
    X = xs;
    Y = ys;
    R = rs;
    }
    
    void drawSol() {
      ellipseMode(CENTER); //le coordinate rappresentano il centro del cerchio
      ellipse (X, Y, R*2, R*2); //formula che crea il cerchio, r*2 perché nell'ellipse rappresenta il diametro
    }
}