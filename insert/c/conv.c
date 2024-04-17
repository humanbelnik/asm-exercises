#include <stdio.h>

int foo(int a, int b, int c, int d)
{
    return a + b + c + d;
}

int main(void)
{
    int a = 0;
    int b = 1;
    int c = 2;
    int d = 3;
    int x = foo(0,1,2,3);
    printf("%d\n", x);
    return 0;
}