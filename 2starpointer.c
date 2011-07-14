#include <stdio.h>
#include <stdlib.h>

int main(){

  int **two_star_pointer = malloc(2 * sizeof( int * ) );

  int height = 5;

  *two_star_pointer = &height;

  printf("The value of height is: %d ", **two_star_pointer);
}
