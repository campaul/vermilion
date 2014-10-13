#include "idt_init.h"
#include "io.h"
#include "keyboard.h"

// TODO: Make this kmain
void main() {
    kprintln("Loading Vermilion");

    // TODO: Move these somewhere else
    out_dx(0x20 , 0x11);
    out_dx(0xA0 , 0x11);
    out_dx(0x21 , 0x20);
    out_dx(0xA1 , 0x28);
    out_dx(0x21 , 0x00);
    out_dx(0xA1 , 0x00);
    out_dx(0x21 , 0x01);
    out_dx(0xA1 , 0x01);

    keyboard_init();

    idt_init();

    while(1);
}
