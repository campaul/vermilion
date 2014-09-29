_print_char:
    mov ah, 0x0e
    int 0x10
    ret

print_char:
    pusha
    call _print_char
    popa
    ret

print_string:
    pusha
    .loop:
        mov al, [bx]
        cmp al, 0
        je .done 
        call _print_char
        add bx, 1
        jmp .loop
    .done:
        popa
        ret
