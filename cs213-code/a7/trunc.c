#include "list.h"
#include "list.c"
#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include <string.h>

void print (element_t ev) {
  char* e = (char*) ev;
  printf ("%s\n", e);
}

int checks (element_t ev) {
  char* e = (char*) ev;
  char* end = NULL;
  int val = strtol(e, &end, 10);
  if (*end == 0) {    
    return 1;
  } else if (end == NULL) {
    return 0;
  } else {
    return 0;
  }
}

int rmneg (element_t ev) {
  intptr_t e = (intptr_t) ev;
  if (e >= 0) {
    return 1;
  } else {
    return 0;
  }
}

int rmnull (element_t ev) {
  char* e = (char*) ev;
  if (e == NULL) {
    return 0;
  } else {
    return 1;
  }
}

void mytrunc (element_t* ev0, element_t ev1, element_t ev2) {
  intptr_t e1 = (intptr_t) ev1;
  char* e2 = (char*) ev2;
  char** e0 = (char**) ev0;
  e2[e1] = 0;
  *e0 = e2;
}

int main(int argc, char** argv) {

  // list of elements from command line input.
  struct list* l0 = list_create(); 
  for (int i=1; i<argc; i++) {
    list_append(l0, (element_t) argv[i]);
  } 

  // list of numbers. 
  struct list* l1 = list_create();
  for (int i=0; i<list_len(l0); i++) {
    if (checks (l0->data[i]) == 1) {
      char* end = NULL;
      intptr_t val = strtol((char*) l0->data[i], &end, 10);
      list_append(l1, (element_t) val);
    } else {
      list_append(l1, (element_t) -1);
    } 
  }

  // list of strings.
  struct list* l2 = list_create();
  for (int i=0; i<l1->len; i++) {
    if ((intptr_t)l1->data[i] == -1) {
      list_append(l2, l0->data[i]);
    } else {
      list_append(l2, NULL);
    }
  }

  // list of numbers with neg. removed.
  struct list* l3 = list_create();
  list_filter(rmneg, l3, l1);


  // list of strings with NULL removed.
  struct list* l4 = list_create();
  list_filter(rmnull, l4, l2);


  struct list* l5 = list_create();
  list_map2(mytrunc, l5, l3, l4);
  printf("list after trunc:\n");
  list_foreach(print, l5);

  int max = 0;
  for (int i=0; i <l3->len; i++) {
    if ((intptr_t)l3->data[i] > max) {
      max = (intptr_t)l3->data[i];
    }
  }
  printf("max: \n");
  printf("%d\n", max);

  list_destroy(l0);
  list_destroy(l1);
  list_destroy(l2);
  list_destroy(l3);
  list_destroy(l4);
  list_destroy(l5);
	
  return 0;
}
