#include <stdlib.h>
#include <stdio.h>

int x[8]={1, 2, 3, -1, -2, 0, 184, 340057058};
int y[8]={0, 0, 0, 0, 0, 0, 0, 0};


int f (int a) {
  int count = 0;
  for (int b= 0x80000000; a != 0; a=a << 1) {
    if ((a & b) != 0) {
      count++;
    }
  }
  return count;
}


int main (int argc, char** argv) {
  for (int i = 7; i >= 0; i--) {
    y[i] = f(x[i]);    
  }  
  for (int i = 0; i < sizeof(x)/sizeof(x[0]); i++) {
    printf("%d\n", x[i]);
  }
  for (int i = 0; i < sizeof(y)/sizeof(y[0]); i++) {
    printf("%d\n", y[i]);
  }


  return 0;


}
