#include <common.h>
#include "board.h"
#include "spr_defs.h"

#define   TTMR_MMASK            SPR_TTMR_M
#define   TTMR_M(x)             ((x)<<30)
#define   TTMR_IE               SPR_TTMR_IE
#define   TTMR_IP               SPR_TTMR_IP
#define   TTMR_TPMASK           0x0fffffff


unsigned long loops_per_usec;
unsigned long volatile timestamp = 0 ;

__inline__ void __delay(int loops)
{
	__asm__ __volatile__ (
			      "l.srli %0,%0,1;"
			      "1: l.sfeqi %0,0;"
			      "l.bnf 1b;"
			      "l.addi %0,%0,-1;"
			      : "=r" (loops): "0" (loops));
}


/* Use only for very small delays ( < 1 msec).  */


__inline__ void udelay(unsigned long usecs)
{
	__delay(usecs * loops_per_usec);
}

__inline__ void usleep(unsigned long usecs)
{
	__delay(usecs * loops_per_usec);
}

//calc loops_per_sec
void delay_init()
{
	unsigned int  ttmr;
	int ttcr;

	mtspr(SPR_TTMR,0);	// Clear the Tick Timer Mode register
	mtspr(SPR_TTCR, 0);
	
	ttmr = 0;
	ttmr = TTMR_M(3) | CONFIG_SYS_CLK_FREQ;   //for 25MHz clock
	mtspr(SPR_TTMR, ttmr);
	
	unsigned volatile int ttcr1,ttcr2;
	ttcr1 = mfspr(SPR_TTCR);
	ttcr2 = mfspr(SPR_TTCR);
	ttcr=ttcr2-ttcr1;

	ttcr1 = mfspr(SPR_TTCR);
	__delay(1000);
	ttcr2 = mfspr(SPR_TTCR);
	
	loops_per_usec = (CONFIG_SYS_CLK_FREQ/(ttcr2-ttcr1-ttcr))/1000;
	
	mtspr(SPR_TTMR,0);	// Clear the Tick Timer Mode register
	mtspr(SPR_TTCR, 0);
}


void tick_isr()
{
	mtspr(SPR_TTMR,mfspr(SPR_TTMR)&(~SPR_TTMR_IP));
	timestamp+=1;
}

void	timer_init()
{
 /* install tick timer ISR */
//	memcpy((void *)0x500,(void*)(CONFIG_SYS_FLASH_BASE+0x500),0x100);	
/* copy vectors */
	memcpy((void *)0x00,(void*)(CONFIG_SYS_FLASH_BASE+0x00),0x1000);	
 /* To init the tick timer */
        long ttmr;
        mtspr(SPR_TTMR,0);      /* Clear the Tick Timer Mode register */
        mtspr(SPR_TTCR,0);      /* Clear the Tick Timer count register */
        ttmr = TTMR_M(1) | SPR_TTMR_IE | (CONFIG_SYS_CLK_FREQ/CONFIG_SYS_HZ);
        mtspr(SPR_TTMR,ttmr);           /* Set the Tick Timer mode (1) and allow interupt */

}

void set_timer (ulong base_ticks)
{
	timestamp=base_ticks;
}

volatile ulong get_timer (ulong base_ticks)
{
	return (timestamp - base_ticks);
}
