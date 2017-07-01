#include <stdlib.h>
#include <stdio.h>
#include <assert.h>
#include "spinlock.h"
#include "uthread.h"
#include "uthread_util.h"
#include <pthread.h>


#define MAX_ITEMS 10
spinlock_t lock;
int items = 0;

const int NUM_ITERATIONS = 200;
const int NUM_CONSUMERS  = 2;
const int NUM_PRODUCERS  = 2;

int producer_wait_count;     // # of times producer had to wait
int consumer_wait_count;     // # of times consumer had to wait
int histogram [MAX_ITEMS+1]; // histogram [i] == # of times list stored i items

void produce() {
  // TODO ensure proper synchronization
  assert (items < MAX_ITEMS);
  items++;
  histogram [items] += 1;
}

void consume() {
  // TODO ensure proper synchronization
  assert (items > 0);
  items--;
  histogram [items] += 1;
}

void* producer(void* start_arg) {
  int i=0;
  while (i < NUM_ITERATIONS) {
    if (items < MAX_ITEMS) {
      spinlock_lock(&lock);
      if (items >= MAX_ITEMS) {
        producer_wait_count++;
      } else {
        produce();
        i++;
      }
      spinlock_unlock(&lock);
    }
  }
}

void* consumer(void* start_arg) {
  int i=0;
  while (i < NUM_ITERATIONS) {
    if (items > 0) {
      spinlock_lock(&lock);
      if (items <= 0) {
        consumer_wait_count++;
      } else {
        consume();
        i++;
      }
      spinlock_unlock(&lock);
    }
  }
}

int main (int argc, char** argv) {
  // TODO create threads to run the producers and consumers
  uthread_init (4);    
  spinlock_create(&lock);
  uthread_t ts[NUM_CONSUMERS + NUM_PRODUCERS];
  
  for (int i=0; i < NUM_PRODUCERS; i++) {
    uthread_t t = uthread_create(producer, NULL);
    ts[NUM_CONSUMERS + i] = t;
  }
  for (int i=0; i < NUM_CONSUMERS; i++) {
    uthread_t t = uthread_create(consumer, NULL);
    ts[i] = t;
  }
  for (int i=0; i < NUM_CONSUMERS + NUM_PRODUCERS; i++) {
    uthread_join(ts[i], NULL);
  }
  printf("Producer wait: %d\nConsumer wait: %d\n",
         producer_wait_count, consumer_wait_count);
  for(int i=0;i<MAX_ITEMS+1;i++)
    printf("items %d count %d\n", i, histogram[i]);
}
