#define _POSIX_C_SOURCE 1
#include <stdio.h>
#include <math.h>
#include <omp.h>
#include <stdlib.h>
#define PI 3.14


double func(double x, double y)
{
	return exp(pow(x+y, 2));
}

double getrand(unsigned int *seed) 
{
    return (double)rand_r(seed) / RAND_MAX;
}

int main() {
	
	const int n = 10000000;
	printf("Numerical integration by Monte Carlo method: n = %d\n", n);
    int in = 0;
    double s = 0;
    double t = omp_get_wtime();
#pragma omp parallel
    {
        double s_loc = 0;
        int in_loc = 0;
        unsigned int seed = omp_get_thread_num();
#pragma omp for nowait
        for (int i = 0; i < n; i++) {
            double x = getrand(&seed) * 0.1;
            double y = getrand(&seed); 
            if (y <= 0.1 - x) {
                in_loc++;
                s_loc += func(x, y); {
   
                }
            }
        }
		#pragma omp atomic
        s += s_loc;
		#pragma omp atomic
        in += in_loc;
    }
    double v = PI * in / n;
    double res = v * s / in;
    t = omp_get_wtime() - t;
    printf("Result: %.12f, n %d\n", res, n);
    printf("Elapsed time: %f\n", t);
    return 0;
}
