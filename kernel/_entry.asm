[bits 32]
MULTIBOOT_MAGIC equ  0x1BADB002
MULTIBOOT_FLAGS equ  1<<0 | 1<<1
MULTIBOOT_CHECKSUM equ -(MULTIBOOT_MAGIC + MULTIBOOT_FLAGS)

MULTIBOOT_VIDEO_MODE equ 0
MULTIBOOT_VIDEO_WIDTH equ 640
MULTIBOOT_VIDEO_HEIGHT equ 480
MULTIBOOT_VIDEO_DEPTH equ 8

align 4
dd MULTIBOOT_MAGIC
dd MULTIBOOT_FLAGS
dd MULTIBOOT_CHECKSUM
dd 0
dd 0
dd 0
dd 0
dd 0
dd MULTIBOOT_VIDEO_MODE
dd MULTIBOOT_VIDEO_WIDTH
dd MULTIBOOT_VIDEO_HEIGHT
dd MULTIBOOT_VIDEO_DEPTH

global kernel_entry
kernel_entry:
    mov esp, 0x9000

    mov eax, gdt_start
    mov [gdtr + 2], eax
    mov ax, gdt_end - gdt_start
    mov [gdtr], ax
    lgdt [gdtr]
    jmp 0x08:flush

    flush:
        mov ax, 0x10
        mov ds, ax
        mov es, ax
        mov fs, ax
        mov gs, ax
        mov ss, ax

    extern kmain
    call kmain

    hlt

    gdtr:
        dw 0x0
        dd 0x0

    gdt_start:
        ; NULL Segment
        dq 0x0

        ; Code Segment
        dw 0xffff
        dw 0x0
        db 0x0
        db 10011010b
        db 11001111b
        db 0x0

        ; Data Segment
        dw 0xffff
        dw 0x0
        db 0x0
        db 10010010b
        db 11001111b
        db 0x0
    gdt_end:
