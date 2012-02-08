/*
 * linux/drivers/spi/spioc.c
 *
 * Copyright (C) 2007-2008 Avionic Design Development GmbH
 * Copyright (C) 2008-2009 Avionic Design GmbH
 *
 * Partially inspired by code from linux/drivers/spi/pxa2xx_spi.c.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2 as
 * published by the Free Software Foundation.
 *
 * Written by Thierry Reding <thierry.reding@avionic-design.de>
 */

#include <linux/clk.h>
#include <linux/delay.h>
#include <linux/err.h>
#include <linux/interrupt.h>
#include <linux/io.h>

//add by dxzhang
#include <linux/types.h>
#include <linux/device.h>
#include <linux/workqueue.h>
#include <linux/clk.h>
#include <asm/board.h>
//end

#include <linux/platform_device.h>
#include <linux/spi/spi.h>

//add by dxzhang
#define ioread32	readl
#define	iowrite32	writel

#define SPIOC_INCLK	SYS_CLK	

static inline resource_size_t resource_size(const struct resource *res)
{
        return res->end - res->start + 1;
}
//end by dxzhang

/* register definitions */
#define	SPIOC_RX(i)	(i * 4)
#define	SPIOC_TX(i)	(i * 4)
#define	SPIOC_CTRL	0x10
#define	SPIOC_DIV	0x14
#define	SPIOC_SS	0x18

/* SPIOC_CTRL register */
#define	CTRL_LEN(x)	((x < 128) ? x : 0)
#define	CTRL_BUSY	(1 <<  8)
#define	CTRL_RXNEG	(1 <<  9)
#define	CTRL_TXNEG	(1 << 10)
#define	CTRL_LSB	(1 << 11)
#define	CTRL_IE		(1 << 12)
#define	CTRL_ASS	(1 << 13)

#define	SPIOC_MAX_LEN	((unsigned int)16)

static const u32 clock_mode[4] = {
	[SPI_MODE_0] = CTRL_TXNEG,
	[SPI_MODE_1] = CTRL_RXNEG,
	[SPI_MODE_2] = CTRL_TXNEG,
	[SPI_MODE_3] = CTRL_RXNEG,
};

/* valid SPI mode bits */
#define	MODEBITS	(SPI_CPHA | SPI_CPOL | SPI_LSB_FIRST)

struct spioc_ctldata {
	u32 ctrl;
	u32 div;
};

struct spioc {
	struct spi_master *master;
	void __iomem *base;
//modify by dxzhang
//	struct clk *clk;
	unsigned long clk;
//end
	int irq;

	struct workqueue_struct *workqueue;
	struct work_struct work;
	struct tasklet_struct tasklet;

	struct list_head queue;
	struct completion msg_done;
	unsigned int state;
	unsigned int busy;
	spinlock_t lock;

	struct spi_device *slave;
	struct spi_message *message;
	struct spi_transfer *transfer;
	unsigned int cur_pos;
	unsigned int cur_len;
};

/* queue states */
#define	QUEUE_STOPPED	0
#define	QUEUE_RUNNING	1

static inline u32 spioc_read(struct spioc *spioc, unsigned long offset)
{
//add by dxzhang
	unsigned int tmp;
	tmp = ioread32(spioc->base + offset);
//	printk("spioc_read:offset=%x (%x),value=%x\n",offset,spioc->base + offset, tmp);
	return tmp;
//end
//	return ioread32(spioc->base + offset);
}

static inline void spioc_write(struct spioc *spioc, unsigned offset,
		u32 value)
{
//add by dxzhang
//	printk("spioc_write:offset=%x (%x), value=%x\n",offset,spioc->base + offset, value);
//end
	iowrite32(value, spioc->base + offset);
}

static u32 spioc_get_clkdiv(struct spioc *spioc, unsigned long speed)
{
//modify by dxzhang
//	unsigned long rate = clk_get_rate(spioc->clk);
	unsigned long rate = SPIOC_INCLK;
//end
	return DIV_ROUND_UP(rate, 2 * speed) - 1;
}

#if 0
//dxzhang:20110403 , unused
static void spioc_chipselect(struct spioc *spioc, struct spi_device *spi)
{
//modify by dxzhang
#if 1
	if (spi != spioc->slave) {
		u32 ss = spi ? (1 << spi->chip_select) : 0;
		spioc_write(spioc, SPIOC_SS, ss);
		spioc->slave = spi;
	}
#else
	u32 ss = spi ? (1 << spi->chip_select) : 0;
	spioc_write(spioc, SPIOC_SS, ss);
	if (spi != spioc->slave) {
		spioc->slave = spi;
	}
#endif
//end
}
#endif

