ifndef CROSS_COMPILE
CROSS_COMPILE = or32-elf-
endif
CC = $(CROSS_COMPILE)gcc
LD = $(CROSS_COMPILE)ld
NM = $(CROSS_COMPILE)nm
OBJDUMP = $(CROSS_COMPILE)objdump
OBJCOPY = $(CROSS_COMPILE)objcopy

APP = gpio

export	CROSS_COMPILE

CFLAGS += -O2

all: $(APP).bin  System.map mif


reset.o: reset.S Makefile board.h
	$(CC) -g -c -o $@ $< $(CFLAGS)

$(APP).o: $(APP).c Makefile board.h
	$(CC) -g -c -o $@ $< $(CFLAGS)

$(APP).or32: reset.o $(APP).o Makefile
	$(LD) -Tram.ld -o $@ reset.o $(APP).o $(LIBS)
	$(OBJDUMP) -d $@ > $(APP).dis

$(APP).bin: $(APP).or32
	$(OBJCOPY) $(APP).or32 $(APP).bin -O binary -I elf32-or32
	bin2hex_8 $(APP).bin > $(APP).ver

$(APP).hex: $(APP).bin
	bin2hex_32  $(APP).bin > $(APP).hex

$(APP).srec: $(APP).or32
	$(OBJCOPY) -O srec $(APP).or32 $(APP).srec

mif: $(APP).ihex
	ihex2mif -f $(APP).ihex -o $(APP).mif
	cp $(APP).mif ../on_chip_ram.mif

$(APP).ihex: $(APP).or32
	$(OBJCOPY) -O ihex $(APP).or32 $(APP).ihex

System.map: $(APP).or32
	@$(NM) $< | \
		grep -v '\(compiled\)\|\(\.o$$\)\|\( [aUw] \)\|\(\.\.ng$$\)\|\(LASH[RL]DI\)' | \
		sort > System.map

#########################################################################
clean:
	find . -type f \
		\( -name 'core' -o -name '*.bak' -o -name '*~' \
		-o -name '*.o'  -o -name '*.a' -o -name '*.tmp' \
		-o -name '*.or32' -o -name '*.bin' -o -name '*.srec' \
		-o -name '*.mem' -o -name '*.img' -o -name '*.out' \
		-o -name '*.aux' -o -name '*.log' -o -name '*.hex' \
		-o -name '*.init' -o -name '*.dis'  -o -name '*.ver' \
		-o -name '*.hex' -o -name '*.mif' -o -name '*.ihex' \
		-o -name '*.dis' -o -name '*.rif' \) -print \
		| xargs rm -f
	rm -f System.map

distclean: clean
	find . -type f \
		\( -name .depend -o -name '*.srec' -o -name '*.bin' \
		-o -name '*.pdf' \) \
		-print | xargs rm -f
	rm -f $(OBJS) *.bak tags TAGS
	rm -fr *.*~
