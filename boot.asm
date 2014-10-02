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

; Jump to OS
jmp 0x9000

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

times 510-($-$$) db 0
dw 0xaa55

; Print loading message
mov bx, BOOT_MESSAGE
add bx, 0x1200
call print_string

jmp $

%include "io.asm"

BOOT_MESSAGE:
    db 'Loading Vermilion...', 0Dh, 0Ah, 0

times 16384-($-$$) db 0