static void spioc_copy_tx(struct spioc *spioc)
{
	const void *src;
	u32 val = 0;
	int i;

	if (!spioc->transfer->tx_buf)
		return;

	src = spioc->transfer->tx_buf + spioc->cur_pos;

	for (i = 0; i < spioc->cur_len; i++) {
		int rem = spioc->cur_len - i;
		int reg = (rem - 1) / 4;
		int ofs = (rem - 1) % 4;

		val |= (((u8 *)src)[i] & 0xff) << (ofs * 8);
		if (!ofs) {
			spioc_write(spioc, SPIOC_TX(reg), val);
			val = 0;
		}
	}
}

static void spioc_copy_rx(struct spioc *spioc)
{
	void *dest;
	u32 val = 0;
	int i;

	if (!spioc->transfer->rx_buf)
		return;

	dest = spioc->transfer->rx_buf + spioc->cur_pos;

	for (i = 0; i < spioc->cur_len; i++) {
		int rem = spioc->cur_len - i;
		int reg = (rem - 1) / 4;
		int ofs = (rem - 1) % 4;

		if ((i == 0) || (rem % 4 == 0))
			val = spioc_read(spioc, SPIOC_RX(reg));

		((u8 *)dest)[i] = (val >> (ofs * 8)) & 0xff;
	}
}

static inline struct spi_transfer *next_transfer(struct list_head *head)
{
	return list_entry(head->next, struct spi_transfer, transfer_list);
}

static void finish_message(struct spioc *spioc, int ec)
{
	struct spi_message *message = spioc->message;

	spioc->transfer = NULL;
	spioc->message = NULL;

	message->status = ec;

	if (message->complete)
		message->complete(message->context);
}

static void queue_message(struct spioc *spioc)
{
	if (spioc->state == QUEUE_RUNNING)
		queue_work(spioc->workqueue, &spioc->work);

	if (spioc->state == QUEUE_STOPPED)
		complete(&spioc->msg_done);
}

static struct spi_transfer *continue_message(struct spioc *spioc)
{
	struct spi_transfer *transfer = spioc->transfer;
	struct spi_message *message = spioc->message;
	unsigned long flags;

	if (!transfer)
		return next_transfer(&message->transfers);

	if (transfer->transfer_list.next != &message->transfers)
		return next_transfer(&transfer->transfer_list);

	spin_lock_irqsave(&spioc->lock, flags);
	finish_message(spioc, 0);
	queue_message(spioc);
	spin_unlock_irqrestore(&spioc->lock, flags);

	return NULL;
}

static void process_transfers(unsigned long data)
{
	struct spioc *spioc = (struct spioc *)data;
	struct spi_transfer *transfer;
	struct spi_message *message;
	struct spioc_ctldata *ctl;
	u32 ctrl = 0;
	u32 div = 0;

	WARN_ON(spioc->message == NULL);
	message = spioc->message;
	transfer = spioc->transfer;

	/* finish up the last partial transfer */
	if (transfer) {
		spioc_copy_rx(spioc);
		spioc->message->actual_length += spioc->cur_len;
		spioc->cur_pos += spioc->cur_len;
	}

	/* proceed to next (or first) transfer in message */
	if (!transfer || (spioc->cur_pos >= transfer->len)) {
		if (transfer) {
			if (transfer->delay_usecs)
				udelay(transfer->delay_usecs);
#if 0
//dxzhang:20110401.Didn't set chipselect here
			if (!transfer->cs_change)
				spioc_chipselect(spioc, NULL);
#endif
		}

		transfer = continue_message(spioc);
		if (!transfer)
			return;

		spioc->transfer = transfer;
		spioc->cur_pos = 0;
		spioc->cur_len = 0;
	}

	ctl = spi_get_ctldata(message->spi);
	div = ctl->div;

	if (transfer->speed_hz) {
		div = spioc_get_clkdiv(spioc, transfer->speed_hz);
		if (div > 0xffff) {
			finish_message(spioc, -EIO);
			return;
		}
	}


	spioc->cur_len = min(transfer->len - spioc->cur_pos, SPIOC_MAX_LEN);
	spioc_copy_tx(spioc);

	ctrl = ctl->ctrl;
	ctrl |= CTRL_LEN(spioc->cur_len * 8);
	ctrl |= CTRL_BUSY;
//add by dxzhang
#ifdef CONFIG_SPIOC_DONT_USE_INTERRUPT
//nothing
#else
	ctrl |= CTRL_IE;
#endif
//end

	spioc_write(spioc, SPIOC_DIV, div);
//	spioc_chipselect(spioc, spioc->message->spi);
//modify by dxzhang, write twice?
//	spioc_write(spioc, SPIOC_CTRL, ctrl);
	spioc_write(spioc, SPIOC_CTRL, ctrl & (~CTRL_BUSY));
	spioc_write(spioc, SPIOC_CTRL, ctrl);
//end
#ifdef CONFIG_SPIOC_DONT_USE_INTERRUPT
//add by dxzhang
	while(((ioread32(spioc->base + SPIOC_CTRL))& CTRL_BUSY ) ==  CTRL_BUSY){
        }
//	spioc_write(spioc, SPIOC_SS, 0);
	tasklet_schedule(&spioc->tasklet);
//end
#endif
}

