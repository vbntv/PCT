#include <stdio.h>
#include <omp.h>
#include <stdlib.h>
#include <sys/time.h>
#include <inttypes.h>


double wtime() 
{
    struct timeval t;
    gettimeofday(&t, NULL);
    return (double)t.tv_sec + (double)t.tv_usec * 1E-6;
}

void run_serial(int n, int m)
{
    double *a, *b, *c;
    a = malloc(sizeof(*a) * m * n);
    b = malloc(sizeof(*b) * n);
    c = malloc(sizeof(*c) * m);
    
    for(int i = 0; i < m; i++)
    {
        for(int j = 0; j < n; j++)
            a[i * n + j] = i + j;
    }
     
    for(int j = 0; j < n; j++)
        b[j] = j;
    
    double t = wtime();
    matrix_vector_product_omp(a, b, c, m, n);
    t = wtime() - t;
    printf("Elapsed time(serial): %.6f sec. \n", t);
    free(a);
    free(b);
    free(c);
}

void matrix_vector_product_omp(double *a, double *b, double *c, int m, int n)
{
    #pragma omp parallel for
    for(int i = 0; i <= m; i++)
    {
        c[i] = 0.0;
        for(int j = 0; j < n; j++)
            c[i] += a[i * n + j] * b[j];
    }
    
}


void run_parallel(int n, int m)
{
    double *a, *b, *c;
    a = malloc(sizeof(*a) * m * n);
    b = malloc(sizeof(*b) * n);
    c = malloc(sizeof(*c) * m);
    #pragma omp parallel for
    for (int i = 0; i <= m; i++)
    {
        for(int j = 0; j < n; j++)
            a[i * n + j] = i + j;
    }
    for(int j = 0; j < n; j++)
    {
        b[j] = j;
    }
    double t = wtime();
    matrix_vector_product_omp(a, b, c, m, n);
    t = wtime() - t;
    printf("Elapsed time(parallel): %.6f sec. \n", t);
    free(a);
    free(b);
    free(c);
}

int main(int argc, int **argv)
{
    char *buff;
    int m, n;    
    if(argc < 1)
    {
        printf("Error: few arguments");
        return 0;
    }
    m = strtol(argv[1], &buff, 10);
    n = strtol(argv[2], &buff, 10);
    printf("Matrix-vector product (c[m] = a[m, n] * b [n]; m = %d, n = %d)\n", m, n);
    printf("Memory used: %" PRIu64 "MiB\n", ((m * n + m + n) * sizeof(double)) >> 20);
    run_serial(n, m);
    run_parallel(n, m);
    return 0;
    
}



