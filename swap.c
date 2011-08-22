/*
 * =====================================================================================
 *
 *       Filename:  swap.c
 *
 *    Description:  Swapping variables
 *
 *        Version:  1.0
 *        Created:  08/21/2011 21:11:06
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Matt Simpson (Maui Threv), mr.threv@gmail.com
 *        Company:
 *
 * =====================================================================================
 */

#include <stdio.h>
#include <stdlib.h>


/*
 * ===  FUNCTION  ======================================================================
 *         Name:  swap
 *  Description:
 * =====================================================================================
 */
void swap ( int* a, int* b )
{
  int t = *a;
  *a = *b;
  *b = t;
}

int main(int argc, const char *argv[])
{
  int a = 3;
  int b = 2;

  printf("a is %d, b is %d\n", a, b);

  swap(&a, &b);

  printf("a is now %d, b is now %d\n", a, b);

  return 0;
}
