; TODO: Make this file load_idt.asm

global in_dx
global out_dx
global lidt

[bits 32]

; TODO: Move this somewhere else
in_dx:
    mov edx, [esp + 4]
    in al, dx
    ret

; TODO: Move this somewhere else
out_dx:
    mov edx, [esp + 4]
    mov al, [esp + 8]
    out dx, al
    ret

lidt:
    mov edx, [esp + 4]
    lidt [edx]
    sti
    ret
