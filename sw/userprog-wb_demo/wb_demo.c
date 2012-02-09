#include "board.h"
#define WB_DEMO_ADDR    0x60000000
struct wb_demo_reg{
    unsigned int A;
    unsigned int B;
    unsigned int op;
    unsigned int Y;
    unsigned int status;
};

int
main (void)
{
  long gpio_in;

//enable output
  REG32 (RGPIO_OE) = 0xffff00ff;
  REG32 (RGPIO_OUT) = 0x5A5A5A5A;
  struct wb_demo_reg volatile *wb_demo;
  wb_demo = (struct wb_demo_reg *)WB_DEMO_ADDR;
  wb_demo->A=0x1234;
  wb_demo->B=0x1235;
  wb_demo->op=0x0;
  while(wb_demo->status != 1);

  REG32 (RGPIO_OUT) = wb_demo->Y;

  wb_demo->op=0x2;
  while(wb_demo->status != 1);

  REG32 (RGPIO_OUT) = wb_demo->Y;

  REG32 (RGPIO_OUT) = 0xffffffff;
}
