all: vermilion.bin

build/boot.bin: boot/boot.asm
	nasm boot/boot.asm -f bin -o build/boot.bin

build/kernel.bin: kernel/kernel.c kernel/entry.asm
	gcc -ffreestanding -c kernel/kernel.c -o build/kernel.o
	nasm kernel/entry.asm -f elf -o build/entry.o
	ld -o build/kernel.bin -Ttext 0x1000 build/entry.o build/kernel.o --oformat binary

vermilion.bin: build/boot.bin build/kernel.bin
	cat build/boot.bin build/kernel.bin > vermilion.bin

.PHONY: run
run: vermilion.bin
	qemu-system-i386 -fda vermilion.bin