static void process_messages(struct work_struct *work)
{
	struct spioc *spioc = container_of(work, struct spioc, work);
	struct spi_message *message;
	unsigned long flags;

	WARN_ON(spioc->message != NULL);

	spin_lock_irqsave(&spioc->lock, flags);

	if (list_empty(&spioc->queue)) {
		spioc->busy = 0;
		spin_unlock_irqrestore(&spioc->lock, flags);
		return;
	}

	message = list_entry(spioc->queue.next, struct spi_message, queue);
	list_del_init(&message->queue);
	spioc->message = message;
	tasklet_schedule(&spioc->tasklet);
	spioc->busy = 1;

	spin_unlock_irqrestore(&spioc->lock, flags);
}

//add by dxzhang:set_cs

void spioc_set_cs(struct spi_device *spi, int on_off)
{

	struct spioc *spioc = spi_master_get_devdata(spi->master);

	u32 ss= spi ? (1 << spi->chip_select) : 0;
	unsigned char ss_old;
	ss_old = spioc_read(spioc,SPIOC_SS);
	if(on_off)	
		spioc_write(spioc, SPIOC_SS, ss_old | ss);
	else
		spioc_write(spioc, SPIOC_SS, ss_old & (~ss));

}

unsigned long spioc_get_base( struct spi_device *spi)
{
	struct spioc *spioc = spi_master_get_devdata(spi->master);
	return spioc->base;
}

unsigned char spioc_get_chipselect( struct spi_device *spi)
{
	return spi->chip_select;
}

unsigned int spioc_get_div( struct spi_device *spi)
{
	struct spioc_ctldata *ctl = spi_get_ctldata(spi);
	return ctl->div;
}

//end by dxzhang

static int spioc_setup(struct spi_device *spi)
{
	struct spioc *spioc = spi_master_get_devdata(spi->master);
	struct spioc_ctldata *ctl = spi_get_ctldata(spi);
	u32 div = 0;

	if (spi->mode & ~MODEBITS)
		return -EINVAL;

	if (!spi->max_speed_hz)
		return -EINVAL;

	div = spioc_get_clkdiv(spioc, spi->max_speed_hz);
//dxzhang
//	printk("spioc_setup:mode=%u,max_speed_hz=%u,div=%d\n",spi->mode,spi->max_speed_hz,div);
//end
	if (div > 0xffff)
		return -EINVAL;

	if (!ctl) {
		ctl = kzalloc(sizeof(*ctl), GFP_KERNEL);
		if (!ctl)
			return -EINVAL;

		spi_set_ctldata(spi, ctl);
	}

	ctl->div = div;
	ctl->ctrl = 0;

	if (spi->mode & SPI_LSB_FIRST)
		ctl->ctrl |= CTRL_LSB;

	ctl->ctrl |= clock_mode[spi->mode & 0x3];

	return 0;
}

static int spioc_transfer(struct spi_device *spi, struct spi_message *message)
{
	struct spioc *spioc = spi_master_get_devdata(spi->master);
	unsigned long flags = 0;

	spin_lock_irqsave(&spioc->lock, flags);

	if (spioc->state == QUEUE_STOPPED) {
		spin_unlock_irqrestore(&spioc->lock, flags);
		return -ESHUTDOWN;
	}

	message->status = -EINPROGRESS;
	message->actual_length = 0;

	list_add_tail(&message->queue, &spioc->queue);

	if ((spioc->state == QUEUE_RUNNING) && !spioc->busy)
		queue_work(spioc->workqueue, &spioc->work);

	spin_unlock_irqrestore(&spioc->lock, flags);

	return 0;
}

