[bits 32]

global in
in:
    mov dx, [esp + 4]
    in ax, dx
    ret

global outb
outb:
    mov dx, [esp + 4]
    mov al, [esp + 8]
    out dx, al
    ret
