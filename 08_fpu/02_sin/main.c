#include <stdio.h>
#include <math.h>

double sinPI();
double sinHPI();

int main(void)
{
    double PI = 3.14;
    double PI_PREC = 3.141596;

    {
        printf("PI=%lf\n", PI);
        printf("PI_PREC=%lf\n", PI_PREC);
        printf("\n");
    } 

    {
        printf("sin(PI)=%lf\n", sin(PI));
        printf("sin(PI/2)=%lf\n", sin(PI/2.0));
        printf("\n");
    }

    {
        printf("sin(PI_PREC)=%lf\n", sin(PI_PREC));
        printf("sin(PI_PREC/2)=%lf\n", sin(PI_PREC/2.0));
        printf("\n");
    }

    {
        printf("sin(fldpi)=%lf\n", sinPI());
        printf("sin(fldpi/2)=%lf\n", sinHPI());
        printf("\n");
    }

    return 0;
}

double sinPI()
{
    double r;
    __asm__ (
        "fldpi\n"    
        "fsin\n"     
        "fstpl %0" 
        : "=m"(r)   
    );

    return r;
}

double sinHPI()
{
    double tw = 2.0;
    double r;
    __asm__ (
        "fldpi\n"    
        "fdivl %1\n"
        "fsin\n"     
        "fstpl %0" 
        : "=m"(r)
        : "m" (tw) 
    );

    return r;
}