#include "idt_init.h"
#include "keyboard.h"

#define IDT_SIZE 256

struct idt_entry {
    unsigned short int offset_low;
    unsigned short int selector;
    unsigned char zero;
    unsigned char flags;
    unsigned short int offset_high;
};

struct idt_entry idt[IDT_SIZE];
unsigned long idt_pointer;

void idt_init(void) {
    idt_pointer = (sizeof (struct idt_entry) * IDT_SIZE) + ((unsigned int)idt << 16);
    lidt(&idt_pointer);
}

void idt_add(unsigned char entry, unsigned long address, unsigned char flags) {
    idt[entry].offset_low = address & 0xffff;
    idt[entry].selector = 0x08;
    idt[entry].zero = 0;
    idt[entry].flags = flags;
    idt[entry].offset_high = (address & 0xffff0000) >> 16;
}
