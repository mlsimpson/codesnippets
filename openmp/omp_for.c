/*
 * =====================================================================================
 *
 *       Filename:  omp_for.c
 *
 *    Description:  For loop in OMP
 *
 *        Version:  1.0
 *        Created:  08/05/2011 22:24:10
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Matt Simpson (Maui Threv), mr.threv@gmail.com
 *        Company:
 *
 * =====================================================================================
 */

#include <stdio.h>
#ifdef _OPENMP
  #include <omp.h>
#else
  #define omp_get_thread_num() 0
#endif

int main(int argc, char **argv)
{
  int i, thread_id, nloops;

  #pragma omp parallel private(thread_id, nloops)
  {
    nloops = 0;

    #pragma omp for
    for (i=0; i<10000; ++i)
    {
      ++nloops;
    }

    thread_id = omp_get_thread_num();

    printf("Thread %d performed %d iterations of the loop.\n",
        thread_id, nloops );
  }

  return 0;
}
