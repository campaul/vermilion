#include "idt.h"
#include "syscall.h"

void syscall_handler() {
}

void syscall_init() {
    extern void _syscall_handler();
    idt_add(0x80, (unsigned int)_syscall_handler, 0x8e);
}
