/*
 * (C) Copyright 2005, Psyent Corporation <www.psyent.com>
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
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
 * MA 02111-1307 USA
 */

/* modify by dxzhang <dxzhang@ustc.edu>, for Terasic DE2 EP2C70 Board */

#ifndef __CONFIG_H
#define __CONFIG_H

//add by dxzhang
#include "../../board/sdust/de2_ep2c70_or1k/board.h"
//end by dxzhang

#define CONFIG_ARP_TIMEOUT 100UL

#define CONFIG_BOOTDELAY 3

/*------------------------------------------------------------------------
 * BOARD/CPU
 *----------------------------------------------------------------------*/
#define	CONFIG_OR1K
#define	CONFIG_OR1K_DE2_70_MEM_SIZE
#define	CONFIG_FIT
#define CONFIG_BOOTM_LINUX 1
#define CONFIG_AUTO_COMPLETE
#define CONFIG_DE2_EP2C70_OR1K	1	/* terasic DE2 ep2c70 board*/
#define CONFIG_SYS_CLK_FREQ	IN_CLK	/*  core clk	*/

#define CONFIG_SYS_RESET_ADDR	(FLASH_BASE_ADDR + 0x100)/* Hard-reset address	*/
#define CONFIG_BOARD_EARLY_INIT_F 1	/* enable early board-spec. init*/

/*------------------------------------------------------------------------
 * CACHE -- the following will support II/s and II/f. The II/s does not
 * have dcache, so the cache instructions will behave as NOPs.
 *----------------------------------------------------------------------*/
#define CONFIG_ICACHE_SIZE		IC_SIZE		/* 4 KByte total	*/
#define CONFIG_ICACHELINE_SIZE	IC_LINE		/* 32 bytes/line	*/
#define CONFIG_DCACHE_SIZE		DC_SIZE		/* 2 KByte (II/f)	*/
#define CONFIG_DCACHELINE_SIZE	DC_LINE		/* 4 bytes/line (II/f)	*/

/*------------------------------------------------------------------------
 * MEMORY BASE ADDRESSES
 *----------------------------------------------------------------------*/
#define CONFIG_SYS_FLASH_BASE		FLASH_BASE_ADDR	/* FLASH base addr	*/
#define CONFIG_SYS_FLASH_SIZE		FLASH_SIZE /* 8 MByte		*/
#define CONFIG_FLASH_SIZE		FLASH_SIZE /* 8 MByte		*/
#define CONFIG_SDRAM_BASE		SDRAM_BASE_ADDR /* SDRAM base addr	*/
#define CONFIG_SDRAM_SIZE		SDRAM_BASE_SIZE /* 32 MByte	*/

#define CONFIG_SRAM_BASE		SSRAM_BASE_ADDR	/* SRAM base addr	*/
#define CONFIG_SRAM_SIZE		SSRAM_BASE_SIZE	/**/
#define CONFIG_SYS_SDRAM_BASE		CONFIG_SDRAM_BASE
#define	CONFIG_SYS_SDRAM_SIZE		CONFIG_SDRAM_SIZE

/*------------------------------------------------------------------------
 * FLASH (S29GL064A90TFIR4) 16bit mode
 *----------------------------------------------------------------------*/

/* dxzhang : need to read flash  datasheet */
#define CONFIG_SYS_MAX_FLASH_SECT	135		/* Max # sects per bank */
#define CONFIG_SYS_MAX_FLASH_BANKS	1		/* Max # of flash banks */
#define CONFIG_FLASH_ERASE_TOUT	1024*16		/* Erase timeout (msec) */
#define CONFIG_FLASH_WRITE_TOUT	128*32		/* Write timeout (msec) */
//according to the output of Altera nios2-flash-programmer tool,
//dxzhang: use 8bit mode
#define CONFIG_FLASH_WORD_SIZE	unsigned short	/* flash word size	*/

