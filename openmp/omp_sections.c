/*
 * =====================================================================================
 *
 *       Filename:  omp_sections.c
 *
 *    Description:  Sections in OpenMP
 *
 *        Version:  1.0
 *        Created:  08/05/2011 22:13:17
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Matt Simpson (Maui Threv), mr.threv@gmail.com
 *        Company:
 *
 * =====================================================================================
 */

#include <stdio.h>
#include <unistd.h>

#ifdef _OPENMP
#include <omp.h>
#else
#define omp_get_thread_num() 0
#endif

void times_table(int n)
{
  int i, i_times_n, thread_id;

  thread_id = omp_get_thread_num();

  for (i=1; i<=n; ++i)
  {
    i_times_n = i * n;
    printf("Thread %d says %d times %d equals %d.\n",
        thread_id, i, n, i_times_n );

    sleep(1);
  }
}

void countdown()
{
  int i, thread_id;

  thread_id = omp_get_thread_num();

  for (i=10; i>=1; --i)
  {
    printf("Thread %d says %d...\n", thread_id, i);
    sleep(1);
  }

  printf("Thread %d says \"Lift off!\"\n", thread_id);
}

void long_loop()
{
  int i, thread_id;
  double sum = 0;

  thread_id = omp_get_thread_num();

  for (i=1; i<=10; ++i)
  {
    sum += (i*i);
    sleep(1);
  }

  printf("Thread %d says the sum of the long loop is %f\n",
      thread_id, sum);
}

int main(int argc, char **argv)
{
  printf("This is the main thread.\n");

#pragma omp parallel
  {
#pragma omp sections
    {
#pragma omp section
      {
        times_table(12);
      }
#pragma omp section
      {
        countdown();
      }
#pragma omp section
      {
        long_loop();
      }
    }
  }

  printf("Back to the main thread. Goodbye!\n");

  return 0;
}
