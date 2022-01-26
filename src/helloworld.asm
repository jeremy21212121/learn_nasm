; My first assembly program

%include    'src/functions.asm'

SECTION .data
prompt: db    'Please enter your name: ', 0h
greet:  db    'Hello, ', 0h
eMark:  db    '!', 0h

SECTION .bss
uInput:   resb    255 ; reserve 255 bytes in memory for storing user input

SECTION .text
global  _start

_start:

    mov   eax, prompt
    call  sprint      ; print user input prompt

    mov   edx, 255    ; SYS_READ(3) [ eax=kernel opcode, ebx=stdin, ecx=buffer address, edx=bytes to read ]
    mov   ecx, uInput ; buffer for user input
    mov   ebx, 0      ; STDIN
    mov   eax, 3      ; SYS_READ
    int   80h

    mov   eax, greet
    call  sprint      ; print the beginning of greeting
    
    mov   eax, uInput
    call  sprint      ; print user input

    jmp  quit
