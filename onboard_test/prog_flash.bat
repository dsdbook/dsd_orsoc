#!/bin/bash
if [ -z $1 ] 
then
	echo "Usage: bash $0  bin_file_base_name"
	echo "example: bash $0 vmlinux"
	exit 0
fi
#start nios2 cmd shell first!!
bin2flash  --location=0x0 --input $1.bin --output $1.flash
nios2-configure-sof -c usb-blaster DE2_70_NET.sof
nios2-flash-programmer.exe -c usb-blaster --base=0x08800000 $1.flash