/*
 *
 * Block driver for spiMaster to drive SD card 
 *
 * Copyright (c) 2008 by:
 *      Xianfeng Zeng <xianfeng.zeng@gmail.com>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the BSD Licence, GNU General Public License
 * as published by the Free Software Foundation; either version 2 of the
 * License, or (at your option) any later version
 *
 * ChangeLog:
 *      2009-11-28 15:11:18   Xianfeng Zeng
 *          Init.
 *
 */

#include <linux/version.h>
#include <linux/module.h>
#include <linux/init.h>
#include <linux/kernel.h>
#include <linux/sched.h>
#include <linux/fs.h>
#include <linux/genhd.h>
#include <linux/delay.h>

#include <linux/slab.h>		/* kmalloc() */
#include <linux/errno.h>	/* error codes */
#include <linux/timer.h>
#include <linux/types.h>	/* size_t */
#include <linux/fcntl.h>	/* O_ACCMODE */
#include <linux/hdreg.h>	/* HDIO_GETGEO */
#include <linux/kdev_t.h>
#include <linux/vmalloc.h>
#include <linux/genhd.h>
#include <linux/blkdev.h>
#include <linux/buffer_head.h>	/* invalidate_bdev */
#include <linux/bio.h>


#include "sd_card.h"

//#define SDC_DEBUG 1

#ifdef SDC_DEBUG
#	define SDC_PRINTK(fmt, args...) printk( KERN_WARNING "sd_card:" fmt, ## args)
#else
#	define SDC_PRINTK(fmt, args...)
#endif

#define DRIVER_NAME  	"sd_card"
#define SD_CARD_MINORS 	8
#define SD_CARD_SIZE 	1995440128
//(512*1024*1024)
//1995440128

static int major = 8;


/**
 * ============================================================
 *                                    
 * ============================================================
 */
int spiMaster_init(void *vbase)
{
	unsigned char data;
	int   i;

	SDC_PRINTK("spiMaster_init begin\n");

	for (i = 0; i < 5; i++) {
		REG8(vbase + SD_TRANS_TYPE_REG) = SD_INIT_SD;
		REG8(vbase + SD_TRANS_CTRL_REG) = 1; // TRANS_START;

		mdelay(1);

		while (REG8(vbase + SD_TRANS_STS_REG) & 0x1) { // exit while !TRABS_BUSY
			;
		}

		data = REG8(vbase + SD_TRANS_ERROR_REG) & 0x3;

		if (data == 0) {
			SDC_PRINTK("spiMaster_init done\n");
			return 0;
		}	
	}

	SDC_PRINTK("spiMaster_init failed\n");

	return data;
}

/**
 * ============================================================
 *             Request Handling                       
 * ============================================================
 */

