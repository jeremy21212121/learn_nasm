; Addition

%include      'src/functions.asm'

SECTION .text
global _start

_start:

    mov     eax, 4294967295
    mov     ebx, -2
    add     eax, ebx
    call    iprintLF
    
    call quit
