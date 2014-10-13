global keyboard_handler_entry

[bits 32]

extern keyboard_handler

keyboard_handler_entry:
    call keyboard_handler
    iretd
