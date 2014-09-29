all: boot

boot: boot.asm
	nasm boot.asm -f bin -o vermilion.bin

run: boot
	qemu-system-i386 vermilion.bin
