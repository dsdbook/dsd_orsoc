#include "board.h"
#include "spr_defs.h"
#include "except.h"
#define CONTEXT_SAVE \
        l.addi  r1,r1,-(CONTEXT_SIZE); \
        l.sw    (GPR_R2)(r1),r2; \
        l.sw    (GPR_R3)(r1),r3; \
        l.sw    (GPR_R4)(r1),r4;\
        l.sw    (GPR_R5)(r1),r5;\
        l.sw    (GPR_R6)(r1),r6;\
        l.sw    (GPR_R7)(r1),r7;\
        l.sw    (GPR_R8)(r1),r8;\
        l.sw    (GPR_R9)(r1),r9;\
        l.sw    (GPR_R10)(r1),r10;\
        l.sw    (GPR_R11)(r1),r11;\
        l.sw    (GPR_R12)(r1),r12;\
        l.sw    (GPR_R13)(r1),r13;\
        l.sw    (GPR_R14)(r1),r14;\
        l.sw    (GPR_R15)(r1),r15;\
        l.sw    (GPR_R16)(r1),r16;\
        l.sw    (GPR_R17)(r1),r17;\
        l.sw    (GPR_R18)(r1),r18;\
        l.sw    (GPR_R19)(r1),r19;\
        l.sw    (GPR_R20)(r1),r20;\
        l.sw    (GPR_R21)(r1),r21;\
        l.sw    (GPR_R22)(r1),r22;\
        l.sw    (GPR_R23)(r1),r23;\
        l.sw    (GPR_R24)(r1),r24;\
        l.sw    (GPR_R25)(r1),r25;\
        l.sw    (GPR_R26)(r1),r26;\
        l.sw    (GPR_R27)(r1),r27;\
        l.sw    (GPR_R28)(r1),r28;\
        l.sw    (GPR_R29)(r1),r29;\
        l.sw    (GPR_R30)(r1),r30;\
        l.sw    (GPR_R31)(r1),r31;\
        l.mfspr r3,r0,SPR_EPCR_BASE;\
        l.sw    (GPR_EPCR)(r1),r3; \
        l.mfspr r3,r0,SPR_ESR_BASE;\
        l.sw    (GPR_ESR)(r1),r3;


#define CONTEXT_RESTORE  \
        l.jal   _cli; \
        l.nop; \
        l.lwz   r3,(GPR_EPCR)(r1); \
        l.mtspr r0,r3,SPR_EPCR_BASE; \
        l.lwz   r3,(GPR_ESR)(r1); \
        l.mtspr r0,r3,SPR_ESR_BASE; \
        l.lwz   r2,(GPR_R2)(r1);\
        l.lwz   r3,(GPR_R3)(r1);\
        l.lwz   r4,(GPR_R4)(r1);\
        l.lwz   r5,(GPR_R5)(r1);\
        l.lwz   r6,(GPR_R6)(r1);\
        l.lwz   r7,(GPR_R7)(r1);\
        l.lwz   r8,(GPR_R8)(r1);\
        l.lwz   r9,(GPR_R9)(r1);\
        l.lwz   r10,(GPR_R10)(r1);\
        l.lwz   r11,(GPR_R11)(r1);\
        l.lwz   r12,(GPR_R12)(r1);\
        l.lwz   r13,(GPR_R13)(r1);\
        l.lwz   r14,(GPR_R14)(r1);\
        l.lwz   r15,(GPR_R15)(r1);\
        l.lwz   r16,(GPR_R16)(r1);\
        l.lwz   r17,(GPR_R17)(r1);\
        l.lwz   r18,(GPR_R18)(r1);\
        l.lwz   r19,(GPR_R19)(r1);\
        l.lwz   r20,(GPR_R20)(r1);\
        l.lwz   r21,(GPR_R21)(r1);\
        l.lwz   r22,(GPR_R22)(r1);\
        l.lwz   r23,(GPR_R23)(r1);\
        l.lwz   r24,(GPR_R24)(r1);\
        l.lwz   r25,(GPR_R25)(r1);\
        l.lwz   r26,(GPR_R26)(r1);\
        l.lwz   r27,(GPR_R27)(r1);\
        l.lwz   r28,(GPR_R28)(r1);\
        l.lwz   r29,(GPR_R29)(r1);\
        l.lwz   r30,(GPR_R30)(r1);\
        l.lwz   r31,(GPR_R31)(r1);\
        l.addi  r1,r1,CONTEXT_SIZE ;


.section .stack, "aw", @nobits
.space  0x8000
_stack:



	.section .reset , "ax"
	.global	_reset	
	.org	0x100
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

/* dxzhang: _start'address  should be 0xF00000xx,after l.jr r3, flash_prefix will be 1'b0 */
	l.movhi	r3,hi(_start)
	l.ori 	r3,r3,lo(_start)
	l.jr	r3
	l.nop

        .org 0x200
