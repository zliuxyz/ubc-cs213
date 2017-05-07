#include <stdlib.h>
#include <stdio.h>
#include <string.h>

struct Person_class {
  void* super;
  void (* toString) (void*, char*, int);
};

struct Person {
  struct Person_class* class;
  char* name;
};

void Person_toString(void* thisAP, char* buf, int bufSize) {
  struct Person* this = thisAP;
  snprintf(buf, bufSize, "%s%s", "Name: ", this->name);
}

struct Person_class Person_class_obj = {NULL, Person_toString};

struct Person* new_Person(char* name) {
  struct Person* obj = malloc(sizeof(struct Person));
  obj->class = &Person_class_obj;
  obj->name = strdup(name);
  return obj;
}

struct Student_class {
  struct Person_class* super;
  void (* toString) (void*, char*, int);
};

struct Student {
  struct Student_class* class;
  char* name;
  int SID;
};

void Student_toString(void* thisSP, char* buf, int bufSize) {
  struct Student* this = thisSP;
  char buf1[1000];
  this->class->super->toString(this, buf1, 1000);
  snprintf(buf, bufSize, "%s%s%d", buf1, ", SID: ", this->SID); 
}

struct Student_class Student_class_obj = {&Person_class_obj, Student_toString};

struct Student* new_Student(char* name, int SID) {
  struct Student* obj = malloc(sizeof(struct Student));
  obj->class = &Student_class_obj;
  obj->name = strdup(name);
  obj->SID = SID;
  return obj; 
}

void print(void* VP) {
  struct Person* p = VP;
  char buf[1000];
  p->class->toString(p, buf, 1000);
  printf("%s\n", buf);
}

int main(int argc, char** argv) {
  void * people[2] = {new_Person("Alex"), new_Student("Alice", 300)};
  for (int i= 0; i < 2; i++) {
    print(people[i]);
    struct Person* a= people[i];
    free(a->name);
    free(a);
  }
  return 0;
}











