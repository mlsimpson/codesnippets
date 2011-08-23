/*
 * =====================================================================================
 *
 *       Filename:  strcat.c
 *
 *    Description:  strcat test
 *
 *        Version:  1.0
 *        Created:  08/23/2011 14:21:26
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Matt Simpson (Maui Threv), mr.threv@gmail.com
 *        Company:
 *
 * =====================================================================================
 */

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

  int
foo(const char *arbitrary_string)
{
  char onstack[8] = "";
  /*
   * These lines are even more robust due to testing for
   * truncation.
   */
  if (strlen(arbitrary_string) + 1 >
      sizeof(onstack) - strlen(onstack)){
    printf("onstack would be truncated\n");
    return EXIT_FAILURE;
  }
  (void)strncat(onstack, arbitrary_string,
      sizeof(onstack) - strlen(onstack) - 1);

  return EXIT_SUCCESS;
}

int main(int argc, const char *argv[])
{
  char* str = "arbing";
  int retval;

  retval = foo(str);
  if (retval > 0) {
    printf("strcat failed\n");
  } else {
    printf("strcat succeeded\n");
  }
  return 0;
}