_bus_error:
	l.addi	r5,r0,0
	l.movhi	r5,hi(GPIO_BASE)
	l.ori	r5,r5,lo(GPIO_BASE)
/* GPIO_OE  0xffffffff */
	l.addi	r6,r0,0xffffffff
	l.sw	0x8(r5),r6
/* GPIO_OUT */
	l.addi	r6,r0,0x200	
	l.sw	0x4(r5),r6
	l.j	0
	l.nop	

        .org 0x300
_data_page_fault:
	l.addi	r5,r0,0
	l.movhi	r5,hi(GPIO_BASE)
	l.ori	r5,r5,lo(GPIO_BASE)
/* GPIO_OE  0xffffffff */
	l.addi	r6,r0,0xffffffff
	l.sw	0x8(r5),r6
/* GPIO_OUT */
	l.addi	r6,r0,0x300	
	l.sw	0x4(r5),r6
        l.j 	0
        l.nop

        .org 0x400
_instruction_page_fault:
	l.addi	r5,r0,0
	l.movhi	r5,hi(GPIO_BASE)
	l.ori	r5,r5,lo(GPIO_BASE)
/* GPIO_OE  0xffffffff */
	l.addi	r6,r0,0xffffffff
	l.sw	0x8(r5),r6
/* GPIO_OUT */
	l.addi	r6,r0,0x400	
	l.sw	0x4(r5),r6
        l.j	0
        l.nop



        .org 0x500
_tick_timer_interrupt:
        CONTEXT_SAVE
        l.movhi r2,hi(_tick_timer_interrupt_text)
        l.ori   r2,r2,lo(_tick_timer_interrupt_text)
        l.jr  r2
        l.nop

        .org 0x600
_alignment:
	l.addi	r5,r0,0
	l.movhi	r5,hi(GPIO_BASE)
	l.ori	r5,r5,lo(GPIO_BASE)
/* GPIO_OE  0xffffffff */
	l.addi	r6,r0,0xffffffff
	l.sw	0x8(r5),r6
/* GPIO_OUT */
	l.addi	r6,r0,0x600	
/*	l.mfspr	r6,r0,SPR_EPCR_BASE */
	l.sw	0x4(r5),r6
        l.nop
        l.j 	0
        l.nop

        .org 0x700
_illegal_instruction:
	l.addi	r5,r0,0
	l.movhi	r5,hi(GPIO_BASE)
	l.ori	r5,r5,lo(GPIO_BASE)
/* GPIO_OE  0xffffffff */
	l.addi	r6,r0,0xffffffff
	l.sw	0x8(r5),r6
/* GPIO_OUT */
	l.addi	r6,r0,0x700	
	l.sw	0x4(r5),r6
        l.j 	0
        l.nop

        .org 0x800
_external_interrupt:
	l.addi	r5,r0,0
	l.movhi	r5,hi(GPIO_BASE)
	l.ori	r5,r5,lo(GPIO_BASE)
/* GPIO_OE  0xffffffff */
	l.addi	r6,r0,0xffffffff
	l.sw	0x8(r5),r6
/* GPIO_OUT */
	l.addi	r6,r0,0x800	
	l.sw	0x4(r5),r6
        l.j	0
        l.nop

        .org 0x900
_D_TLB_miss:
	l.addi	r5,r0,0
	l.movhi	r5,hi(GPIO_BASE)
	l.ori	r5,r5,lo(GPIO_BASE)
/* GPIO_OE  0xffffffff */
	l.addi	r6,r0,0xffffffff
	l.sw	0x8(r5),r6
/* GPIO_OUT */
	l.addi	r6,r0,0x900	
	l.sw	0x4(r5),r6
        l.j	0
        l.nop

        .org 0xA00
_I_TLB_miss:
	l.addi	r5,r0,0
	l.movhi	r5,hi(GPIO_BASE)
	l.ori	r5,r5,lo(GPIO_BASE)
/* GPIO_OE  0xffffffff */
	l.addi	r6,r0,0xffffffff
	l.sw	0x8(r5),r6
/* GPIO_OUT */
	l.addi	r6,r0,0xA00	
	l.sw	0x4(r5),r6
        l.j 	0
        l.nop

        .org 0xB00
_range:
	l.addi	r5,r0,0
	l.movhi	r5,hi(GPIO_BASE)
	l.ori	r5,r5,lo(GPIO_BASE)
/* GPIO_OE  0xffffffff */
	l.addi	r6,r0,0xffffffff
	l.sw	0x8(r5),r6
/* GPIO_OUT */
	l.addi	r6,r0,0xB00	
	l.sw	0x4(r5),r6
        l.j 	0
        l.nop

        .org 0xC00
_system_call:
	l.addi	r5,r0,0
	l.movhi	r5,hi(GPIO_BASE)
	l.ori	r5,r5,lo(GPIO_BASE)
/* GPIO_OE  0xffffffff */
	l.addi	r6,r0,0xffffffff
	l.sw	0x8(r5),r6
