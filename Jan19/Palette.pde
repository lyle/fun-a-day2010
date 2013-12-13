class Palette{
  color[] colors;
  Palette(String file){
    byte[] b=loadBytes(file);
    if(file.endsWith(".cs")){
      createPalette(b,8,26,b[2]&0xff);
    }
    else if (file.endsWith(".act")){
      createPalette(b,0,3,255);
    }
  }
  Palette(String file, int length){
    byte[] b=loadBytes(file);
    if(file.endsWith(".cs")){
      createPalette(b,8,26,length);
    }
    else if (file.endsWith(".act")){
      createPalette(b,0,3,length);
    }
  }
  void createPalette(byte[] b, int start, int steps, int length){
    colors=new color[length];
    int cnt=0;
    for(int i=0 ;i<length;i++){
      colors[i]=0xff<<24|b[start+i*steps]<<16|b[start+i*steps+1]<<8|b[start+i*steps+2];
    }
  }
}
