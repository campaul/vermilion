#include "drivers/keyboard.h"
#include "drivers/video.h"
#include "idt.h"
#include "irq.h"

void kmain() {
    kprintln("Loading Vermilion");

    idt_init();
    keyboard_init();
    irq_init();   
 
    while(1);
}
