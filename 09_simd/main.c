#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define BILLION 1000000000L

void fill_random(float *matrix, int size) {
    for (int i = 0; i < size * size; i++) {
        matrix[i] = (float)rand() / RAND_MAX; 
    }
}

void input_matrix(float *matrix, int size) {
    printf("Enter the elements of the matrix (%dx%d):\n", size, size);
    for (int i = 0; i < size; i++) {
        for (int j = 0; j < size; j++) {
            printf("Enter element [%d][%d]: ", i, j);
            scanf("%f", &matrix[i * size + j]);
        }
    }
}

void print_matrix(float *matrix, int size) {
    printf("Matrix:\n");
    for (int i = 0; i < size; i++) {
        for (int j = 0; j < size; j++) {
            printf("%6.2f ", matrix[i * size + j]);
        }
        printf("\n");
    }
}

void transpose_matrix(float *matrix, int size) {
    for (int i = 0; i < size; i++) {
        for (int j = i + 1; j < size; j++) {
            float temp = matrix[i * size + j];
            matrix[i * size + j] = matrix[j * size + i];
            matrix[j * size + i] = temp;
        }
    }
}


void dotprod(float *m1, float *m2, float *res, int size)
{
    transpose_matrix(m2, size);
    for (size_t i = 0; i < size; i++)
        for (size_t j = 0; j < size; j++)
            for (size_t k = 0; k < size; k++)
                res[i * size + j] += m1[i * size + k] * m2[j * size +k];
}

void dotprodSSE(float *m1, float *m2, float *res, int size)
{
    transpose_matrix(m2, size);
    for (int i = 0; i < size; i++) {
        float *row = m1 + i * size;

        for (int k = 0; k < size; ++k) { 
            float *col = m2 + k * size;

            float sum = 0;
            for (int j = 0; j < size/4; j++) {                
                float* rowBlock = row + j * 4; 
                float* colBlock = col + j * 4; 
                float r = 0.0;

                __asm__ (
                    "movups xmm1, %1\n"
                    "movups xmm2, %2\n"
                    "mulps xmm1, xmm2\n"
                    "haddps xmm1, xmm1\n"
                    "movups %0, xmm1\n"
                    : "=m"(r)
                    : "m"(*rowBlock), "m"(*colBlock)
                    : "xmm0", "xmm1", "xmm2" 
                );
                sum += r;
            }
            
            res[i * size + k] = sum;
        }
    }
}



int main(int argc, char **argv)
{
    int size = atoi(argv[1]); 

    // printf("Enter the size of the square matrices: ");
    // scanf("%d", &size);

    float *matrix1 = (float *)malloc(size * size * sizeof(float));
    float *matrix2 = (float *)malloc(size * size * sizeof(float));
    float *res = (float *)malloc(size * size * sizeof(float));

    // char choice;
    // printf("Do you want to fill the matrices yourself? (y/n): ");
    // scanf(" %c", &choice);

    // if (choice == 'y' || choice == 'Y') {
    //     input_matrix(matrix1, size);
    //     input_matrix(matrix2, size);
    // } else {
    //     fill_random(matrix1, size);
    //     fill_random(matrix2, size);
    // }

    fill_random(matrix1, size);
    fill_random(matrix2, size);

    struct timespec start, end;
    long long int diff;

    { 
        clock_gettime(CLOCK_MONOTONIC, &start);
        dotprodSSE(matrix1, matrix2, res, size);
        clock_gettime(CLOCK_MONOTONIC, &end);
        diff = BILLION * (end.tv_sec - start.tv_sec) + end.tv_nsec - start.tv_nsec;
        printf(" %lld ", diff);
    }

    { 
        clock_gettime(CLOCK_MONOTONIC, &start);
        dotprod(matrix1, matrix2, res, size);
        clock_gettime(CLOCK_MONOTONIC, &end);
        diff = BILLION * (end.tv_sec - start.tv_sec) + end.tv_nsec - start.tv_nsec;
        printf("%lld\n", diff);
    }


    free(matrix1);
    free(matrix2);
    free(res);

    return 0;
}
