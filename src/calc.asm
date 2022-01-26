; Addition

%include      'src/functions.asm'

SECTION .text
global _start

_start:

    mov     eax, 42
    mov     ebx, 7
    add     eax, ebx
    call    iprintLF
    
    call quit
