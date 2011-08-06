/*
 * =====================================================================================
 *
 *       Filename:  hello_threads.c
 *
 *    Description:  OpenMP Threads
 *
 *        Version:  1.0
 *        Created:  08/05/2011 20:52:23
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
  #define omp_get_num_threads() 0
  #define omp_get_thread_num() 0
#endif

int main(int argc, const char *argv[])
{
  int nthreads, thread_id;

  printf("I am the main thread.\n");

  #pragma omp parallel private(nthreads, thread_id)
  {
    nthreads = omp_get_num_threads();
    thread_id = omp_get_thread_num();

    printf("Hello.  I am thread %d out of a team of %d\n",
            thread_id, nthreads);

  }

  printf("Here I am, back to the main thread.\n");

  return 0;
}
