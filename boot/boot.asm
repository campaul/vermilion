[org 0x7c00]
KERNEL_OFFSET equ 0x1000

; Save boot drive
mov [BOOT_DRIVE], dl

; Move the stack
mov bp, 0x9000
mov sp, bp

; Clear screen
mov ax, 02h
int 0x10

; Load the kernel
call load_kernel

; Enter 32-bit Protected Mode
call enter_protected_mode

%include "boot/disk.asm"
%include "boot/gdt.asm"
%include "boot/protected_mode.asm"


[bits 16]
load_kernel:
    mov bx, KERNEL_OFFSET
    mov dh, 15
    mov dl, [BOOT_DRIVE]
    call disk_load
    ret


[bits 32]
start_kernel:
    cli
    call KERNEL_OFFSET
    hlt


BOOT_DRIVE: db 0

times 510-($-$$) db 0
dw 0xaa55
