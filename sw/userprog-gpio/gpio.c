#include "board.h"
//unsigned int static  a[20000];
int
main (void)
{
  long gpio_in;

//enable output
  REG32 (RGPIO_OE) = 0xffff00ff;
  REG32 (RGPIO_OUT) = 0x5A5A5A5A;
	//while(1);
//  REG32 (RGPIO_OUT) = 0xffffffff;
#if  1
  int i;
  volatile int j;
  volatile int k;
  k=10;
  while (1)
    {
//delay
//	for(i=0; i<20000; i++)
	for(i=0; i<20; i++)
	{
		j = j + 1;
	}

//      	gpio_in = REG32 (RGPIO_IN);
//     	REG32 (RGPIO_OUT) = gpio_in;
	k++;
     	REG32 (RGPIO_OUT) = k%32;
    }
#endif
}
