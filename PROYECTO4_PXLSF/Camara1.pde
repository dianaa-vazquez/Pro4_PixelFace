class Camara1
{
  Camara1()
  {
    
  }
  void display()
  {
    if (cam.available() == true) {
    cam.read();
    cam.loadPixels();
    int count = 0;
    for (int j = 0; j < nPAlto; j++) {
      for (int i = 0; i < nPAncho; i++) {
        mC[count] = cam.get(i*tamP, j*tamP);
        count++;
      }
    }
  }

  for (int j = 0; j < nPAlto; j++) {
    for (int i = 0; i < nPAncho; i++) {
      fill(mC[j*nPAncho+ i]);
      rect(i*tamP, j*tamP, tamP, tamP);
    }
  }
  }
}
