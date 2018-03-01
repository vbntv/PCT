/*
 * loop.c:
 *
 */
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <inttypes.h>

#include "hpctimer.h"

enum { n = 64 * 1024 * 1024 };

int main()
{
    int *v, i, sum;
    double t;
    
    if ( (v = malloc(sizeof(*v) * n)) == NULL) {
        fprintf(stderr, "No enough memory\n");
        exit(EXIT_FAILURE);
    }

    for (i = 0; i < n; i++)
        v[i] = 1;
   
    t = hpctimer_wtime();
   /* for (sum = 0, i = 0; i < n; ++i) {
        sum += v[i];

    }*/
    /* TODO: Unroll this loop */
    int t1, t2, t3, t4 = 0;
    for (sum = 0, i = 0; i < n; i += 4) {
        t1 = v[i];
        t2 = v[i + 1];
        t3 = v[i + 2];
        t4 = v[i + 3];
    }
    
    sum = t1 + t2 + t3 + t4;
     
    t = hpctimer_wtime() - t;

    printf("Sum = %d\n", sum);
    printf("Elapsed time (sec.): %.6f\n", t);

    free(v);
    return 0;
}
