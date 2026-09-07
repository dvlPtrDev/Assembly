%include "src/open_flags.inc"

section .text
global open

; open(char *filename, int flags, int mode)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; filename = rdi; flags = rsi; mode = rdx
open:
    mov rax, 0x2

    ; If (!flag) { flag = O_RDONLY } 
    test rsi, rsi
    jz .set_default_flag

    ; if (O_CREATE in flags) { .creat() } 
    test rsi, O_CREAT
    jnz .creat

.run:

    syscall
    ret

.set_default_flag:
    mov rsi, O_RDONLY
    jmp .run

.creat:
    ; if (!mode)
    test rdx, rdx
    jnz .run


    ; if (!mode) { mode = 0664 }
    mov rdx, 0664
    jmp .run

