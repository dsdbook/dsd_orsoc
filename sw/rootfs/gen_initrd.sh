#!/bin/bash
#dxzhang@ustc.edu
mount -o loop initrd-fb-03.ext2 initrd
cd initrd

rm -rf bin/ sbin/ linuxrc  usr/


#avoid cp alias
/bin/cp -rf -dR ../busy_out.1.7.5/* .

/bin/cp -rf ../app/hello/hello bin

#add date
echo  "`date`" > timestamp

cd ..

umount initrd

/bin/cp -rf initrd-fb-03.ext2 ../linux-2.6.23/arch/or32/support/initrd-fb-03.ext2

#make sure that we can use the latest rootfs image
rm -rf ../linux-2.6.23/arch/or32/support/initrd.o 
