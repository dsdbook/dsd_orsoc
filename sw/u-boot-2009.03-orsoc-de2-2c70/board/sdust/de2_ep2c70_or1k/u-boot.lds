/* ------------------------------ */
/* link script */
/* ------------------------------ */
/* DE2-2C70 orsoc ,dxzhang@ustc.edu*/
MEMORY
        {
        flash   : ORIGIN = 0xF0000000, LENGTH = 0x00800000
        sdram   : ORIGIN = 0x00000000, LENGTH = 0x02000000
        }
      
ENTRY(_reset)

SECTIONS
{
	.reset 0xF0000000: AT(0xF0000000)
        {
          *(.reset)
	  cpu/or1k/start.o (.text)
	  . = ALIGN(4);
	} 

	_u_boot_start = .;
	PROVIDE (u_boot_start = .);
        .text : AT ( LOADADDR (.reset) + SIZEOF (.reset) )
        {
  	    	__text_start = .;
	 *(.tick_timer_text)
          *(.text)
	. = ALIGN(4);
      		__text_end = .;
	}

        .rodata (ADDR(.text) + SIZEOF(.text)) : AT ( LOADADDR(.text) + SIZEOF(.text) )
        {
      		__rodata_start = .;
          *(.rodata)
          *(.rodata.*)
	. = ALIGN(4);
      		__rodata_end = .;
        }


      	.u_boot_cmd (ADDR(.rodata) + SIZEOF(.rodata)) : AT(LOADADDR(.rodata)+SIZEOF(.rodata))
      	{
		. = .;
      	  	__u_boot_cmd_start = .;
      	  	___u_boot_cmd_start = .;
      	*(.u_boot_cmd)
	. = ALIGN(4);
      		__u_boot_cmd_end = .;
      		___u_boot_cmd_end = .;
      	}


        .data (ADDR(.u_boot_cmd) + SIZEOF(.u_boot_cmd)): AT(LOADADDR(.u_boot_cmd)+SIZEOF(.u_boot_cmd))
        {
      		__data_start = .;
          *(.data)
	. = ALIGN(4);
      		__data_end = .;
        }



        .bss (ADDR(.data) + SIZEOF(.data)) (NOLOAD):
        {
      		__bss_start = .;
          *(.bss)
	. = ALIGN(4);
      		__bss_end = .;
        }

        .stack (ADDR(.bss) + SIZEOF(.bss)) (NOLOAD) :
        {
      		__stack_start = .;
          *(.stack)
      	. = ALIGN(4);
      		__stack_end = .;
        }
        
      	__end = . ;
}
