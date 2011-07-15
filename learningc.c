#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(void) {
  // For looping purposes
  int i=0;

  // Allocate a ten-byte working space
  char *main_pointer = malloc(10);

  // Set the first two bytes of this working space to 'AB' using the pointer offset method.
  *(main_pointer + 0) = 'A';
  *(main_pointer + 1) = 'B';

  // Set the next two bytes to: 'CD' using array indexing.
  main_pointer[2] = 'C';
  main_pointer[3] = 'D';

  // Set the rest of the string using the strcpy() function.
  strcpy( (main_pointer + 4), "EFGHI");

  // At this stage, our entire string is set to: ABCDEFGHI<NUL>
  printf("First we use our ten bytes as a string like this: %s  ", main_pointer);
  printf("\n");

  // Output: First we use our ten bytes as a string like this: ABCDEFGHI

  // Let's go through all ten bytes and display the hex value of each character
  printf("Our ten bytes of memory look like this: (41 is A, 42 is B, etc.) :  ");
  for (i = 0; i < 10; i++) {
    printf("%02x ", (unsigned char) *(main_pointer+i));
  }
  printf("\n");

  // Output: Our ten bytes of memory look like this: (41 is A, 42 is B, etc.) :

  // Output: 41 42 43 44 45 46 47 48 49 00

  printf("  ");
  printf("\n");
  // Now let's create an array of two integer pointers
  int **int_pointer_array = malloc(2 * sizeof( int * ) );


  // Set the first of these integer pointers to point at byte #0 of our ten-byte working space
  // and set the second to point at byte #6 of our ten-byte working space.

  int_pointer_array[0] = (int *) main_pointer;
  int_pointer_array[1] = (int *) (main_pointer + 6);

  printf("Now we will use B0->B3 as an integer, and B6->B9 as another integer... ");
  printf("\n");
  // Output: Now we will use B0->B3 as an integer, and B6->B9 as another integer...

  // (Note: remember this is B0->B3 of our ten byte working space.)

  // Give these two pointers a value.
  *int_pointer_array[0] = 5;
  *int_pointer_array[1] = 15;

  // Using printf() we prove that the values we set are accurate, and we can see how they are represented
  // as occupying 4 bytes of memory, the way a true int is expected to

  printf("The first integer is: %d (hex: %08x)  ", *int_pointer_array[0], (unsigned int) *int_pointer_array[0]);
  printf("\n");
  printf("The second integer is: %d (hex: %08x)  ", *int_pointer_array[1], (unsigned int) *int_pointer_array[1]);
  printf("\n");
  // Output: The first integer is: 5 (hex: 00000005)

  // Output: The second integer is: 15 (hex: 0000000f)

  printf(" ");
  printf("\n");
  printf("Our entire ten byte memory space now looks like this:  ");
  printf("\n");
  // Again we go through all 10 bytes and display their new contents.
  // It is easy to see that the first four bytes and the last four bytes are
  // the integers we created.

  for (i = 0; i < 10; i++) {
    printf("%02x ", (unsigned char) *(main_pointer+i));
  }

  printf(" ");
  printf("\n");
  // Output: Our entire ten byte memory space now looks like this:

  // Output: 05 00 00 00 45 46 0f 00 00 00

  // (Note: Notice that the integers are 05 00 00 00, rather than 00 00 00 05. We will get to that later.)

  // Finally we demonstrate that bytes #4 and #5 are unaffected, and that our integer values remain set.
  printf(" Bytes #4 and #5 are set to: %c and %c  ", *(main_pointer + 4), *(main_pointer + 5));
  printf("\n");
  printf(" ");
  printf("\n");
  printf("Our two integers are set to: %d and %d  ", *int_pointer_array[0], *int_pointer_array[1]);
  printf("\n");
  // Output: Notice that Bytes #4 and #5 are unaffected and remain set to: E and F

  // Output: Still, our two integers are set to: 5 and 15 and occupy this same 10 byte space

  free(main_pointer);
  free(int_pointer_array);

  return 0;
}