/*------------------------------------------------------------------------
 * ENVIRONMENT -- Put environment in sector CONFIG_MONITOR_LEN above
 * CONFIG_RESET_ADDR, since we assume the monitor is stored at the
 * reset address, no? This will keep the environment in user region
 * of flash. NOTE: the monitor length must be multiple of sector size
 * (which is common practice).
 *----------------------------------------------------------------------*/
//#define CONFIG_SYS_NO_FLASH	1
#define CONFIG_ENV_IS_IN_FLASH	1		/* Environment in flash */
#define CONFIG_ENV_SIZE		(64 * 1024)	/* 64 KByte (1 sector)	*/

#define CONFIG_ENV_OVERWRITE			/* Serial change Ok	*/
/* #define CONFIG_ENV_ADDR	(CONFIG_RESET_ADDR + CONFIG_MONITOR_LEN) */
/* add by dxzhang */
#define U_BOOT_BIN_MAX_SIZE	(64 * 1024 * 4)/* 64*4 K Bytes */
#define CONFIG_ENV_ADDR		(CONFIG_SYS_FLASH_BASE + U_BOOT_BIN_MAX_SIZE)


/*------------------------------------------------------------------------
 * CONSOLE
 *----------------------------------------------------------------------*/
#define CONFIG_BAUDRATE		115200		/* Initial baudrate	*/
#define CONFIG_SYS_BAUDRATE_TABLE	{115200}	/* It's fixed ;-)	*/
#define CONFIG_CONSOLE_INFO_QUIET	0	/* Suppress console info*/

/*------------------------------------------------------------------------
 * DEBUG
 *----------------------------------------------------------------------*/
#define DEBUG
#undef CONFIG_ROM_STUBS				/* Stubs not in ROM	*/

/*------------------------------------------------------------------------
 * MEMORY ORGANIZATION
 *	-Monitor at top.
 *	-The heap is placed below the monitor.
 *	-Global data is placed below the heap.
 *	-The stack is placed below global data (&grows down).
 *----------------------------------------------------------------------*/
#define CONFIG_SYS_MONITOR_LEN		(256 * 1024)	/* Reserve 128k		*/
#define CONFIG_SYS_GBL_DATA_SIZE	128
#define CONFIG_SYS_MALLOC_LEN		(CONFIG_ENV_SIZE + 128*1024)

#define CONFIG_SYS_MONITOR_BASE		TEXT_BASE
#define CONFIG_SYS_MALLOC_BASE		(CONFIG_SYS_MONITOR_BASE - CONFIG_SYS_MALLOC_LEN)
#define CONFIG_SYS_GBL_DATA_OFFSET	(CONFIG_SYS_MALLOC_BASE - CONFIG_SYS_GBL_DATA_SIZE)
#define CONFIG_SYS_INIT_SP		CONFIG_SYS_GBL_DATA_OFFSET

/*------------------------------------------------------------------------
 * TIMEBASE --
 *
 * The high res timer defaults to 1 msec. Since it includes the period
 * registers, we can slow it down to 10 msec using TMRCNT. If the default
 * period is acceptable, TMRCNT can be left undefined.
 *----------------------------------------------------------------------*/
#define CONFIG_SYS_HZ		20  /* 10msec/HZ */

/*------------------------------------------------------------------------
 * ETHERNET -- The header file for the SMC91111 driver hurts my eyes ...
 * and really doesn't need any additional clutter. So I choose the lazy
 * way out to avoid changes there -- define the base address to ensure
 * cache bypass so there's no need to monkey with inx/outx macros.
 *----------------------------------------------------------------------*/

//#define CONFIG_SMC91111_BASE	0x82110300	/* Base addr (bypass)	*/
//#define CONFIG_DRIVER_SMC91111		/* Using SMC91c111	*/
//#undef  CONFIG_SMC91111_EXT_PHY		/* Internal PHY		*/
//#define CONFIG_SMC_USE_32_BIT			/* 32-bit interface	*/

