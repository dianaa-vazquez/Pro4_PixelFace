import gab.opencv.*;
import processing.video.*;
import java.awt.*;
int nPAncho, nPAlto;
int tamP=15;
color mC[];
Capture cam;
OpenCV opencv;

//varglob
int pant=1;
 
//PANTALLAS
Pantalla1 pantalla1;
Camara1 camara1;

ArrayList<Face> faceList;
Rectangle[] faces;

int faceCount = 0;

int scl = 2;


void setup()
{
  size(1280,720);
  //pantallas//
  pantalla1=new Pantalla1();
  camara1=new Camara1();

  
  //camara//
  cam=new Capture(this,1280,720);
  cam.start(); 
  nPAncho=width /tamP;
  nPAlto=height /tamP;
  mC= new color [nPAncho * nPAlto];
}


void draw()
{
  switch(pant)
  {
    case 1:
    pantalla1.display();
    if(key==' ' && keyPressed)
    {
      pant++;
    
 }
      keyPressed=false;
      break;
      
      case 2: 
      camara1.display();
    }
 }
 
 void detectFaces() {
 
  faces = opencv.detect();
  
  if (faceList.isEmpty()) {
    
    for (int i = 0; i < faces.length; i++) {
      faceList.add(new Face(faceCount, faces[i].x,faces[i].y,faces[i].width,faces[i].height));
      faceCount++;
    }
  } else if (faceList.size() <= faces.length) {
    boolean[] used = new boolean[faces.length];
    for (Face f : faceList) {
       
       float record = 50000;
       int index = -1;
       for (int i = 0; i < faces.length; i++) {
         float d = dist(faces[i].x,faces[i].y,f.r.x,f.r.y);
         if (d < record && !used[i]) {
           record = d;
           index = i;
         } 
       }
      
       used[index] = true;
       f.update(faces[index]);
    }
   
    for (int i = 0; i < faces.length; i++) {
      if (!used[i]) {
        println("+++ New face detected with ID: " + faceCount);
        faceList.add(new Face(faceCount, faces[i].x,faces[i].y,faces[i].width,faces[i].height));
        faceCount++;
      }
    }
  
  
  } else {
   
    for (Face f : faceList) {
      f.available = true;
    } 
 
    for (int i = 0; i < faces.length; i++) {
     
       float record = 50000;
       int index = -1;
       for (int j = 0; j < faceList.size(); j++) {
         Face f = faceList.get(j);
         float d = dist(faces[i].x,faces[i].y,f.r.x,f.r.y);
         if (d < record && f.available) {
           record = d;
           index = j;
         } 
       }
      
       Face f = faceList.get(index);
       f.available = false;
       f.update(faces[i]);
    } 
    
    for (Face f : faceList) {
      if (f.available) {
        f.countDown();
        if (f.dead()) {
          f.delete = true;
        } 
      }
    } 
  }
  
  
  for (int i = faceList.size()-1; i >= 0; i--) {
    Face f = faceList.get(i);
    if (f.delete) {
      faceList.remove(i);
    } 
  }
}
