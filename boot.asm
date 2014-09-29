[org 0x7c00]

mov bx, BOOT_MESSAGE
call print_string

jmp $

%include "io.asm"

BOOT_MESSAGE:
    db 'Loading Vermilion...', 0Dh, 0Ah, 0

times 510-($-$$) db 0
dw 0xaa55
