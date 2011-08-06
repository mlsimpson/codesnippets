/*
 * =====================================================================================
 *
 *       Filename:  montecarlomp.c
 *
 *    Description:  Calculating Pi with the Monte Carlo algorithm and OpenMP
 *
 *        Version:  1.0
 *        Created:  08/05/2011 22:55:53
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Matt Simpson (Maui Threv), mr.threv@gmail.com
 *        Company:
 *
 * =====================================================================================
 */

#include <stdio.h>
#include <math.h>
#include <stdlib.h>

#ifdef _OPENMP
  #include <omp.h>
#else
  #define omp_get_thread_num() 0
#endif

/*
 * ===  FUNCTION  ======================================================================
 *         Name:  rand_one
 *  Description:  Returns a random value between 0 and 1
 * =====================================================================================
 */
double rand_one ()
{
  return rand() / (RAND_MAX + 1.0);
}		/* -----  end of function rand_one  ----- */

int main(int argc, const char *argv[])
{
  int inside, outside;
  int pvt_inside, pvt_outside;
  int i;

  double x, y, r, pi;

  inside = 0;
  outside = 0;

  #pragma omp parallel private(x, y, r, pvt_inside, pvt_outside) reduction(+ : inside, outside)
  {
    pvt_inside = 0;
    pvt_outside = 0;

    #pragma omp for
    for (i = 0; i < 1000000; ++i) {
      x = (2*rand_one()) - 1;
      y = (2*rand_one()) - 1;

      r = sqrt(x*x + y*y);

      if (r < 1.0) {
        ++inside;
      }
      else {
        ++outside;
      }
    }

    inside += pvt_inside;
    outside += pvt_outside;
  }

  pi = (4.0 * inside) / (inside + outside);

  printf("The estimated value of pi is %f\n", pi);

  return 0;
}
