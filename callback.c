/*
 * =====================================================================================
 *
 *       Filename:  callback.c
 *
 *    Description:  Implementation of callback functions
 *
 *        Version:  1.0
 *        Created:  12/20/2011 08:04:09 PM
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
#include <time.h>

/* The calling function takes a single callback as a parameter. */
void PrintTwoNumbers(int (*numberSource)(void)) {
  printf("%d and %d\n", numberSource(), numberSource());
}

/* A possible callback */
int overNineThousand(void) {
  return (rand() % 1000) + 9000;
}

/* Another possible callback. */
int meaningOfLife(void) {
  return 42;
}

/* Here we call PrintTwoNumbers() with three different callbacks. */
int main(void) {
  srand ( (unsigned)time ( NULL ) );
  PrintTwoNumbers(rand);
  PrintTwoNumbers(overNineThousand);
  PrintTwoNumbers(meaningOfLife);
  return 0;
}