static int read_sd_block(void *sd_vbase, unsigned long sector,
		unsigned long nsect, char *buffer)
{
	unsigned char data;
	unsigned char transError;
	int i;
	unsigned int buffer_offset = 0;
	unsigned int blockCnt;
	unsigned int start = sector << 9; /* x512*/

	SDC_PRINTK("read_sd_block begin: sector=%ld, nsect=%ld\n", sector, nsect);

	for (blockCnt = 0; blockCnt < nsect; blockCnt++) {
		REG8(sd_vbase + SD_ADDR_7_0_REG)   = 0;
		REG8(sd_vbase + SD_ADDR_15_8_REG)  = (unsigned char) ((start >> 8) & 0xff);
		REG8(sd_vbase + SD_ADDR_23_16_REG) = (unsigned char) ((start >> 16) & 0xff);
		REG8(sd_vbase + SD_ADDR_31_24_REG) = (unsigned char) ((start >> 24) & 0xff);

		REG8(sd_vbase + SD_TRANS_TYPE_REG) = SD_RW_READ_SD_BLOCK;
		REG8(sd_vbase + SD_RX_FIFO_CONTROL_REG) = 0x1; /* Clean the RX FIFO */
		REG8(sd_vbase + SD_TRANS_CTRL_REG) = 0x1; /* TRANS_START */


		while (REG8(sd_vbase + SD_TRANS_STS_REG) & 0x1) { /* exit while !TRABS_BUSY */
			;
		}

		transError = REG8(sd_vbase + SD_TRANS_ERROR_REG) & 0xc;
		if ( transError == SD_READ_NO_ERROR) {
			for (i = 0; i < 512; i++) {
				data = REG8(sd_vbase + SD_RX_FIFO_DATA_REG) ;			
				//REG8(buffer + buffer_offset + i) = data ;
				buffer[buffer_offset + i] = data ;
//				printk("%x\t",data);
//				if (i%16 == 0) {
//					printk("\n");
//				}
			}
//			printk("\n");
			buffer_offset += 512;
			start += 512;
		} else {
			SDC_PRINTK("read_sd_block failed. Re-try\n");
			spiMaster_init(sd_vbase); /* Init again and retry */
			blockCnt--; /* read the same block again */
		}
	}

	SDC_PRINTK("read_sd_block done\n");

	return 0;
}

static int write_sd_block(void *sd_vbase, unsigned long sector,
		unsigned long nsect, char *buffer)
{
	int i;
	unsigned char data;
	unsigned int blockCnt;
	char *p = buffer;
	unsigned int start = sector << 9; /* x512*/


	SDC_PRINTK("write_sd_block begin: sector=%ld, nsect=%ld\n", sector, nsect);

	for (blockCnt = 0; blockCnt < nsect; blockCnt++) {

		/* Clean the TX FIFO */
		REG8(sd_vbase + SD_TX_FIFO_CONTROL_REG) = 0x1; 

		REG8(sd_vbase + SD_ADDR_7_0_REG)   = 0;
		REG8(sd_vbase + SD_ADDR_15_8_REG)  = (unsigned char) ((start >> 8) & 0xff);
		REG8(sd_vbase + SD_ADDR_23_16_REG) = (unsigned char) ((start >> 16) & 0xff);
		REG8(sd_vbase + SD_ADDR_31_24_REG) = (unsigned char) ((start >> 24) & 0xff);


		// Write data to TX_FIFO_DATA_REG
		for (i = 0; i < 512; i++) {
			REG8(sd_vbase + SD_TX_FIFO_DATA_REG) = p[i];
		}

		REG8(sd_vbase + SD_TRANS_TYPE_REG) = SD_RW_WRITE_SD_BLOCK;
		REG8(sd_vbase + SD_TRANS_CTRL_REG) = 1; /* TRANS_START */

		udelay(10);
		while (REG8(sd_vbase + SD_TRANS_STS_REG) & 0x1) { /* exit while !TRABS_BUSY */
			;
		}

		data = REG8(sd_vbase + SD_TRANS_ERROR_REG) & 0x30;
		if (data == 1) {
			printk("sd_card:WRITE_CMD_ERROR\n\r");
		} else if (data == 2) {
			printk("sd_card:WRITE_DATA_ERROR\n\r");
		} else if (data == 3) {
			printk("sd_card:WRITE_BUSY_ERROR\n\r");
		}

		start += 512;
		p += 512;
	}

	SDC_PRINTK("write_sd_block done\n");
	return 0;
}

/*
 * Handle an I/O request.
 */
static void sd_card_transfer(struct sd_card_dev *dev, unsigned long sector,
		unsigned long nsect, char *buffer, int write)
{
	unsigned long offset = sector*512;
	unsigned long nbytes = nsect*512;

	if ((offset + nbytes) > dev->size) {
		printk (KERN_NOTICE "Beyond-end write (%ld %ld)\n", offset, nbytes);
		return;
	}
	if (write)
		write_sd_block(dev->vir_base, sector, nsect, buffer);
	else
		read_sd_block(dev->vir_base, sector, nsect, buffer);
}


