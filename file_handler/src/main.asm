%include "src/open_flags.inc"
%include "src/constants.inc"


section .bss
    file_name       resq 1

section .text
    global       _start
    extern       print
    extern       get_input
    extern       open

_start: 
    lea          rdi, [rel INPUT_MSG]
    call         print

    call         get_input
    mov          [rel file_name], rax ; file_name aponta pra uma str
    
    mov          rdi, [rel file_name]
    call         print

    mov          rdi, [rel file_name]
    mov          rsi, O_CREAT
    mov          rdx, 0644o
    call         open

    mov          rax, 0x3c
    mov          rdi, 0x0
    syscall ; encerramento do processo


section .data
    INPUT_MSG        db "Enter file name: ", 0
    ; INPUT_LEN      equ $ - INPUT_MSG

