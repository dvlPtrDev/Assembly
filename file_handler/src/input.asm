section .bss
    buffer      resb 256     

section .text
global          print
global          get_input

; print(char *msg (terminada em \0))
; msg = rdi
print:
    mov         rsi, rdi ; Passa o primeiro argumento (msg) para rsi antes de sobrescreve-lo
    call        .get_msg_len 

    ; Write Syscall
    mov         rax, 0x1
    mov         rdi, 0x1
    syscall ; Rax recebe a quantidade de bytes lidos

    ret

.get_msg_len:
    mov           rcx, 0
    .loop:
        cmp       byte [rsi + rcx], 0
        je        .done

        inc       rcx
        jmp       .loop

.done:
    mov           rdx, rcx
    ret


get_input:
    mov           rax, 0x0
    mov           rdi, 0x0
    lea           rsi, [rel buffer]
    mov           rdx, 255
    syscall

    mov           byte [rsi + rax - 1], 0 ; Coloca o nul terminator
    lea           rax, [rel buffer] 
    ret ; Retorna rax
    
