KERNEL_SOURCES = $(wildcard kernel/*.c)
KERNEL_OBJECTS = $(patsubst kernel/%.c, build/%.o, $(KERNEL_SOURCES))

all: vermilion.iso

build/%.o: kernel/%.c
	mkdir -p build
	gcc -ffreestanding -std=c99 -m32 -c $< -o $@

build/entry.o: kernel/entry.asm
	mkdir -p build
	nasm kernel/entry.asm -f elf32 -o build/entry.o

iso/boot/vermilion.bin: build/entry.o ${KERNEL_OBJECTS}
	ld --script linker.ld -o $@ $^

vermilion.iso: iso/boot/vermilion.bin
	grub-mkrescue -o vermilion.iso iso

.PHONY: run
run: vermilion.iso
	qemu-system-i386 -cdrom vermilion.iso

.PHONY: clean
clean:
	rm -rf build iso/boot/vermilion.bin vermilion.iso