#define CONFIG_DRIVER_DM9000		1
#define CONFIG_DM9000_BASE		DM9000_BASE
#define DM9000_IO			CONFIG_DM9000_BASE
#define DM9000_DATA			(CONFIG_DM9000_BASE+4)
/* #define CONFIG_DM9000_USE_8BIT */
#define CONFIG_DM9000_USE_16BIT 
/* #define CONFIG_DM9000_USE_32BIT */
 
#define CONFIG_ETHADDR		08:00:3e:26:0a:5b
#define CONFIG_NETMASK		255.255.255.0
//home
#define CONFIG_IPADDR		192.168.2.190
#define CONFIG_SERVERIP		192.168.2.100
#define CONFIG_GATEWAYIP	192.168.2.100

// dxzhang: for net debug; should use Makefile to define -DET_DEBUG
//#define ET_DEBUG
//#define	CONFIG_DM9000_DEBUG

/*
 * BOOTP options
 */
#define CONFIG_BOOTP_BOOTFILESIZE
#define CONFIG_BOOTP_BOOTPATH
#define CONFIG_BOOTP_GATEWAY
#define CONFIG_BOOTP_HOSTNAME


/*
 * Command line configuration.
 */
//add by dxzhang
//#define CONFIG_BZIP2
//end by dxzhang

#include <config_cmd_default.h>

#define CONFIG_CMD_DHCP
#define CONFIG_CMD_IRQ
#define CONFIG_CMD_PING
#define CONFIG_CMD_PORTIO
#define	CONFIG_SYS_NS16550
#define	CONFIG_SYS_NS16550_SERIAL
#define CONFIG_SYS_NS16550_REG_SIZE    1
#define CONFIG_CONS_INDEX       1
#define	CONFIG_SYS_NS16550_CLK	IN_CLK
#define CONFIG_SYS_NS16550_COM1 	UART_BASE 


#define CONFIG_CMD_RUN
#define CONFIG_CMD_ENV

#define CONFIG_CMD_CACHE

//#undef CONFIG_CMD_FLASH	/* flinfo, erase, protect	*/
//#undef CONFIG_CMD_SAVEENV	/* saveenv			*/
//#undef CONFIG_CMD_AUTOSCRIPT
//#undef CONFIG_CMD_BOOTD
//#undef CONFIG_CMD_CONSOLE
//#undef CONFIG_CMD_FPGA
#undef CONFIG_CMD_IMLS
#undef CONFIG_CMD_ITEST
//#undef CONFIG_CMD_NFS
#undef CONFIG_CMD_SETGETDCR
#undef CONFIG_CMD_XIMG


/*------------------------------------------------------------------------
 * MISC
 *----------------------------------------------------------------------*/
#define CONFIG_SYS_LONGHELP				/* Provide extended help*/
#define CONFIG_SYS_PROMPT		"==> "		/* Command prompt	*/
#define CONFIG_SYS_CBSIZE		256		/* Console I/O buf size */
#define CONFIG_SYS_MAXARGS		16		/* Max command args	*/
#define CONFIG_BARGSIZE		CONFIG_SYS_CBSIZE	/* Boot arg buf size	*/
#define CONFIG_SYS_PBSIZE (CONFIG_SYS_CBSIZE+sizeof(CONFIG_SYS_PROMPT)+16) /* Print buf size */
#define CONFIG_SYS_LOAD_ADDR		CONFIG_SDRAM_BASE	/* Default load address */
#define CONFIG_SYS_MEMTEST_START	(CONFIG_SDRAM_BASE + 0x2000 )	/* Start addr for test	*/
#define CONFIG_SYS_MEMTEST_END		(CONFIG_SYS_INIT_SP - 0x20000)

#define CONFIG_SYS_HUSH_PARSER
#define CONFIG_SYS_PROMPT_HUSH_PS2	"> "

#endif	/* __CONFIG_H */
