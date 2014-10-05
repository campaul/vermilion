disk_load:
    push dx
    mov ah, 0x02
    mov al, dh
    mov ch, 0x00
    mov dh, 0x00
    mov cl, 0x02 ; Second sector
    int 0x13
    jc $
    pop dx
    cmp dh, al
    jne $
    ret