/*
 * The simple form of the request function.
 */
static void sd_card_request(request_queue_t *q)
{
	struct request *req;

	while ((req = elv_next_request(q)) != NULL) {
		struct sd_card_dev *dev = req->rq_disk->private_data;
		if (! blk_fs_request(req)) {
			printk (KERN_NOTICE "Skip non-fs request\n");
			end_request(req, 0);
			continue;
		}
    //    	printk (KERN_NOTICE "Req dev %d dir %ld sec %ld, nr %d f %lx\n",
    //    			dev - Devices, rq_data_dir(req),
    //    			req->sector, req->current_nr_sectors,
    //    			req->flags);
		sd_card_transfer(dev, req->sector, req->current_nr_sectors,
				req->buffer, rq_data_dir(req));
		end_request(req, 1);
	}
}

/**
 * ============================================================
 *             Block device operations                       
 * ============================================================
 */
static int sd_card_open(struct inode *inode, struct file *filp)
{
	struct sd_card_dev *dev = inode->i_bdev->bd_disk->private_data;

	SDC_PRINTK("sd_card_open beging\n");

	filp->private_data = dev;
	spin_lock(&dev->lock);
	if (! dev->users) 
		check_disk_change(inode->i_bdev);

	/* Init SD card controller */
	spiMaster_init(dev->vir_base);

	dev->users++;
	spin_unlock(&dev->lock);

	SDC_PRINTK("sd_card_open done\n");

	return 0;
}

static int sd_card_release(struct inode *inode, struct file *filp)
{
	struct sd_card_dev *dev = inode->i_bdev->bd_disk->private_data;

	SDC_PRINTK("sd_card_release beging\n");

	spin_lock(&dev->lock);
	dev->users--;

	spin_unlock(&dev->lock);

	SDC_PRINTK("sd_card_release done\n");

	return 0;
}

/*
 * Look for a (simulated) media change.
 */
int sd_card_media_changed(struct gendisk *gd)
{
	//struct sd_card_dev *dev = gd->private_data;
	
	return 0; //dev->media_change;
}

/*
 * Revalidate.  WE DO NOT TAKE THE LOCK HERE, for fear of deadlocking
 * with open.  That needs to be reevaluated.
 */
int sd_card_revalidate(struct gendisk *gd)
{
	struct sd_card_dev *dev = gd->private_data;
	
	if (dev->media_change) {
		dev->media_change = 0;
//		memset (dev->data, 0, dev->size);
	}
	return 0;
}


/*
 * The ioctl() implementation
 */

static int sd_card_getgeo(struct block_device *bdev,
                struct hd_geometry *geo)
{
        /*
         * capacity        heads        sectors        cylinders
         * 0~16M             1             1           0~32768
         * 16M~512M          1             32          1024~32768
         * 512M~16G          32            32          1024~32768
         * 16G~...           255           63          2088~...
         */
        if (SD_CARD_SIZE < 16 * 1024 * 1024) {
                geo->heads = 1;
                geo->sectors = 1;

        } else if (SD_CARD_SIZE < 512 * 1024 * 1024) {
                geo->heads = 1;
                geo->sectors = 32;
        } else if (SD_CARD_SIZE < 16ULL * 1024 * 1024 * 1024) {
                geo->heads = 32;
                geo->sectors = 32;
        } else {
                geo->heads = 255;
                geo->sectors = 63;
        }

        geo->cylinders = SD_CARD_SIZE>>9/geo->heads/geo->sectors;

        return 0;
}

