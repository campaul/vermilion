#include "idt_init.h"
#include "io.h"
#include "keyboard.h"
#include "keyboard_map.h"

void keyboard_init(void) {
    idt_add(0x21, (unsigned long)keyboard_handler_entry, 0x8e);
    out_dx(0x21, 0xFD);
}

void keyboard_handler(void) {
    out_dx(0x20, 0x20);

    unsigned char keyboard_status = in_dx(KEYBOARD_STATUS_PORT);

    if (keyboard_status & 0x01) {
        char keycode = in_dx(KEYBOARD_DATA_PORT);
        if (keycode > 0 && keycode < 128) {
	    char string[2] = { keyboard_map[keycode], 0 };
            kprint(string);
        }
    }
}
