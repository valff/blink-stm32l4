MEMORY
{
    FLASH (RX) : ORIGIN = 0x08000000, LENGTH = 1M
    SRAM1 (WX) : ORIGIN = 0x20000000, LENGTH = 256K
    SRAM2 (WX) : ORIGIN = 0x10000000, LENGTH = 64K
}

SECTIONS
{
    .vtable ORIGIN(FLASH) :
    {
        LONG(ORIGIN(SRAM2) + LENGTH(SRAM2));
        KEEP(*(.rodata.VTABLE));
    } > FLASH

    .text :
    {
        *(.text.*);
    } > FLASH

    .rodata : ALIGN(4)
    {
        *(.rodata.*);
    } > FLASH

    .bss : ALIGN(4)
    {
        BSS_START = .;
        *(.bss.*);
        BSS_END = ALIGN(4);
    } > SRAM2

    .data : ALIGN(4)
    {
        DATA_START = .;
        *(.data.*);
        DATA_END = ALIGN(4);
    } > SRAM2 AT > FLASH
    DATA_CONST = LOADADDR(.data);

    .heap : ALIGN(4)
    {
        HEAP_START = .;
        . += 0x40000;
    } > SRAM1

    /DISCARD/ :
    {
        *(.ARM.*)
    }
}
