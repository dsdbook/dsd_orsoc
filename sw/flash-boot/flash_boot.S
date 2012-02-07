#include "board.h"
#include "spr_defs.h"

	    .section .reset , "ax"
        .org 0x100
_reset:
	    l.nop
	    l.addi  r2,r0,0x0
        l.addi  r3,r0,0x0
        l.addi  r4,r0,0x0
        l.addi  r5,r0,0x0
        l.addi  r6,r0,0x0
        l.addi  r7,r0,0x0
        l.addi  r8,r0,0x0
        l.addi  r9,r0,0x0
        l.addi  r10,r0,0x0
        l.addi  r11,r0,0x0
        l.addi  r12,r0,0x0
        l.addi  r13,r0,0x0
        l.addi  r14,r0,0x0
        l.addi  r15,r0,0x0
        l.addi  r16,r0,0x0
        l.addi  r17,r0,0x0
        l.addi  r18,r0,0x0
        l.addi  r19,r0,0x0
        l.addi  r20,r0,0x0
        l.addi  r21,r0,0x0
        l.addi  r22,r0,0x0
        l.addi  r23,r0,0x0
 	    l.addi  r24,r0,0x0
        l.addi  r25,r0,0x0
        l.addi  r26,r0,0x0
        l.addi  r27,r0,0x0
        l.addi  r28,r0,0x0
        l.addi  r29,r0,0x0
        l.addi  r30,r0,0x0
        l.addi  r31,r0,0x0

/* dxzhang: _start'address  should be 0x040000xx,after l.jr r3, flash_prefix will be 1'b0 */
	l.movhi	r3,hi(_start)
	l.ori 	r3,r3,lo(_start)
	l.jr	r3
	l.nop

	.section .text
_start:
/* show current status use gpio, bit 2-- finished jump to flash */
	l.addi	r5,r0,0
	l.movhi	r5,hi(GPIO_BASE)
	l.ori	r5,r5,lo(GPIO_BASE)
	l.addi	r6,r0,0x4	
	l.sw	0x4(r5),r6

#if  IC_ENABLE
	l.jal	_ic_enable
	l.nop
#endif
#if  DC_ENABLE
	l.jal	_dc_enable
	l.nop
#endif

/* copy from flash to ram */
copy_from_flash_to_ram:
        l.movhi r3,hi(_user_prog)
        l.ori   r3,r3,lo(_user_prog)

        l.movhi r4,hi(_user_start)
        l.ori   r4,r4,lo(_user_start)
        l.movhi r5,hi(_user_end)
        l.ori   r5,r5,lo(_user_end)
        l.sub   r5,r5,r4
        l.sfeqi r5,0
        l.bf    2f
        l.nop
	
	    l.addi	r6,r0,0

1:      l.lwz   r6,0(r3) 
        l.sw    0(r4),r6 

        l.addi  r3,r3,4
        l.addi  r4,r4,4
        l.addi  r5,r5,-4
	    l.sfgtsi r5,0
        l.bf    1b
        l.nop
2:

/* show current status use gpio, bit 3-- finished copy from flash to ram */
	l.addi	r5,r0,0
	l.movhi	r5,hi(GPIO_BASE)
	l.ori	r5,r5,lo(GPIO_BASE)
	l.addi	r6,r0,0x8	
	l.sw	0x4(r5),r6

/* jump to ram_start_address,fixed 0x100, reset_vector address */

	    l.addi  r2,r0,0x0
        l.addi  r3,r0,0x0
        l.addi  r4,r0,0x0
        l.addi  r5,r0,0x0
        l.addi  r6,r0,0x0
        l.addi  r7,r0,0x0
        l.addi  r8,r0,0x0
        l.addi  r9,r0,0x0
        l.addi  r10,r0,0x0
        l.addi  r11,r0,0x0
        l.addi  r12,r0,0x0
        l.addi  r13,r0,0x0
        l.addi  r14,r0,0x0
        l.addi  r15,r0,0x0
        l.addi  r16,r0,0x0
        l.addi  r17,r0,0x0
        l.addi  r18,r0,0x0
        l.addi  r19,r0,0x0
        l.addi  r20,r0,0x0
        l.addi  r21,r0,0x0
        l.addi  r22,r0,0x0
        l.addi  r23,r0,0x0
 	    l.addi  r24,r0,0x0
        l.addi  r25,r0,0x0
        l.addi  r26,r0,0x0
        l.addi  r27,r0,0x0
        l.addi  r28,r0,0x0
        l.addi  r29,r0,0x0
        l.addi  r30,r0,0x0
        l.addi  r31,r0,0x0

	    l.addi	r2,r0,0x100
	    l.jr	r2
	    l.addi	r2,r0,0x0

/* jump to _reset ,never here!!! */
jump_to_reset:
	    l.and r2,r2,r0
        l.movhi r2,hi(_reset)
        l.ori   r2,r2,lo(_reset)
        l.jr    r2
        l.addi  r2,r0,0


/*
 * Instruction cache enable
 *      ic_enable()
 */
	.global _ic_enable
_ic_enable:
  /* Disable IC */
  l.mfspr r13,r0,SPR_SR
  l.addi  r11,r0,-1
  l.xori  r11,r11,SPR_SR_ICE
  l.and   r11,r13,r11
  l.mtspr r0,r11,SPR_SR

  /* Invalidate IC */
  l.addi  r13,r0,0
  l.addi  r11,r0,IC_SIZE
1:
  l.mtspr r0,r13,SPR_ICBIR
  l.sfne  r13,r11
  l.bf    1b
  l.addi  r13,r13,IC_LINE

  /* Enable IC */
  l.mfspr r13,r0,SPR_SR
  l.ori   r13,r13,SPR_SR_ICE
  l.mtspr r0,r13,SPR_SR
  l.nop
  l.nop
  l.nop
  l.nop
  l.nop

  l.jr    r9
  l.nop


/*
 * Data cache enable
 *      dc_enable()
 */
	.global _dc_enable
_dc_enable:
  /* Disable DC */
  l.mfspr r13,r0,SPR_SR
  l.addi  r11,r0,-1
  l.xori  r11,r11,SPR_SR_DCE
  l.and   r11,r13,r11
  l.mtspr r0,r11,SPR_SR

  /* Flush DC */
  l.addi  r13,r0,0
  l.addi  r11,r0,DC_SIZE
1:
  l.mtspr r0,r13,SPR_DCBIR
  l.sfne  r13,r11
  l.bf    1b
  l.addi  r13,r13,DC_LINE

  /* Enable DC */
  l.mfspr r13,r0,SPR_SR
  l.ori   r13,r13,SPR_SR_DCE
  l.mtspr r0,r13,SPR_SR

  l.jr    r9
  l.nop
 

/* user program bin file */

	.section  .user_prog_file,"a"
	.incbin  "userprog.bin"
