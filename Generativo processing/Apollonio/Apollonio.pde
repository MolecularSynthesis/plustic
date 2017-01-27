//Soluzione Apollonio interattiva

//import controlP5
import controlP5.*;
ControlP5 cp5;

//specifica le caratteristiche della finestra
void setup() {
  size(1200, 760, P3D); //dimensioni in px e renderer (P3D funziona sul web)
  background(255,255,255,100);
  smooth();//abilita antialiasing
  //richiamo controlP5
  cp5 = new ControlP5(this);
  cp5.addSlider("raggio1").setPosition(20,640).setSize(200,20).setRange(0,100).setValue(80);
  cp5.addSlider("raggio2").setPosition(20,680).setSize(200,20).setRange(0,100).setValue(90);
  cp5.addSlider("raggio3").setPosition(20,720).setSize(200,20).setRange(0,100).setValue(100);
}

//valori iniziali cerchi posizione
float x1 = 200; float y1 = 120; //c1
float x2 = 800; float y2 = 200; //c2
float x3 = 350; float y3 = 400; //c3

  
//crea la finestra con cui interagire
void draw() {
  //slider riferimento
  Slider val1 = cp5.get(Slider.class, "raggio1");
  Slider val2 = cp5.get(Slider.class, "raggio2");
  Slider val3 = cp5.get(Slider.class, "raggio3");
 
  //valori raggi
  float r1 = val1.getValue(); 
  float r2 = val2.getValue();
  float r3 = val3.getValue(); 
  background(255,255,255,100);
  
  //Colore
  //colore e linea
  fill(color(71,146,207),20);
  stroke(color(71,146,207),20);
  
  //definisco i tre cerchi iniziali
  circle c1 = new circle(x1,y1,r1);
  circle c2 = new circle(x2, y2, r2);
  circle c3 = new circle(x3, y3, r3);
  
  //muovere c1
  if(mousePressed && mouseButton==LEFT && overCircle(x1,y1,r1*2)) {
    x1 = mouseX;
    y1 = mouseY;
    background(255);
  }
  //muovere c2
  if(mousePressed && mouseButton==LEFT && overCircle(x2,y2,r2*2)) {
    x2 = mouseX;
    y2 = mouseY;
    background(255);
  }
  //muovere c3
  if(mousePressed && mouseButton==LEFT && overCircle(x3,y3,r3*2)) {
    x3 = mouseX;
    y3 = mouseY;
    background(255);
  }
  
  solApollonio cs1 = new solApollonio(c1,c2,c3,1,1,1);
  solApollonio cs2 = new solApollonio(c1,c2,c3,-1,1,1);
  solApollonio cs3 = new solApollonio(c1,c2,c3,1,-1,1);
  solApollonio cs4 = new solApollonio(c1,c2,c3,1,1,-1);
  solApollonio cs5 = new solApollonio(c1,c2,c3,-1,1,-1);
  solApollonio cs6 = new solApollonio(c1,c2,c3,1,-1,-1);
  solApollonio cs7 = new solApollonio(c1,c2,c3,-1,-1,1);
  solApollonio cs8 = new solApollonio(c1,c2,c3,-1,-1,-1);
  
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
 
  //calcolare distanze
  float d12=sqrt(sq(x2-x1)+sq(y2-y1))-(r1+r2);
  float d23=sqrt(sq(x3-x2)+sq(y3-y2))-(r2+r3);
  float d31=sqrt(sq(x3-x1)+sq(y3-y1))-(r1+r3);
  
  //scrivere distanze
  fill(0,0,0);
  textSize(14);
  text("distanza 1-2 = "+d12, 800, 700);
  text("distanza 2-3 = "+d23, 800, 720);
  text("distanza 3-1 = "+d31, 800, 740); 
}

//funzione per sapere se il mouse è sopra il cerchio
boolean overCircle(float x, float y, float diameter) {
  float disX = x - mouseX;
  float disY = y - mouseY;
  if(sqrt(sq(disX) + sq(disY)) < diameter/2 ) {
    return true;
  } else {
    return false;
  }
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
    //le coordinate rappresentano il centro del cerchio
    ellipseMode(CENTER); 
     //formula che crea il cerchio, r*2 perché nell'ellipse rappresenta il diametro
    ellipse (positionX, positionY, radius*2, radius*2);
    /*for (float i=radius*2; i>0; i=i-20) {
      ellipse (positionX, positionY, i, i);
    }*/
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
      //le coordinate rappresentano il centro del cerchio
      ellipseMode(CENTER); 
      //formula che crea il cerchio, r*2 perché nell'ellipse rappresenta il diametro
      ellipse (X, Y, R*2, R*2); 
    }
}