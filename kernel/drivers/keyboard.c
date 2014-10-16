#include "../io.h"
#include "../idt.h"
#include "keyboard.h"
#include "video.h"

#define KEYBOARD_DATA_PORT 0x60
#define KEYBOARD_STATUS_PORT 0x64

void keyboard_handler() {
    outb(0x20, 0x20);

    unsigned int status = in(KEYBOARD_STATUS_PORT);
    unsigned char data = in(KEYBOARD_DATA_PORT);

    if(status & 0x01) {
        if (data > 0 && data < 128) {
            char key = keyboard_map[data];
            if (key == '\n') {
                line_break();
            } else {
                char string[] = { key, 0 };
                kprint(string);
            }
        }
    }
}

void keyboard_init() {
    extern void _keyboard_handler();
    idt_add(0x21, (unsigned int)_keyboard_handler, 0x8e);
}

char keyboard_map[] = {
    0x0, '~', '1', '2', '3', '4', '5', '6',
    '7', '8', '9', '0', '-', '=', 0x0, 0x0,
    'q', 'w', 'e', 'r', 't', 'y', 'u', 'i',
    'o', 'p', '[', ']', '\n',0x0, 'a', 's',

    'd', 'f', 'g', 'h', 'j', 'k', 'l', ';',
    '\'','`', 0x0, '\\','z', 'x', 'c', 'v',
    'b', 'n', 'm', ',', '.', '/', 0x0, 0x0,
    0x0, ' ', 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,

    0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
    0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
    0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
    0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,

    0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
    0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
    0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
    0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
};
