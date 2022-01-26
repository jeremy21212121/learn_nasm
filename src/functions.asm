;------------------------------------------
; void iprint(Integer number)
; Integer printing function (itoa)
iprint:
    push    eax             ; preserve eax on the stack to be restored after function runs
    push    ecx             ; preserve ecx on the stack to be restored after function runs
    push    edx             ; preserve edx on the stack to be restored after function runs
    push    esi             ; preserve esi on the stack to be restored after function runs
    mov     ecx, 0          ; counter of how many bytes we need to print in the end

divideLoop:
    inc     ecx             ; count each byte to print
    mov     edx, 0          ; empty edx, it will hold remainder
    mov     esi, 10         ; divisor for idiv
    idiv    esi             ; divide eax by esi: eax=quotient, edx=remainder
    add     edx, 48         ; convert remainder to ascii code
    push    edx             ; push ascii code for later printing
    cmp     eax, 0          ; compare the quotient with zero to see if integer can be divided anymore
    jnz     divideLoop      ; keep dividing if the quotient isn't zero

printLoop:
    dec     ecx             ; decrement bytes to print counter
    mov     eax, esp        ; put the stack pointer into eax for printing
    call    sprint          ; print our numeric ascii char
    pop     eax             ; remove last char off the stack to move esp forward
    cmp     ecx, 0          ; check the byte counter to see if we have printed all the chars
    jnz     printLoop       ; keep printing if the counter isn't 0

    pop     esi             ; restore esi
    pop     edx             ; restore edx
    pop     ecx             ; restore ecx
    pop     eax             ; restore eax
    ret

;-------------------------------------
; void iprintLF(Integer number)
; itoa with linefeed
iprintLF:
    call    iprint

    push    eax             ; preserve to be restored later
    mov     eax, 0Ah        ; put ascii LF into eax
    push    eax             ; push onto stack so we can get the address
    mov     eax, esp        ; stack pointer into eax so we can print our LF
    call    sprint
    pop     eax             ; remove LF from stack
    pop     eax             ; restore previous value
    ret

;------------------
; int slen(String message)
; String length calculation function using pointer math
slen:
    push    ebx
    mov     ebx, eax ; starting address of string

nextchar:
    cmp   byte [eax], 0 ; compare the byte at eax with 0
    jz    finished ; jmp to finished if the zero flag was set by the previous line
    inc   eax ; zero flag wasn't set, increment eax
    jmp   nextchar ; start the loop over again

finished:
    sub   eax, ebx ; the difference between eax/ebx is the length in bytes
    pop   ebx
    ret

;----------------------
; void sprint(String message)
; String printing function
;   SYS_WRITE(eax=4)[ edx: length, ecx: address of string, ebx: output file ]
sprint:
    push    edx
    push    ecx
    push    ebx
    push    eax ; address of string
    call    slen

    mov   edx, eax ; store result of slen in edx to be used by SYS_WRITE
    pop   eax ; restore address of string

    mov   ecx, eax ; move string address into ecx to be used by SYS_WRITE
    mov   ebx, 1 ; stdout
    mov   eax, 4 ; SYS_WRITE kernel opcode 4
    int   80h

    pop   ebx
    pop   ecx
    pop   edx
    ret

;----------------------
; void sprintLF(String message)
; String printing function with a newline
;
sprintLF:
    call  sprint    ; print the string

    push  eax       ; push string address onto stack so we can restore it after
    mov   eax, 0Ah  ; put a linefeed character into eax
    push  eax       ; put the linefeed onto the stack so we can get the address
    mov   eax, esp  ; put the current stack pointer address into eax for sprint
    call  sprint    ; print the linefeed character
    pop   eax       ; remove linefeed from the stack
    pop   eax       ; restore original value (address of string)
    ret

;---------------------------
; void exit()
; Exit program and restore resources
quit:
    mov   ebx, 0 ; exit code 0, no errors
    mov   eax, 1 ; SYS_EXIT kernel opcode 1
    int   80h
    ret