/* GPIO_OUT */
	l.addi	r6,r0,0xC00	
	l.sw	0x4(r5),r6
        l.j	0
        l.nop

        .org 0xD00
_break:
	l.addi	r5,r0,0
	l.movhi	r5,hi(GPIO_BASE)
	l.ori	r5,r5,lo(GPIO_BASE)
/* GPIO_OE  0xffffffff */
	l.addi	r6,r0,0xffffffff
	l.sw	0x8(r5),r6
/* GPIO_OUT */
	l.addi	r6,r0,0xD00	
	l.sw	0x4(r5),r6
        l.j	0
        l.nop

        .org 0xE00
_trap:
	l.addi	r5,r0,0
	l.movhi	r5,hi(GPIO_BASE)
	l.ori	r5,r5,lo(GPIO_BASE)
/* GPIO_OE  0xffffffff */
	l.addi	r6,r0,0xffffffff
	l.sw	0x8(r5),r6
/* GPIO_OUT */
	l.addi	r6,r0,0xE00	
	l.sw	0x4(r5),r6
        l.j	0
        l.nop




	.section .text
_start:

/* show current status use gpio, bit 2-- finished jump to flash */
	l.addi	r5,r0,0
	l.movhi	r5,hi(GPIO_BASE)
	l.ori	r5,r5,lo(GPIO_BASE)
/* GPIO_OE  0xffffffff */
	l.addi	r6,r0,0xffffffff
	l.sw	0x8(r5),r6
/* GPIO_OUT */
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

/* copy from flash to sdram */
copy_from_flash_to_sdram:
	l.addi	r3,r0,0
	l.addi	r4,r0,0
	l.addi	r5,r0,0
        l.movhi r3,hi(_u_boot_start)
        l.ori   r3,r3,lo(_u_boot_start)

        l.movhi r4,hi(__text_start)
        l.ori   r4,r4,lo(__text_start)
        l.movhi r5,hi(__data_end)
        l.ori   r5,r5,lo(__data_end)
        l.sub   r5,r5,r4
        l.sfeqi r5,0
        l.bf    2f
        l.nop

1:      l.lwz   r6,0(r3) 
        l.sw    0(r4),r6 

        l.addi  r3,r3,4
        l.addi  r4,r4,4
        l.addi  r5,r5,-4
	l.sfgtsi r5,0
        l.bf    1b
        l.nop
2:

/* clear bss */
        l.movhi r4,hi(__bss_start)
        l.ori   r4,r4,lo(__bss_start)
        l.movhi r5,hi(__bss_end)
        l.ori   r5,r5,lo(__bss_end)
        l.sub   r5,r5,r4
        l.sfeqi r5,0
        l.bf    2f
        l.nop
	

1:      l.sw    0(r4),r0

        l.addi  r4,r4,4
        l.addi  r5,r5,-4
	l.sfgtsi r5,0
        l.bf    1b
        l.nop
2:


/* show current status use gpio, bit 3 -- finished copy_from_flash_to_ssram */
/*
	l.addi	r5,r0,0
	l.movhi	r5,hi(GPIO_BASE)
	l.ori	r5,r5,lo(GPIO_BASE)
	l.addi	r6,r0,0x8
	l.sw	0x4(r5),r6
*/

/* show current status use gpio, bit 4-- finished jump_to_sdram */
jump_to_sdram:
	l.addi	r5,r0,0
	l.movhi	r5,hi(GPIO_BASE)
	l.ori	r5,r5,lo(GPIO_BASE)
	l.addi	r6,r0,0x10
	l.sw	0x4(r5),r6

/* jump to _board_init */
jump_to__board_init:
  /* Set stack pointer */
  l.movhi r1,hi(_stack)
  l.ori   r1,r1,lo(_stack)

  /* Jump to main */
  l.movhi r2,hi(board_init)
  l.ori   r2,r2,lo(board_init)
  l.jr    r2
  l.nop


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



	.section  .tick_timer_text 

_tick_timer_interrupt_text:
        l.movhi r2,hi(tick_isr)
        l.ori   r2,r2,lo(tick_isr)
        l.jalr  r2
        l.nop

        CONTEXT_RESTORE

        l.rfe
        l.nop



/*
 *  * Enable interrupts
 *   *      sti()
 *    */
        .global sti
        .global _sti
_sti:
sti:
        l.mfspr r3,r0,SPR_SR
        l.ori r3,r3,(SPR_SR_IEE | SPR_SR_TEE)
        l.mtspr r0,r3,SPR_SR
        l.jr    r9
        l.nop

/*
 *  * Disable interrupts
 *   *      cli()
 *    */
        .global cli
        .global _cli
_cli:
cli:
        l.addi r4,r0,-1
        l.xori r4,r4,(SPR_SR_IEE | SPR_SR_TEE)
        l.mfspr r3,r0,SPR_SR
        l.and r3,r3,r4
        l.mtspr r0,r3,SPR_SR
        l.jr    r9
        l.nop

