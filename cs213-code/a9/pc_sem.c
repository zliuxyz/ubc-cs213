#include <stdlib.h>
#include <stdio.h>
#include <assert.h>
#include "uthread.h"
#include "uthread_sem.h"

#define MAX_ITEMS 10
const int NUM_ITERATIONS = 200;
const int NUM_CONSUMERS  = 2;
const int NUM_PRODUCERS  = 2;

int histogram [MAX_ITEMS+1]; // histogram [i] == # of times list stored i items

struct Pool {
  uthread_sem_t mutex;
  uthread_sem_t empty;
  uthread_sem_t full;
  int           items;
};

struct Pool* createPool() {
  struct Pool* pool = malloc (sizeof (struct Pool));
  pool->mutex = uthread_sem_create(1);
  pool->empty = uthread_sem_create(MAX_ITEMS);
  pool->full = uthread_sem_create(0);
  pool->items     = 0;
  return pool;
}

void* producer (void* pv) {
  struct Pool* p = pv;
  for (int i=0; i < NUM_ITERATIONS; i++) {
    uthread_sem_wait(p->empty);
    uthread_sem_wait(p->mutex);
    p->items++;
    histogram[p->items]++;
    uthread_sem_signal(p->mutex);
    uthread_sem_signal(p->full);
  }
  return NULL;
}

void* consumer (void* pv) {
  struct Pool* p = pv;
  for (int i=0; i < NUM_ITERATIONS; i++) {
    uthread_sem_wait(p->full);
    uthread_sem_wait(p->mutex);
    p->items--;
    histogram[p->items]++;
    uthread_sem_signal(p->mutex);
    uthread_sem_signal(p->empty);
  }
  return NULL;
}

int main (int argc, char** argv) {
  uthread_t t[4];

  uthread_init (4);
  struct Pool* p = createPool();
  
  
  for (int i=0; i < 2; i++)
    t[i] = uthread_create(producer, p);
  for (int i=2; i < 4; i++)
    t[i] = uthread_create(consumer, p);
  for (int i=2; i < 4; i++)
    uthread_join(t[i], NULL);
  for (int i=0; i < 2; i++)
    uthread_join(t[i], NULL);
  
  printf ("items value histogram:\n");
  int sum=0;
  for (int i = 0; i <= MAX_ITEMS; i++) {
    printf ("  items=%d, %d times\n", i, histogram [i]);
    sum += histogram [i];
  }
  assert (sum == sizeof (t) / sizeof (uthread_t) * NUM_ITERATIONS);
}
