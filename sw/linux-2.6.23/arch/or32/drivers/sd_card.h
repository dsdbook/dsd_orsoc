#ifndef __SD_CARD_H__
#define __SD_CARD_H__

#include <asm/board.h>

#define SD_BASE_ADD		SD_BASE

#define SD_TRANS_TYPE_REG	0x2
#define SD_TRANS_CTRL_REG	0x3
#define SD_TRANS_STS_REG	0x4
#define SD_TRANS_ERROR_REG		0x5
#define SD_DIRECT_ACCESS_DATA_REG	0x6
#define SD_ADDR_7_0_REG		0x7
#define SD_ADDR_15_8_REG	0x8
#define SD_ADDR_23_16_REG	0x9
#define SD_ADDR_31_24_REG	0xa
#define SD_CLK_DEL_REG		0xb
#define SD_RX_FIFO_DATA_REG	0x10
#define SD_RX_FIFO_DATA_COUNT_MSB	0x12
#define SD_RX_FIFO_DATA_COUNT_LSB	0x13
#define SD_RX_FIFO_CONTROL_REG		0x14
#define SD_TX_FIFO_DATA_REG		0x20
#define SD_TX_FIFO_CONTROL_REG		0x24

#define SD_DIRECT_ACCESS	0
#define SD_INIT_SD		1
#define SD_RW_READ_SD_BLOCK	2
#define SD_RW_WRITE_SD_BLOCK	3

#define SD_WRITE_NO_ERROR	0
#define SD_WRITE_CMD_ERROR	1
#define SD_WRITE_DATA_ERROR	2
#define SD_WRITE_BUSY_ERROR	3

#define SD_READ_NO_ERROR	0
#define SD_READ_CMD_ERROR	1
#define SD_READ_TOKEN_ERROR	2

#define SD_INIT_NO_ERROR	0
#define SD_INIT_CMD0_ERROR	1
#define SD_INIT_CMD1_ERROR	2

#define REG8(add)  *((volatile unsigned char *)  (add))
#define REG16(add) *((volatile unsigned short *) (add))
#define REG32(add) *((volatile unsigned long *)  (add))

struct sd_card_dev {
	void			*vir_base;	/* Virtual address for spiMaster */
	int			size;		/* the size of the SD Card */
	short			users;		/* How many users are using me */
	short			media_change;	/* a flag to save the media change */
	spinlock_t		lock;		/* lock for request queue */
	struct request_queue	*queue;		/* request queue */
	struct gendisk		*gd;		/* gendisk */
};



#endif /* __SD_CARD_H__ */

