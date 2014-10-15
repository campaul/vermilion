#include "idt.h"

#define IDT_SIZE 256

extern unsigned long idt_pointer;

struct idt_entry {
    unsigned short int address_low;
    unsigned short int selector;
    unsigned char zero;
    unsigned char gate;
    unsigned short int address_high;
};

struct idt_entry idt[IDT_SIZE];

void idt_add(int index, int address, int gate) {
    idt[index].address_low = address & 0xffff;
    idt[index].selector = 0x10;
    idt[index].zero = 0;
    idt[index].gate = gate;
    idt[index].address_high = address >> 16;
}

void idt_init() {
    idt_pointer = (sizeof (struct idt_entry) * IDT_SIZE) + ((unsigned long)idt << 16);
    load_idt();
}
