#ifndef _BOARD_H_
#define _BOARD_H_

#define MC_ENABLED		0
#define IC_ENABLE		0
#define IC_SIZE			8192
#define DC_ENABLE		0
#define DC_SIZE			8192
#define DC_LINE			16
#define IC_LINE			16
  
//for DE2_70 board
#define FLASH_BASE_ADDR		0xF0000000
#define FLASH_SIZE		0x00800000
#define SDRAM_BASE_ADDR		0x00000000
#define SSRAM_BASE_ADDR        	0x10000000
#define SDRAM_BASE_SIZE		0x02000000
#define SSRAM_BASE_SIZE        	0x00200000
  
#define IN_CLK			25000000
#define TICKS_PER_SEC		20
#define STACK_SIZE		0x100000
  
#define UART_BAUD_RATE		115200
#define UART_DEVISOR		(IN_CLK/(16*UART_BAUD_RATE))  
#define UART_BASE		0x90000000
#define UART_IRQ		2

#define GPIO_BASE		0xE0000000
#define RGPIO_IN		(GPIO_BASE + 0x0)
#define RGPIO_OUT		(GPIO_BASE + 0x4)
#define RGPIO_OE		(GPIO_BASE + 0x8)
#define RGPIO_INTE		(GPIO_BASE + 0xc)
#define RGPIO_PTRIG		(GPIO_BASE + 0x10)
#define RGPIO_AUX		(GPIO_BASE + 0x14)
#define RGPIO_CTRL		(GPIO_BASE + 0x18)
#define RGPIO_INTS		(GPIO_BASE + 0x1c)
#define RGPIO_ECLK		(GPIO_BASE + 0x20)
#define RGPIO_NEC		(GPIO_BASE + 0x24)
#define GPIO_IRQ		6

  
#define ETH_BASE		0xA0000000
#define ETH_IRQ			4
#define DM9000_BASE		ETH_BASE
#define DM9000A_BASE		ETH_BASE
#define DM9000_IRQ		ETH_IRQ
#define DM9000A_IRQ		ETH_IRQ

#define TIMER_BASE		0x80000000
#define TIMER_CTL_0		TIMER_BASE + 0x00
#define TIMER_CTL_1		TIMER_BASE + 0x10
#define TIMER_CMP_0		TIMER_BASE + 0x04
#define TIMER_CMP_1		TIMER_BASE + 0x14
#define TIMER_CNT_0		TIMER_BASE + 0x08
#define TIMER_CNT_1		TIMER_BASE + 0x18


/* SPI */
#define SPI_BASE                0xB0000000
#define SPI_RX0                 ( SPI_BASE + 0x00)
#define SPI_RX1                 ( SPI_BASE + 0x04)
#define SPI_RX2                 ( SPI_BASE + 0x08)
#define SPI_RX3                 ( SPI_BASE + 0x0c)
#define SPI_TX0                 ( SPI_BASE + 0x00)
#define SPI_TX1                 ( SPI_BASE + 0x04)
#define SPI_TX2                 ( SPI_BASE + 0x08)
#define SPI_TX3                 ( SPI_BASE + 0x0c)
#define SPI_CTRL                ( SPI_BASE + 0x10)
#define SPI_DIVIDER             ( SPI_BASE + 0x14)
#define SPI_SS                  ( SPI_BASE + 0x18)

//spi ctrl register bit define
//CHAR_LEN [6:0]
#define SPI_CTRL_CHAR_LEN_MASK  0x127
//GO_BSY [8]
#define SPI_CTRL_GO_BSY         (0x1 << 8)
#define SPI_CTRL_RX_NEG         (0x1 << 9)
#define SPI_CTRL_TX_NEG         (0x1 << 10)
#define SPI_CTRL_LSB            (0x1 << 11)
#define SPI_CTRL_IE             (0x1 << 12)
#define SPI_CTRL_ASS            (0x1 << 13)
#define SPI_CTRL_CPOL           (0x1 << 14)
  
/* Register access macros */ 
#define REG8(add)		*((volatile unsigned char *)(add))
#define REG16(add)		*((volatile unsigned short *)(add))
#define REG32(add)		*((volatile unsigned long *)(add))
 /* 
#define mtspr(reg, val) \
        __asm __volatile("l.mtspr %0,%1,0" : : "r"(reg), "r"(val))
#define mfspr(reg) \
        ( { \
                unsigned int val; \
                __asm __volatile("l.mfspr %0,%1,0" : "=r"(val) : "r"(reg)); \
                val; \
        } )
*/

/* Define this if you want to use I and/or D MMU */ 
#define IMMU                   	0
#define DMMU                   	0
  
#define DMMU_SET_NB            	64
#define DMMU_PAGE_ADD_BITS     	13      /* 13 for 8k, 12 for 4k page size */
#define DMMU_PAGE_ADD_MASK     	0x3fff  /* 0x3fff for 8k, 0x1fff for 4k page size */
#define DMMU_SET_ADD_MASK      	0x3f    /* 0x3f for, 64 0x7f for 128 nuber of sets */
#define IMMU_SET_NB            	64
#define IMMU_PAGE_ADD_BITS     	13      /* 13 for 8k, 12 for 4k page size */
#define IMMU_PAGE_ADD_MASK     	0x3fff  /* 0x3fff for 8k, 0x1fff for 4k page size */
#define IMMU_SET_ADD_MASK      	0x3f    /* 0x3f for, 64 0x7f for 128 nuber of sets */
  
#endif
