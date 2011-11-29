/*
 * =====================================================================================
 *
 *       Filename:  openmp1.c
 *
 *    Description:  First test of OpenMP
 *
 *        Version:  1.0
 *        Created:  08/05/2011 20:41:37
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Matt Simpson (Maui Threv), mr.threv@gmail.com
 *        Company:
 *
 * =====================================================================================
 */
#include <stdio.h>
int main(int argc, const char *argv[])
{
  #pragma omp parallel
  {
    printf("Hello OpenMP!\n");
  }
  return 0;
}
