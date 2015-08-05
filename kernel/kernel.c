#include "drivers/keyboard.h"
#include "drivers/video.h"
#include "idt.h"
#include "irq.h"
#include "syscall.h"

extern void halt();

void kmain() {
    clear_screen();
    kprintln("Loading Vermilion");

    idt_init();
    syscall_init();
    keyboard_init();
    irq_init();

    while(1) {
        halt();
    }
}
