#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#define EPS 1e-10

double rootC(const double beg, const double end, const size_t iterc, double (*f)(double));
double rootASM(const double beg, const double end, const size_t iterc, double (*f)(double));

double f(const double x);
double g(const double x);

double gC(const double x);
double gF(const double x);

int main()
{
    double beg = 0.0;
    double end = 0.0;
    size_t iterc = 0;

    printf("enter interval begin: ");
    scanf("%lf", &beg);

    printf("enter interval end: ");
    scanf("%lf", &end);

    printf("enter interval amount of iterations: ");
    scanf("%zu", &iterc);

    double resC = rootC(beg, end, iterc, f);
    printf("root in pure C=%lf\n", resC);

    double resASM = rootASM(beg, end, iterc, f);
    printf("root (midpoint calcultaion is optimised with FPU)=%lf\n", resASM);
}


double f(const double x)
{
    double res;
    double two = 2.0;
    double five = 5.0;
    __asm__ (
        "fldl %1\n"          
        "fmull %1\n"         
        "fsubl %2\n"         
        "fsin\n"            
        "fmull %3\n"        
        "fstpl %0"
        : "=m" (res)    
        : "m"(x),                   
          "m"(five),
          "m"(two)                    
    );
    return res;
}

double g(const double x)
{
    double res;
    double fv = 5.0;
    __asm__ (
        "fldl %1\n"        
        "fmull %1\n"
        "fldl %1\n"
        "fmull %2\n"
        "fsubp\n"         
        "fsin\n"          
        "fstpl %0"
        : "=m" (res)    
        : "m"(x),                   
          "m"(fv)                    
    );
    return res;
}

double gF(const double x)
{
    return 2 * sin(x*x-5);
}

double gC(const double x)
{
    return sin(x*x - 5*x);
}

double rootC(const double beg, const double end, const size_t iterc, double (*f)(double))
{
    if (f(beg) * f(end) > 0) {
        printf("root not found\n");
        exit(-1);
    }

    double begIt = beg;
    double endIt = end;
 
    for (size_t i = 0; i < iterc; ++i) {
        double Fbeg = f(begIt);
        double Fend = f(endIt);

        if (fabs(Fend - Fbeg) < EPS) {
            break;
        }

        double mid = (f(endIt) * begIt - f(begIt) * endIt) / (f(endIt) - f(begIt));
        if (f(begIt) * f(mid) > 0) {
            begIt = mid;
        } else {
            endIt  = mid; 
        }
    }
    
    return endIt;
}

double rootASM(const double beg, const double end, const size_t iterc, double (*f)(double))
{
    if (f(beg) * f(end) > 0) {
        printf("root not found\n");
        exit(-1);
    }

    double begIt = beg;
    double endIt = end;

    for (size_t i = 0; i < iterc; ++i) {
        double Fbeg = f(begIt);
        double Fend = f(endIt);

        if (fabs(Fend - Fbeg) < EPS) {
            break;
        }

        double mid;
        __asm__ (
            // Fend * begIt
            "fldl %1\n"            
            "fmull %4\n"

            // Fbeg * endIt
            "fldl %2\n"            
            "fmull %3\n" 
            "fsubrp %%st, %%st(1)\n"  

            "fldl %4\n"           
            "fsubl %3\n"          
            "fdivrp %%st, %%st(1)\n"  
           
            "fstpl %0"  
            : "=m" (mid)
            : "m" (begIt),
              "m" (endIt),
              "m" (Fbeg),
              "m" (Fend)
        );

        if (f(begIt) * f(mid) > 0) {
            begIt = mid;
        } else {
            endIt  = mid; 
        }
    }
    
    return endIt;
}

