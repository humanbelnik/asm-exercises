#include <stdlib.h>
#include <stdio.h>
#include <time.h>

float randFloat();
double randDouble();

#define N (size_t) 10000
#define BILLION 1000000000L


float add_floats_asm(float a, float b) {
    float result;
    
    asm (
        "fldl %1 \n"     
        "faddl %2 \n"    
        "fstpl %0"       
        : "=m" (result)
        : "m" (a), "m" (b)
    );
    return result;
}

float multiply_floats_asm(float a, float b) {
    float result;
    
    asm (
        "fldl %1 \n"    
        "fmull %2 \n"  
        "fstpl %0"     
        : "=m" (result)
        : "m" (a), "m" (b)
    );

    return result;
}

double add_doubles_asm(double a, double b) {
    double result;
    
    asm (
        "fldl %1 \n"     
        "faddl %2 \n"    
        "fstpl %0"       
        : "=m" (result)
        : "m" (a), "m" (b)
    );

    return result;
}

double multiply_doubles_asm(double a, double b) {
    double result;
    
    asm (
        "fldl %1 \n"      
        "fmull %2 \n"     
        "fstpl %0"        
        : "=m" (result)
        : "m" (a), "m" (b)
    );

    return result;
}


int main(void)
{
    
    struct timespec start, end;
    long long int diff;
    
    {
        printf("...test float addition in pure C\n");
        long long int r = 0.0; 
        for (size_t i = 0; i < N; ++i) {
            float a = randFloat();
            float b = randFloat(); 

            clock_gettime(CLOCK_MONOTONIC, &start);
            float c = a + b; 
            clock_gettime(CLOCK_MONOTONIC, &end);
            diff = BILLION * (end.tv_sec - start.tv_sec) + end.tv_nsec - start.tv_nsec;
            r += diff;
        }
        printf("res=%lld nsec\n\n", r/N);
    }   

    {
        printf("...test float multiplication in pure C\n");
        long long int r = 0.0; 
        for (size_t i = 0; i < N; ++i) {
            float a = randFloat();
            float b = randFloat(); 

            clock_gettime(CLOCK_MONOTONIC, &start);
            float c = a * b; 
            clock_gettime(CLOCK_MONOTONIC, &end);
            diff = BILLION * (end.tv_sec - start.tv_sec) + end.tv_nsec - start.tv_nsec;
            r += diff;
        }
        printf("res=%lld nsec\n\n", r/N);
    }   

    {
        printf("...test double addition in pure C\n");
        long long int r = 0.0; 
        for (size_t i = 0; i < N; ++i) {
            double a = randDouble();
            double b = randDouble(); 

            clock_gettime(CLOCK_MONOTONIC, &start);
            double c = a + b; 
            clock_gettime(CLOCK_MONOTONIC, &end);
            diff = BILLION * (end.tv_sec - start.tv_sec) + end.tv_nsec - start.tv_nsec;
            r += diff;
        }
        printf("res=%lld nsec\n\n", r/N);
    }  

    {
        printf("...test double multiplication in pure C\n");
        long long int r = 0.0; 
        for (size_t i = 0; i < N; ++i) {
            double a = randDouble();
            double b = randDouble(); 

            clock_gettime(CLOCK_MONOTONIC, &start);
            double c = a * b; 
            clock_gettime(CLOCK_MONOTONIC, &end);
            diff = BILLION * (end.tv_sec - start.tv_sec) + end.tv_nsec - start.tv_nsec;
            r += diff;
        }
        printf("res=%lld nsec\n\n", r/N);
    }  

    {
        printf("...test double addition with FPU\n");
        long long int r = 0.0; 
        for (size_t i = 0; i < N; ++i) {
            double a = randDouble();
            double b = randDouble(); 

            clock_gettime(CLOCK_MONOTONIC, &start);
            double c = add_doubles_asm(a, b); 
            clock_gettime(CLOCK_MONOTONIC, &end);
            diff = BILLION * (end.tv_sec - start.tv_sec) + end.tv_nsec - start.tv_nsec;
            r += diff;
        }
        printf("res=%lld nsec\n\n", r/N);
    }  


    {
        printf("...test double multiplication with FPU\n");
        long long int r = 0.0; 
        for (size_t i = 0; i < N; ++i) {
            double a = randDouble();
            double b = randDouble(); 

            clock_gettime(CLOCK_MONOTONIC, &start);
            double c = multiply_doubles_asm(a, b); 
            clock_gettime(CLOCK_MONOTONIC, &end);
            diff = BILLION * (end.tv_sec - start.tv_sec) + end.tv_nsec - start.tv_nsec;
            r += diff;
        }
        printf("res=%lld nsec\n\n", r/N);
    }  

    {
        printf("...test float addition with FPU\n");
        long long int r = 0.0; 
        for (size_t i = 0; i < N; ++i) {
            float a = randFloat();
            float b = randFloat(); 

            clock_gettime(CLOCK_MONOTONIC, &start);
            float c = add_floats_asm(a, b); 
            clock_gettime(CLOCK_MONOTONIC, &end);
            diff = BILLION * (end.tv_sec - start.tv_sec) + end.tv_nsec - start.tv_nsec;
            r += diff;
        }
        printf("res=%lld nsec\n\n", r/N);
    } 

    {
        printf("...test float multiplication with FPU\n");
        long long int r = 0.0; 
        for (size_t i = 0; i < N; ++i) {
            float a = randFloat();
            float b = randFloat(); 

            clock_gettime(CLOCK_MONOTONIC, &start);
            float c = multiply_floats_asm(a, b); 
            clock_gettime(CLOCK_MONOTONIC, &end);
            diff = BILLION * (end.tv_sec - start.tv_sec) + end.tv_nsec - start.tv_nsec;
            r += diff;
        }
        printf("res=%lld nsec\n\n", r/N);
    }     

    return 0;
}

float randFloat()
{
    float max = __FLT_MAX__;
    float min = __FLT_MIN__;

    return ((float)rand() / RAND_MAX) * (max - min) + min;
}

double randDouble()
{
    double max = __DBL_MAX__;
    double min = __DBL_MIN__;

    return ((double)rand() / RAND_MAX) * (max - min) + min;
}
