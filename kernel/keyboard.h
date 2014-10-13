#define KEYBOARD_STATUS_PORT 0x64
#define KEYBOARD_DATA_PORT 0x60

extern void keyboard_handler_entry(void);

void keyboard_init(void);
void keyboard_handler(void);
