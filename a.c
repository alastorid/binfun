#include <stdio.h>

int fun_add(int *a){
  *a=*a+1;
  return 0;
}

int main()
{
   int a=0;
   printf("a=%d\n",a);
   fun_add(&a);
   printf("a=%d\n",a);
   return 0;
}
