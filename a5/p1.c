#include <stdlib.h>
#include <stdio.h>

struct D {
  int* d1;
  int* d2;
};

struct D* s;

int main(int argc, char** argv) {
  s = malloc(sizeof(struct D));
  s->d1 = malloc(2*(sizeof(int)));
  s->d2 = malloc(2*(sizeof(int)));
  int v0 = atoi(argv[1]);
  int v1 = atoi(argv[2]);
  int v2 = atoi(argv[3]);
  int v3 = atoi(argv[4]);
  s->d1[0] = v0;
  s->d1[1] = v1;
  s->d2[0] = v2;
  s->d2[1] = v3;
  s->d2[0] = s->d1[1];
  s->d1[0] = s->d2[1];
  printf("%d\n%d\n%d\n%d\n", s->d1[0], s->d1[1], s->d2[0], s->d2[1]);
  free(s->d1);
  free(s->d2);
  free(s);
}

