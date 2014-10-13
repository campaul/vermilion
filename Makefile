KERNEL_SOURCES = $(wildcard kernel/*.c)
KERNEL_OBJECTS = $(patsubst kernel/%.c, build/%.o, $(KERNEL_SOURCES))

all: vermilion.bin

build/%.o: kernel/%.c build
	gcc -ffreestanding -std=c99 -m32 -c $< -o $@

build/entry.o: kernel/entry.asm build
	nasm kernel/entry.asm -f elf32 -o build/entry.o

build/kio.o: kernel/io.asm build
	nasm kernel/io.asm -f elf32 -o build/kio.o

build/idt.o: kernel/idt.asm build
	nasm kernel/idt.asm -f elf32 -o build/idt.o

build:
	mkdir -p build

build/boot.bin: boot/boot.asm build
	nasm boot/boot.asm -f bin -o build/boot.bin

build/kernel.bin: build/entry.o build/kio.o build/idt.o ${KERNEL_OBJECTS}
	ld -m elf_i386 -o $@ -Ttext 0x1000 $^ --oformat binary

vermilion.bin: build/boot.bin build/kernel.bin
	cat build/boot.bin build/kernel.bin > vermilion.bin

.PHONY: run
run: vermilion.bin
	qemu-system-i386 -fda vermilion.bin

.PHONY: clean
clean:
	rm -rf build
	rm vermilion.bin
