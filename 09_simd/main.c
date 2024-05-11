#include <stdio.h>
#include <stdlib.h>
#include <time.h>

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
                float r[4] = { 0 };
                
                float* rowBlock = row + j * 4; 
                float* colBlock = col + j * 4; 

                __asm__ (
                    "movups xmm1, %1\n"
                    "movups xmm2, %2\n"
                    "mulps xmm1, xmm2\n"
                    "movups %0, xmm1\n"
                    : "=m"(r)
                    : "m"(*rowBlock), "m"(*colBlock)
                    : "xmm0", "xmm1", "xmm2" 
                );
                for (size_t e = 0; e < 4; e++) {
                    sum += r[e];
                }
            }
            
            res[i * size + k] = sum;
        }
    }
}



int main(void)
{
    int size;

    printf("Enter the size of the square matrices: ");
    scanf("%d", &size);

    float *matrix1 = (float *)malloc(size * size * sizeof(float));
    float *matrix2 = (float *)malloc(size * size * sizeof(float));
    float *res = (float *)malloc(size * size * sizeof(float));

    char choice;
    printf("Do you want to fill the matrices yourself? (y/n): ");
    scanf(" %c", &choice);

    if (choice == 'y' || choice == 'Y') {
        input_matrix(matrix1, size);
        input_matrix(matrix2, size);
    } else {
        fill_random(matrix1, size);
        fill_random(matrix2, size);
    }

    printf("\nMatrix 1:\n");
    print_matrix(matrix1, size);

    printf("\nMatrix 2:\n");
    print_matrix(matrix2, size);

    dotprodSSE(matrix1, matrix2, res, size);
    print_matrix(res, size);

    free(matrix1);
    free(matrix2);
    free(res);

    return 0;
}
