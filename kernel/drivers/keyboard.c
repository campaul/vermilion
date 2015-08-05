#include "../io.h"
#include "../idt.h"
#include "keyboard.h"
#include "keyboard_map.h"
#include "video.h"

#define KEYBOARD_DATA_PORT 0x60
#define KEYBOARD_STATUS_PORT 0x64

void keyboard_handler() {
    outb(0x20, 0x20);


    while(in(KEYBOARD_STATUS_PORT) & 0x02) {
    }
        unsigned char data = in(KEYBOARD_DATA_PORT);

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

void keyboard_init() {
    extern void _keyboard_handler();
    idt_add(0x21, (unsigned int)_keyboard_handler, 0x8e);
}
