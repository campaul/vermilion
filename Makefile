KERNEL_SOURCES = $(wildcard kernel/*.c)
KERNEL_OBJECTS = ${KERNEL_SOURCES:.c=.o}

all: vermilion.bin

kernel/%.o: kernel/%.c build
	gcc -ffreestanding -std=c99 -c $< -o $@

kernel/entry.o: kernel/entry.asm build
	nasm kernel/entry.asm -f elf -o kernel/entry.o

build:
	mkdir -p build

build/boot.bin: boot/boot.asm build
	nasm boot/boot.asm -f bin -o build/boot.bin

build/kernel.bin: kernel/entry.o ${KERNEL_OBJECTS}
	ld -o $@ -Ttext 0x1000 $^ --oformat binary

vermilion.bin: build/boot.bin build/kernel.bin
	cat build/boot.bin build/kernel.bin > vermilion.bin

.PHONY: run
run: vermilion.bin
	qemu-system-i386 -fda vermilion.bin

.PHONY: clean
clean:
	rm -rf build
	rm kernel/*.o
	rm vermilion.bin
