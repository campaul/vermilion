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

    extern kmain
    call kmain

    hlt
