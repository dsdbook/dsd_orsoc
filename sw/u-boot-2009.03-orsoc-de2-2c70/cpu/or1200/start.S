/*  */
/*  */

#include <config.h>

.section .stack, "aw", @nobits
.space  0x8000
_stack:

.section .vectors, "ax"
  
	.global	_start
_start:

  /* Set stack pointer */
  l.movhi r1,hi(_stack)
  l.ori   r1,r1,lo(_stack)
  
  /* Jump to main */
  l.movhi r2,hi(_board_init)
  l.ori   r2,r2,lo(_board_init)
  l.jr    r2
  l.nop


  
  