[org 0x7c00]

; Save boot drive
mov [BOOT_DRIVE], dl

; Move the stack
mov bp, 0x9000
mov sp, bp

; Clear screen
mov ax, 02h
int 0x10

; Enter 32-bit Protected Mode
call enter_protected_mode

%include "gdt.asm"
%include "print.asm"
%include "protected_mode.asm"


[bits 32]
main:
    mov ebx, BOOT_MESSAGE
    call print_string

    jmp $


BOOT_DRIVE: db 0
BOOT_MESSAGE: db 'Loading Vermilion...', 0

times 510-($-$$) db 0
dw 0xaa55
