; Prints each argument followed by a linefeed

%include    'src/functions.asm'

;~ SECTION .data
;~ msg1: db    'Bonjour, le monde!', 0h
;~ msg2: db    'Hello, world!', 0h

SECTION .text
global  _start

_start:

    pop   ecx         ; first value on the stack is # of args
                      ; next arg is filename, we don't care about that
    dec   ecx         ; decrement ecx to ignore filename arg
    add   esp, 4      ; add 4 to the stack pointer (32bit) to get rid of the filename arg

nextArg:
    cmp   ecx, 0h     ; check for remaining args
    jz    noMoreArgs  ; if zero flag is set, we are done looping
    pop   eax         ; pop next arg off stack
    call  sprintLF    ; print arg
    dec   ecx         ; decrement arg counter
    jmp   nextArg     ; start loop over again

noMoreArgs:
    call  quit
