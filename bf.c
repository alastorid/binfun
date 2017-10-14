#include <sys/mman.h>
#include <unistd.h>
#include <string.h>
#include <stdio.h>
typedef int (*pfun_add)(int*);
unsigned char *ucfun_add="\x55\x48\x89\xe5\x48\x89\x7d\xf8\x48\x8b\x45\xf8\x8b\x00\x8d\x50\x01\x48\x8b\x45\xf8\x89\x10\xb8\x00\x00\x00\x00\x5d\xc3";

pfun_add init_fun_add()
{
  size_t szfun_add=37;
  pfun_add pf=(pfun_add)mmap(NULL, szfun_add, PROT_READ | PROT_WRITE | PROT_EXEC, MAP_ANONYMOUS | MAP_SHARED, -1, 0);
  memcpy(pf,ucfun_add,szfun_add);
  return pf;
}

// Modify the typedef line above to match your dumped function.
// An example of calling the binary function.
//-------------------------
//   pfun_add fun_add=init_fun_add();
//   fun_add();
//-------------------------
//
int main(){
  int a=0;
  pfun_add fun_add=init_fun_add();
  printf("a=%d\n",a);
  fun_add(&a);
  printf("a=%d\n",a);
  return 0;
}
