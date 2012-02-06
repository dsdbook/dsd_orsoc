#include "board.h"
int
main (void)
{
  long gpio_in;

//enable output
  REG32 (RGPIO_OE) = 0xffffffff;
  REG32 (RGPIO_OUT) = 0xA5A5A5A5;

  unsigned i,j;

  uart_init();
  uart_print_str("message from uart\n");

  REG32 (RGPIO_OUT) = 0xffffffff;

}
