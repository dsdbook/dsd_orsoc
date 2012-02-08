/* ------------------------------ */
/* link script */
/* ------------------------------ */

MEMORY
        {
        boot_rom_1        : ORIGIN = 0x00000000, LENGTH = 0x00020000
        mem_bank_3        : ORIGIN = 0x30000000, LENGTH = 0x00010000
        }
        
ENTRY(_start)

SECTIONS
{
        .text ALIGN(0x4):
        {
          . = 0x100;
          *(.vectors)
  		    __text_start = .;
          . = 0x2000;  
          *(.text)
      		__text_end = .;
        } > boot_rom_1

        .rodata ALIGN(0x4):
        {
      		__rodata_start = .;
          *(.rodata)
          *(.rodata.*)
      		__rodata_end = .;
        } > boot_rom_1

      	.u_boot_cmd ALIGN(0x4):
      	{
      		. = .;
      	  ___u_boot_cmd_start = .;
      		*(.u_boot_cmd)
      	  ___u_boot_cmd_end = .;
      	} > boot_rom_1

      	. = ALIGN(4);
      		__data_lma_start = .;
        .data : 
        {
      		__data_start = .;
          *(.data)
      		__data_end = .;
        } > boot_rom_1
        
      	. = ALIGN(4);
        .bss (NOLOAD):
        {
      		__bss_start = .;
          *(.bss)
      		__bss_end = .;
        } > mem_bank_3

      	. = ALIGN(4);
        .stack (NOLOAD) :
        {
      		__stack_start = .;
          *(.stack)
      		__stack_end = .;
        } > mem_bank_3
        
      	__end = . ;
}
