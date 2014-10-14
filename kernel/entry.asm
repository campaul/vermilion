MULTIBOOT_MAGIC equ  0x1BADB002
MULTIBOOT_FLAGS equ  1<<0 | 1<<1
MULTIBOOT_CHECKSUM equ -(MULTIBOOT_MAGIC + MULTIBOOT_FLAGS)
 
align 4
dd MULTIBOOT_MAGIC
dd MULTIBOOT_FLAGS
dd MULTIBOOT_CHECKSUM
 
global kernel_entry
kernel_entry:
	mov esp, 0x9000
 
	extern kmain
	call kmain
 
	hlt
