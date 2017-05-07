#include <stdlib.h>
#include <stdio.h>

int a[10];

void bar (int m, int n) {
  a[n] = a[n] + m; 
  return; 
}

void foo () {
  int l0 = 1;
  int l1 = 2;
  bar (3 , 4);
  bar (l0, l1);
  return;
}

int main (int argc, char** argv) {
  foo();
  for (int i=0; i< (sizeof(a)/sizeof(a[0])); i++ ) {
    printf("%d\n", a[i]);
  }
  return 0;
}
