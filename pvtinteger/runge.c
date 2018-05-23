#include <stdio.h>
#include <math.h>
#include <omp.h>

// gcc -fopenmp -Wall -o montecarlo monte-carlo.c -lm




double func(double x)
{
	return x/(pow(sin(2*x),3));
}


int main() {
  /*  if (argc < 1) {
        printf("Error, no arguments");
	return 0;
    }

    char* temp;
    uint16_t m = strtol(argv[1], &temp, 10);
  */
    const double a = 0.1;
	
    const double b = 0.5;
    const double eps = 1e-5;
    const int n0 = 100000000;
    double sq[2];
	double t = omp_get_wtime();
    #pragma omp parallel
    {
        double delta = 1;
        int n = n0, k;
        for (k = 0; delta > eps; n *= 2, k ^= 1) {
            double h = (b - a) / n;
            double s = 0.;
            sq[k] = 0;
			//wait             
			#pragma omp barrier

            #pragma omp for nowait
            for (int i = 0; i < n; i++)
				s += func(a + h * (i + 0.5));

            #pragma omp atomic
            sq[k] += s * h;
			//wait
            #pragma omp barrier
            if (n > n0) {
                delta = fabs(*(sq + k) - *(sq + (k^1))) / 3.0;
            }
			#if 0
			printf("n = %d i = %d sq = %.12f delta = %.12f\n", n, k, sq[k], delta);
			#endif
        }
        #pragma omp master
        printf("Result Pi: %.12f; Runge Rule EPS %e, n %d\n", sq[k] * sq[k], eps, n / 2);
    }
    t = omp_get_wtime() - t;
   printf("Elapsed time (sec.): %.6f\n", t);
    return 0;
}