int sd_card_ioctl (struct inode *inode, struct file *filp,
                 unsigned int cmd, unsigned long arg)
{
	long size;
	struct hd_geometry geo;
	struct sd_card_dev *dev = filp->private_data;

	switch(cmd) {
	    case HDIO_GETGEO:
        	/*
		 * Get geometry: since we are a virtual device, we have to make
		 * up something plausible.  So we claim 16 sectors, four heads,
		 * and calculate the corresponding number of cylinders.  We set the
		 * start of data at sector four.
		 */
		size = dev->size;
		geo.cylinders = (size & ~0x3f) >> 6;
		geo.heads = 62; //32;
		geo.sectors = 62; //63;
		geo.start = get_start_sect(inode->i_bdev);
		if (copy_to_user((void __user *) arg, &geo, sizeof(geo)))
			return -EFAULT;
		return 0;
	}

	return -ENOTTY; /* unknown command */
}


/*
 * The device operations structure.
 */
static struct block_device_operations sd_card_ops = {
	.owner           = THIS_MODULE,
	.open 	         = sd_card_open,
	.release 	 = sd_card_release,
	.media_changed   = sd_card_media_changed,
	.revalidate_disk = sd_card_revalidate,
//	.ioctl	         = sd_card_ioctl,
	.getgeo		 = sd_card_getgeo
};

/**
 * ============================================================
 *                 Driver Entry and clean up                   
 * ============================================================
 */
static int __init sd_card_init(void)
{
	int ret;
	struct sd_card_dev  *dev;

	/* Put the init code here */
	printk(KERN_INFO "SD Card Driver Enter.\n");

	dev = (struct sd_card_dev *)kmalloc(sizeof(struct sd_card_dev), GFP_KERNEL);
	if (dev < 0) {
		printk(KERN_WARNING "lack of memory\n");
		return -1;
	}
	memset(dev, 0, sizeof(struct sd_card_dev));

	ret = register_blkdev(major, DRIVER_NAME);
	if (ret <0) {
		printk(KERN_WARNING "sd_card: unable to get major number\n");
		kfree(dev);
		return -EBUSY;
	}

	dev->size = SD_CARD_SIZE; //1015808000; /* 1GB */
	spin_lock_init(&dev->lock);
	dev->queue = blk_init_queue(sd_card_request, &dev->lock);
	blk_queue_hardsect_size(dev->queue, 512);

	dev->vir_base = ioremap(SD_BASE_ADD, 0x2000);

	/* Reset spiMaster controller */
	REG8(dev->vir_base + SD_TRANS_CTRL_REG) = 0x1;  /* reset spiMaster */
	mdelay(1);
  	REG8(dev->vir_base + SD_TRANS_CTRL_REG) = 0x0;
	REG8(dev->vir_base + SD_CLK_DEL_REG) = 0x1;

	/* allocate gendsik and init it */
	dev->gd = alloc_disk(SD_CARD_MINORS);
	if (!dev->gd) {
		printk(KERN_WARNING "alloc_disk failed\n");
		kfree(dev);
		unregister_blkdev(major, DRIVER_NAME);
		return -1;
	}
	dev->gd->major 		= major;
	dev->gd->first_minor 	= 0;
	dev->gd->fops 		= &sd_card_ops;
	dev->gd->queue		= dev->queue;
	dev->gd->private_data	= dev;
	snprintf(dev->gd->disk_name, 32, "sd%c", 'a');

	set_capacity(dev->gd, dev->size/512);

	add_disk(dev->gd);

	SDC_PRINTK("sd_card_init done\n");

	return 0;
}


static void __exit sd_card_exit(void)
{
	/* Put the driver clean up code here */

	unregister_blkdev(major, DRIVER_NAME);

	printk(KERN_INFO "SD Card Driver Exit.\n");
}

//module_init(sd_card_init);
late_initcall(sd_card_init);
module_exit(sd_card_exit);

MODULE_LICENSE("Dual BSD/GPL");
MODULE_AUTHOR("Xianfeng Zeng - Xianfeng.zeng@SierraAtlantic.com, http://www.LinuxExperts.cn");
MODULE_DESCRIPTION("spiMaster driver");
MODULE_VERSION("0.1");

