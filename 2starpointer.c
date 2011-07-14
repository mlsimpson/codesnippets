#include <stdio.h>
#include <stdlib.h>

int main(){

  int height = 5;
  int width = 10;

  int **two_star_int = malloc(2 * sizeof(int *) );

  *(two_star_int + 0) = &height;
  *(two_star_int + 1) = &width;

  printf("The values are: %d and %d  ", **two_star_int, **(two_star_int + 1) );

}
