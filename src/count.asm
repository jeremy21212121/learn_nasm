; Hello World: Print numbers 1-10
; Compile: nasm -f elf count.asm
; Link: ld -m elf_i386 helloworld-10.o -o count
; Run: ./count

%include      'src/functions.asm'

SECTION .text
global  _start

_start:

    mov   ecx, 0      ; initialize to 0

nextNumber:
    inc   ecx         ; increment ecx
    mov   eax, ecx    ; move the address of our integer into eax
    call  iprintLF

    cmp   ecx, 13     ; check if we have reached 10
    jne   nextNumber  ; loop if we haven't
    
    jmp   quit
