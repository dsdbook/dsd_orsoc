/*
 * (C) Copyright 2003
 * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
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

/*
 * 
 */

#ifndef __CONFIG_H
#define __CONFIG_H


/*-----------------------------------------------------------------------
 * misc configuration.
 */

#undef  CONFIG_BZIP2

#undef  CONFIG_WATCHDOG

#define CONFIG_CLOCKS_IN_MHZ 24
#define CONFIG_HZ  (CONFIG_CLOCKS_IN_MHZ * 1000000)

/*-----------------------------------------------------------------------
 * Command line configuration.
 */
#include <config_cmd_default.h>

#undef CONFIG_CMD_AUTOSCRIPT	/* Autoscript Support		*/
#undef CONFIG_CMD_BDI		/* bdinfo			*/
#undef CONFIG_CMD_BOOTD	/* bootd			*/
// #undef CONFIG_CMD_CONSOLE	/* coninfo			*/
#undef CONFIG_CMD_ECHO		/* echo arguments		*/
#undef CONFIG_CMD_SAVEENV	/* saveenv			*/
#undef CONFIG_CMD_FLASH	/* flinfo, erase, protect	*/
#undef CONFIG_CMD_FPGA		/* FPGA configuration Support	*/
#undef CONFIG_CMD_IMI		/* iminfo			*/
#undef CONFIG_CMD_IMLS		/* List all found images	*/
#undef CONFIG_CMD_ITEST	/* Integer (and string) test	*/
#undef CONFIG_CMD_LOADB	/* loadb			*/
#undef CONFIG_CMD_LOADS	/* loads			*/
// #undef CONFIG_CMD_MEMORY	/* md mm nm mw cp cmp crc base loop mtest */
#undef CONFIG_CMD_MISC		/* Misc functions like sleep etc*/
#undef CONFIG_CMD_NET		/* bootp, tftpboot, rarpboot	*/
#undef CONFIG_CMD_NFS		/* NFS support			*/
#undef CONFIG_CMD_RUN		/* run command in env variable	*/
#undef CONFIG_CMD_SETGETDCR	/* DCR support on 4xx		*/
#undef CONFIG_CMD_XIMG		/* Load part of Multi Image	*/


/*-----------------------------------------------------------------------
 * environment data configuration.
 */

#define	CONFIG_ENV_IS_NOWHERE	
#define CONFIG_ENV_SIZE 1024
#define CONFIG_SYS_MAX_FLASH_SECT 1
#define CONFIG_SYS_NO_FLASH

 
/*-----------------------------------------------------------------------
 * boot configuration.
 */
#undef	CONFIG_BOOTARGS

#define CONFIG_BOOTDELAY	10	/* autoboot after 10 seconds	*/
#define	CONFIG_TIMESTAMP		/* Print image info with timestamp */
#define CONFIG_SYS_LOAD_ADDR 0x81000000


/*-----------------------------------------------------------------------
 * Console configuration.
 */
#define CONFIG_SYS_PROMPT		"de1_or1k # "	/* Monitor Command Prompt    */

#define CONFIG_AUTO_COMPLETE
#define CONFIG_CMDLINE_EDITING

#define CONFIG_SYS_CBSIZE		256		/* Console I/O Buffer Size	*/
#define CONFIG_SYS_PBSIZE (CONFIG_SYS_CBSIZE+sizeof(CONFIG_SYS_PROMPT)+16) /* Print Buffer Size */
#define CONFIG_SYS_MAXARGS 16


/*-----------------------------------------------------------------------
 * Start addresses for the final memory configuration
 * (Set up by the startup code)
 * Please note that CONFIG_SYS_SDRAM_BASE _must_ start at 0
 */
#define CONFIG_SYS_SDRAM_BASE		0x30000000
#define CONFIG_SYS_SDRAM_SIZE		0x00020000
#define CONFIG_SYS_FLASH_BASE		0x20000000
#define CONFIG_SYS_FLASH_SIZE		0x00400000

#define CONFIG_SYS_MEMTEST_START	CONFIG_SYS_SDRAM_BASE
#define CONFIG_SYS_MEMTEST_END		(CONFIG_SYS_SDRAM_BASE + CONFIG_SYS_SDRAM_SIZE)

#define	CONFIG_SYS_MALLOC_BASE 0x30010000
#define CONFIG_SYS_MALLOC_LEN		32*1024


/*-----------------------------------------------------------------------
 * Definitions for initial stack pointer and data area
 */

#define CONFIG_SYS_INIT_RAM_ADDR	0x30000000	/* inside of SDRAM */
#define CONFIG_SYS_INIT_RAM_END	(CONFIG_SYS_INIT_RAM_ADDR + CONFIG_SYS_SDRAM_SIZE)		/* End of used area in RAM */
#define CONFIG_SYS_INIT_DATA_SIZE	128		/* size in bytes reserved for initial data */
#define CONFIG_SYS_GBL_DATA_OFFSET    (CONFIG_SYS_INIT_RAM_END - CONFIG_SYS_INIT_DATA_SIZE)
#define CONFIG_SYS_INIT_SP_OFFSET	CONFIG_SYS_GBL_DATA_OFFSET


/*-----------------------------------------------------------------------
 * serial port configuration.
 */

#define CONFIG_BAUDRATE 57600
#define CONFIG_SYS_BAUDRATE_TABLE { 9600 , 19200 , 38400 , 57600, 115200 }

#define CONFIG_CONS_INDEX	1
#define CONFIG_SYS_NS16550_SERIAL
#define CONFIG_SYS_NS16550
#define CONFIG_SYS_NS16550_REG_SIZE 1
#define CONFIG_SYS_NS16550_COM1	(0x50000000)
#define CONFIG_SYS_NS16550_CLK	CONFIG_HZ


/*-----------------------------------------------------------------------
 * qaz debug
 */


 
#endif	/* __CONFIG_H */


