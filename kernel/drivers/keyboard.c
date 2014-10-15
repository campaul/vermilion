#include "../idt.h"
#include "video.h"

#define KEYBOARD_DATA_PORT 0x60
#define KEYBOARD_STATUS_PORT 0x64

void keyboard_handler() {
    outb(0x20, 0x20);

    unsigned int status = in(KEYBOARD_STATUS_PORT);
    unsigned char data = in(KEYBOARD_DATA_PORT);

    if(status & 0x01) {
        char string[2] = {data, 0};
        if (string[0] > 0 && string[0] < 128) {
            kprint(string);
        }
    }
}

void keyboard_init() {
    extern void _keyboard_handler();
    idt_add(0x21, _keyboard_handler, 0x8e);
}
