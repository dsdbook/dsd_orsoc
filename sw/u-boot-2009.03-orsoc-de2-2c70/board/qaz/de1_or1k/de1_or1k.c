/*
 * (C) Copyright ????
 * XXX, XXX@XXX.org
 *
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
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
 * MA 02111-1307 USA
 */

#include <common.h>
#include <command.h>
#include <malloc.h>


DECLARE_GLOBAL_DATA_PTR;

// extern unsigned int _data_start, _data_lma_start, _data_end;
// extern unsigned int _bss_start, _bss_end;

int board_early_init_f (void)
{
//   memcpy( (void *)_data_start, (void *)_data_lma_start, (_data_end - _data_start) );
  
//   memset ( (void *)_bss_start, 0, ( _bss_end - _bss_start ) );

	return 0;
}


/*
 * Check Board Identity:
 */
int checkboard (void)
{
	char str[64];
	int i = getenv_r ("serial#", str, sizeof(str));

	puts ("Board: ");

	if (i == -1) {
		puts ("### No HW ID - assuming DE1_OR1k");
	} else {
		puts(str);
	}

	putc ('\n');

	return 0;
}



/*
 * post code for de1 board
 */
void set_de1_post( unsigned int post_code )
{
	gd->bd->post_code = post_code;
  
  *((volatile unsigned int *)(0x5ffffffc)) = gd->bd->post_code;
  *((volatile unsigned int *)(0x5ffffffc)) = 0xcea5e0ff;
}


void init_de1_post( void )
{
	gd->bd->post_code = 0;
  
  *((volatile unsigned int *)(0x5ffffffc)) = gd->bd->post_code;
  *((volatile unsigned int *)(0x5ffffffc)) = 0xcea5e0ff;
}


int de1_post_incr( void )
{
	gd->bd->post_code++;
  
  *((volatile unsigned int *)(0x5ffffffc)) = gd->bd->post_code;
  *((volatile unsigned int *)(0x5ffffffc)) = 0xcea5e0ff;
  
  return(0);
}



