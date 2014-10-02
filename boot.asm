[org 0x7c00]

; Save boot drive
mov [BOOT_DRIVE], dl

; Move the stack
mov bp, 0x8000
mov sp, bp

; Load disk
mov bx, 0x9000
mov dh, 31
mov dl, [BOOT_DRIVE]
call disk_load

; Clear screen
mov ax, 02h
int 0x10

; Print loading message
mov bx, BOOT_MESSAGE
call print_string

; Jump to OS
jmp 0x9000

print_string:
    pusha
    .loop:
        mov al, [bx]
        cmp al, 0
        je .done
        mov ah, 0x0e
        int 0x10
        add bx, 1
        jmp .loop
    .done:
        popa
        ret

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

BOOT_DRIVE: db 0

BOOT_MESSAGE:
    db 'Loading Vermilion...', 0Dh, 0Ah, 0

times 510-($-$$) db 0
dw 0xaa55

jmp $

times 16384-($-$$) db 0
