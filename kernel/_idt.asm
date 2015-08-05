[bits 32]

global idt_pointer
idt_pointer:
    dd 0
    dd 0

global load_idt
load_idt:
    lidt [idt_pointer]
    sti
    ret
