KERNEL_OBJECTS = $(build/_entry.o)

KERNEL_ASM_SOURCES = $(wildcard kernel/*.asm)
KERNEL_ASM_SOURCES += $(wildcard kernel/*/*.asm)
KERNEL_OBJECTS += $(patsubst kernel/%.asm, build/%.o, $(KERNEL_ASM_SOURCES))

KERNEL_C_SOURCES = $(wildcard kernel/*.c)
KERNEL_C_SOURCES += $(wildcard kernel/*/*.c)
KERNEL_OBJECTS += $(patsubst kernel/%.c, build/%.o, $(KERNEL_C_SOURCES))

all: vermilion.iso

build/%.o: kernel/%.c
	mkdir -p build
	mkdir -p build/drivers
	gcc -ffreestanding -std=c99 -m32 -Wall -Werror -c $< -o $@

build/%.o: kernel/%.asm
	mkdir -p build
	mkdir -p build/drivers
	nasm $^ -f elf32 -o $@

iso/boot/vermilion.bin: ${KERNEL_OBJECTS}
	ld --script linker.ld -o $@ $^

vermilion.iso: iso/boot/vermilion.bin
	grub-mkrescue -o vermilion.iso iso

.PHONY: run
run: vermilion.iso
	qemu-system-i386 -cdrom vermilion.iso

.PHONY: clean
clean:
	rm -rf build iso/boot/vermilion.bin vermilion.iso
