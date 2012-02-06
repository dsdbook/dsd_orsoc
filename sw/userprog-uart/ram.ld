MEMORY
        {
        vectors : ORIGIN = 0x00000000, LENGTH = 0x00002000 
        ram     : ORIGIN = 0x00002000, LENGTH = 0x02000000-0x00002000
        }
 
SECTIONS
{
        .vectors :
        {
        *(.vectors)
        } > vectors

        .text :
        {
        *(.text)
        } > ram

        .data :
        {
        *(.data)
        } > ram

        .rodata :
        {
        *(.rodata)
	*(.rodata.str1.1)
        } > ram

        .bss :
        {
        *(.bss)
        } > ram

        .stack :
        {
        *(.stack)
        _src_addr = .;
        } > ram
}
