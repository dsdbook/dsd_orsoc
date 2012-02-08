/*
 * orsoc
 * dxzhang@ustc.edu
 * sdust
 */

#include <common.h>
#include <command.h>
#include <malloc.h>


DECLARE_GLOBAL_DATA_PTR;

int board_early_init_f (void)
{
	return 0;
}


/*
 * Check Board Identity:
 */
int checkboard (void)
{
	puts ("BOARD : ORSoC Test Board\n");
	puts ("        dxzhang@ustc.edu\n");
	puts ("        sunfeelsky@gmai.com\n");
	return 0;
}


