all: boot

boot: boot/boot.asm
	nasm boot/boot.asm -f bin -o vermilion.bin

run: boot
	qemu-system-i386 -fda vermilion.bin
