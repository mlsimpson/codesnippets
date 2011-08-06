/*
 * =====================================================================================
 *
 *       Filename:  fixed_loopcount.c
 *
 *    Description:  Fixed loopcount in OpenMP
 *
 *        Version:  1.0
 *        Created:  08/05/2011 22:51:38
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
  int i, thread_id;
  int global_nloops, private_nloops;

  global_nloops = 0;

  #pragma omp parallel private(private_nloops, thread_id)
  {
    private_nloops = 0;

    thread_id = omp_get_thread_num();

    #pragma omp for
    for (i=0; i<100000; ++i)
    {
      ++private_nloops;
    }

   #pragma omp critical
    {
      printf("Thread %d adding its iterations (%d) to the sum (%d)...\n",
          thread_id, private_nloops, global_nloops);

      global_nloops += private_nloops;

      printf("...total nloops now equals %d.\n", global_nloops);
    }
  }

  printf("The total number of loop iterations is %d\n",
      global_nloops);

  return 0;
}
