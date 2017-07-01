#include <stdio.h>

int i;
int j;
int m;
int n;

int foo_using_jumptable () {
  static const void* jumptable[9] = {&&L10, &&DEFAULT, &&L12, &&DEFAULT, &&L14, &&DEFAULT, &&L16,  &&DEFAULT, &&L18};
  
  int temp = m;
  if (i < 10 || i > 18) goto DEFAULT;
  goto *jumptable[i - 10];

L10:
  temp += j;
  n = temp;
  goto CONT;

L12:
  temp = 0 - temp;
  temp+= j;
  n = temp;
  goto CONT;

L14:
  temp = 0 - temp;
  temp+= j;
  if (temp > 0) {
    temp = 1;
    n = temp;
  } else {
    temp = 0;
    n = temp;
  }
  goto CONT;

L16:
  j = 0 - j;
  j += temp;
  if (j > 0) {
    temp = 1;
    n = temp;
  } else {
    temp = 0;
    n = temp;
  }
  goto CONT;

L18:
  temp = 0 - temp;
  temp += j;
  if (temp == 0) {
    temp = 1;
    n = temp;
  } else {
    temp = 0;
    n = temp;
  }
  goto CONT;
  
DEFAULT:
  temp = 0;
  n = temp;
  goto CONT;

CONT:
  return n;

}


int main(int argc, char** argv) {
  j = 0;
  m = 0;
  for (i=10; i<=18; i++) {
    printf("%d: %d\n", i, foo_using_jumptable());
  }
}
