/*
 * (C) Copyright 2004, Psyent Corporation <www.psyent.com>
 * Scott McNutt <smcnutt@psyent.com>
 *
 * See file CREDITS for list of people who contributed to this
 * project.
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 2 of
 * the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
 * MA 02111-1307 USA
 */

#include <common.h>

int do_reset (void)
{
//	void (*rst)(void) = (void(*)(void))0x00000000;
 	void (*rst)(void) = (void(*)(void))CONFIG_SYS_RESET_ADDR;
	disable_interrupts ();
	rst();
	return(0);
}

void icache_enable (void)
{
  unsigned long addr;
  unsigned long sr;

  /* Invalidate IC */
  for (addr = 0; addr < 8192; addr += 16)
    asm("l.mtspr r0,%0,%1": : "r" (addr), "i" (SPR_ICBIR));  
  
  /* Enable IC */
  asm("l.mfspr %0,r0,%1": "=r" (sr) : "i" (SPR_SR));
  sr |= SPR_SR_ICE;
  asm("l.mtspr r0,%0,%1": : "r" (sr), "i" (SPR_SR));  
  asm("l.nop");
  asm("l.nop");
  asm("l.nop");
  asm("l.nop");
  return ;
}

void icache_disable (void)
{
  unsigned long sr;

  /* Disable IC */
  asm("l.mfspr %0,r0,%1": "=r" (sr) : "i" (SPR_SR));
  sr &= ~SPR_SR_ICE;
  asm("l.mtspr r0,%0,%1": : "r" (sr), "i" (SPR_SR));  
  asm("l.nop");
  asm("l.nop");
  asm("l.nop");
  asm("l.nop");
  return ;
}

void dcache_enable (void)
{
  unsigned long addr;
  unsigned long sr;

  /* Invalidate DC */
  for (addr = 0; addr < 8192; addr += 16)
    asm("l.mtspr r0,%0,%1": : "r" (addr), "i" (SPR_DCBIR));  
  
  /* Enable DC */
  asm("l.mfspr %0,r0,%1": "=r" (sr) : "i" (SPR_SR));
  sr |= SPR_SR_DCE;
  asm("l.mtspr r0,%0,%1": : "r" (sr), "i" (SPR_SR));  
  asm("l.nop");
  asm("l.nop");
  asm("l.nop");
  asm("l.nop");
  return ;
}

void dcache_disable(void)
{
  unsigned long sr;

  /* Disable DC */
  asm("l.mfspr %0,r0,%1": "=r" (sr) : "i" (SPR_SR));
  sr &= ~SPR_SR_DCE;
  asm("l.mtspr r0,%0,%1": : "r" (sr), "i" (SPR_SR));  
  asm("l.nop");
  asm("l.nop");
  asm("l.nop");
  asm("l.nop");
  return ;
}

int	icache_status (void)
{
  unsigned long sr;
  asm("l.mfspr %0,r0,%1": "=r" (sr) : "i" (SPR_SR));
  return ((sr & SPR_SR_ICE) == SPR_SR_ICE);

}

int	dcache_status (void)
{
  unsigned long sr;
  asm("l.mfspr %0,r0,%1": "=r" (sr) : "i" (SPR_SR));
  return ((sr & SPR_SR_DCE) == SPR_SR_DCE);
}

#if 0
int mfspr_cmd (int argc, char *argv[])
{
  unsigned long val, addr;

  if (argc ==	1) {
    addr = strtoul (argv[0], 0, 0);
    /* Read SPR */
    asm("l.mfspr %0,%1,0": "=r" (val) : "r" (addr));
    printf ("\nSPR %04lx: %08lx", addr, val);
  } else return -1;
	return 0;
}

int mtspr_cmd (int argc, char *argv[])
{
  unsigned long val, addr;
  if (argc == 2) {
    addr = strtoul (argv[0], 0, 0);
    val = strtoul (argv[1], 0, 0);
    /* Write SPR */
    asm("l.mtspr %0,%1,0": : "r" (addr), "r" (val));
    asm("l.mfspr %0,%1,0": "=r" (val) : "r" (addr));
    printf ("\nSPR %04lx: %08lx", addr, val);
  } else return -1;
	return 0;
}
#endif