static void spioc_cleanup(struct spi_device *spi)
{
	struct spioc_ctldata *ctl = spi_get_ctldata(spi);
	spi_set_ctldata(spi, NULL);
	kfree(ctl);
}

static irqreturn_t spioc_interrupt(int irq, void *dev_id)
{
	struct spi_master *master = dev_id;
	struct spioc *spioc;
//dxzhang:
//	printk("enter spioc_interrupt\n");

	if (!dev_id)
	{
		printk("dev_id==NULL\n");
		return IRQ_NONE;
	}
//end

	spioc = spi_master_get_devdata(master);
//add by dxzhang, clear interrupts;Don't invalid SS, ReadReg maybe failed!
	spioc_read(spioc, SPIOC_RX(0));
//	spioc_write(spioc, SPIOC_SS, 0);
//end
	tasklet_schedule(&spioc->tasklet);

	return IRQ_HANDLED;
}

static int init_queue(struct spi_master *master)
{
	struct spioc *spioc = spi_master_get_devdata(master);
//modify by dxzhang
//	spioc->workqueue = create_workqueue(dev_name(&master->dev));
	spioc->workqueue = create_workqueue(master->cdev.dev->bus_id);
//end
	if (!spioc->workqueue)
		return -ENOMEM;

	INIT_WORK(&spioc->work, process_messages);
	tasklet_init(&spioc->tasklet, process_transfers,
			(unsigned long)spioc);

	INIT_LIST_HEAD(&spioc->queue);
	init_completion(&spioc->msg_done);
	spin_lock_init(&spioc->lock);

	spioc->state = QUEUE_STOPPED;
	spioc->busy = 0;

	return 0;
}

static int start_queue(struct spi_master *master)
{
	struct spioc *spioc = spi_master_get_devdata(master);
	unsigned long flags;

	spin_lock_irqsave(&spioc->lock, flags);

	if ((spioc->state == QUEUE_RUNNING) || spioc->busy) {
		spin_unlock_irqrestore(&spioc->lock, flags);
		return -EBUSY;
	}

	spioc->state = QUEUE_RUNNING;
	spioc->message = NULL;
	spioc->transfer = NULL;

	spin_unlock_irqrestore(&spioc->lock, flags);

	queue_work(spioc->workqueue, &spioc->work);
	return 0;
}

static int stop_queue(struct spi_master *master)
{
	struct spioc *spioc = spi_master_get_devdata(master);
	unsigned long flags;
	unsigned int empty;
	unsigned int busy;

	spin_lock_irqsave(&spioc->lock, flags);

	empty = list_empty(&spioc->queue);
	spioc->state = QUEUE_STOPPED;
	busy = spioc->busy;

	spin_unlock_irqrestore(&spioc->lock, flags);

	if (!empty && busy)
		wait_for_completion(&spioc->msg_done);

	return 0;
}

static int destroy_queue(struct spi_master *master)
{
	struct spioc *spioc = spi_master_get_devdata(master);
	int ret;

	ret = stop_queue(master);
	if (ret < 0)
		return ret;

	destroy_workqueue(spioc->workqueue);

	return 0;
}

