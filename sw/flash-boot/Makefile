ifndef CROSS_COMPILE
CROSS_COMPILE = or32-elf-
endif
CC = $(CROSS_COMPILE)gcc
LD = $(CROSS_COMPILE)ld
NM = $(CROSS_COMPILE)nm
OBJCOPY = $(CROSS_COMPILE)objcopy
OBJDUMP = $(CROSS_COMPILE)objdump

export	CROSS_COMPILE

#CFLAGS += -O2

all:  flash_boot.or32 flash_boot.bin flash_boot.ver System.map

flash_boot.o: flash_boot.S  board.h userprog.bin Makefile
	$(CC) -c -o $@ $< $(CFLAGS)

flash_boot.or32: flash_boot.o  flash.ld Makefile
	$(LD) -Tflash.ld -o $@  flash_boot.o $(LIBS)
	$(OBJDUMP) -d $@ > flash_boot.dis

flash_boot.bin: flash_boot.or32 Makefile
	$(OBJCOPY)  -S  flash_boot.or32 flash_boot.bin -O binary -I elf32-or32
	cp $@ ../flash.bin

flash_boot.ver: flash_boot.bin Makefile
	bin2hex_8 flash_boot.bin >flash_boot.ver
	cp flash_boot.ver ../flash.ver

System.map: flash_boot.or32
	@$(NM) $< | \
		grep -v '\(compiled\)\|\(\.o$$\)\|\( [aUw] \)\|\(\.\.ng$$\)\|\(LASH[RL]DI\)' | \
		sort > System.map

#########################################################################
clean:
	find . -type f \
		\( -name 'core' -o -name '*.bak' -o -name '*~' \
		-o -name '*.o'   -o -name '*.tmp' \
		-o -name '*.or32' -o -name '*.bin' -o -name '*.srec' \
		-o -name '*.mem' -o -name '*.img' -o -name '*.out' \
		-o -name '*.aux' -o -name '*.log' -o -name '*.hex' -o \
		-name '*.init' -o -name '*.dis' -o -name '*.ver' -o -name System.map \) -print \
		| xargs rm -f

distclean: clean
	find . -type f \
		\( -name .depend -o -name '*.srec' -o -name '*.bin' \
		-o -name '*.pdf' -o -name '*.ver' \) \
		-print | xargs rm -f
	rm -f $(OBJS) *.bak tags TAGS
	rm -fr *.*~
