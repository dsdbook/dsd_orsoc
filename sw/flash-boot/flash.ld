MEMORY
        {
        flash   : ORIGIN = 0xF0000000, LENGTH = 0x00800000
	ram	: ORIGIN = 0x00000000, LENGTH = 0x02000000
        }
 
SECTIONS
{
        .reset :
        {
        *(.reset)
        } > flash

        .text :
        {
        *(.text)
        } > flash

        .data :
        {
        *(.data)
        } > flash

        .rodata :
        {
        *(.rodata)
        } > flash

        .bss :
        {
        *(.bss)
        } > flash


	.dummy ALIGN(0x04):
	{
	. = ALIGN(0x4);
	PROVIDE( _user_prog = . ) ;
	} > flash

	.user_prog_file :
	AT ( ADDR (.dummy) )
	{
	PROVIDE( _user_start = . );
	*(.user_prog_file)
	. = ALIGN(0x4);
	PROVIDE( _user_end = . );
	} > ram
	
}