static int __devinit spioc_probe(struct platform_device *pdev)
{
	struct resource *res = NULL;
	int irq = 0;
	void __iomem *mmio = NULL;
	struct spi_master *master = NULL;
	struct spioc *spioc = NULL;
	int ret = 0;

	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
	if (!res) {
		dev_err(&pdev->dev, "MMIO resource not defined\n");
		return -ENXIO;
	}
	
//dxzhang
//	printk("platform_get_resource : res start = %x, size = %x\n",res->start,resource_size(res));
//end

	irq = platform_get_irq(pdev, 0);
	if (irq < 0) {
		dev_err(&pdev->dev, "IRQ not defined\n");
		return -ENXIO;
	}

	res = devm_request_mem_region(&pdev->dev, res->start,
			resource_size(res), res->name);
	if (!res) {
		dev_err(&pdev->dev, "failed to request memory region\n");
		return -ENXIO;
	}

	mmio = devm_ioremap_nocache(&pdev->dev, res->start,
			resource_size(res));
	if (!mmio) {
		dev_err(&pdev->dev, "failed to remap I/O region\n");
		ret = -ENXIO;
		goto free;
	}
//dxzhang
//	printk("mmio = %x\n",(unsigned long )mmio);
//end

	master = spi_alloc_master(&pdev->dev, sizeof(struct spioc));
	if (!master) {
		dev_err(&pdev->dev, "failed to allocate SPI master\n");
		ret = -ENOMEM;
		goto free;
	}

	master->setup = spioc_setup;
	master->transfer = spioc_transfer;
	master->cleanup = spioc_cleanup;

	spioc = spi_master_get_devdata(master);
	if (!spioc) {
		ret = -ENXIO;
		goto free;
	}

	spioc->master = master;
	spioc->base = mmio;
	spioc->irq = irq;
	spioc->slave = NULL;

	ret = init_queue(master);
	if (ret < 0) {
//modify by dxzhang
//		dev_err(&master->dev, "failed to initialize message queue\n");
		dev_err(master->cdev.dev, "failed to initialize message queue\n");
//end
		goto free;
	}

	ret = start_queue(master);
	if (ret < 0) {
//modify by dxzhang
//		dev_err(&master->dev, "failed to start message queue\n");
		dev_err(master->cdev.dev, "failed to start message queue\n");
//end
		goto free;
	}

//	spioc->clk = clk_get(NULL, "spi-master-clk");
	spioc->clk = SPIOC_INCLK;
//disabled by dxzhang
#if 0
	if (IS_ERR(spioc->clk)) {
//modify by dxzhang
//		dev_err(&master->dev, "SPI master clock undefined\n");
		dev_err(master->cdev.dev, "SPI master clock undefined\n");
//end
		ret = PTR_ERR(spioc->clk);
		spioc->clk = NULL;
		goto free;
	}
#endif

//modify by dxzhang
//	ret = devm_request_irq(&pdev->dev, irq, spioc_interrupt, IRQF_SHARED,
//			"spioc", master);
	ret = request_irq(irq, spioc_interrupt, IRQF_DISABLED,
			"spioc", master);
//
	if (ret) {
//modify by dxzhang
//		dev_err(&master->dev, "failed to install handler for "
		dev_err(master->cdev.dev, "failed to install handler for "
				"IRQ%d\n", irq);
//end
		goto put_clock;
	}

	/* set SPI bus number and number of chipselects */
	master->bus_num = pdev->id;
	master->num_chipselect = 8;

	ret = spi_register_master(master);
	if (ret) {
//modify by dxzhang
//		dev_err(&master->dev, "failed to register SPI master\n");
		dev_err(master->cdev.dev, "failed to register SPI master\n");
//end
		goto put_clock;
	}

	platform_set_drvdata(pdev, master);
	return ret;

put_clock:
//disabled by dxzhang
//	clk_put(spioc->clk);
//end
free:
	spi_master_put(master);
	return ret;
}

static int __devexit spioc_remove(struct platform_device *pdev)
{
	struct spi_master *master = platform_get_drvdata(pdev);
//dxzhang:unused,comment out
//	struct spioc *spioc = spi_master_get_devdata(master);

	spi_master_get(master);
	platform_set_drvdata(pdev, NULL);
	spi_unregister_master(master);
	destroy_queue(master);
//disabled by dxzhang
//	clk_put(spioc->clk);
//
	spi_master_put(master);

	return 0;
}

#ifdef CONFIG_PM
static int spioc_suspend(struct platform_device *pdev, pm_message_t state)
{
	struct spi_master *master;
	int ret = 0;

	master = platform_get_drvdata(pdev);

	ret = stop_queue(master);
	if (ret < 0)
		dev_err(&master->dev, "failed to stop queue\n");

	return ret;
}

static int spioc_resume(struct platform_device *pdev)
{
	struct spi_master *master;
	int ret = 0;

	master = platform_get_drvdata(pdev);

	ret = start_queue(master);
	if (ret < 0)
		dev_err(&master->dev, "failed to start queue\n");

	return ret;
}
#else
#define spioc_suspend NULL
#define spioc_resume  NULL
#endif /* CONFIG_PM */

static struct platform_driver spioc_driver = {
	.probe = spioc_probe,
	.remove = __devexit_p(spioc_remove),
	.suspend = spioc_suspend,
	.resume = spioc_resume,
	.driver = {
		.name  = "spioc",
		.owner = THIS_MODULE,
	},
};

static int __init spioc_init(void)
{
	printk("spioc_init, platform_driver_register\n");
	return platform_driver_register(&spioc_driver);
}

static void __exit spioc_exit(void)
{
	platform_driver_unregister(&spioc_driver);
}

module_init(spioc_init);
module_exit(spioc_exit);

MODULE_AUTHOR("Thierry Reding <thierry.reding@avionic-design.de>");
MODULE_DESCRIPTION("OpenCores SPI controller driver");
MODULE_LICENSE("GPL v2");

