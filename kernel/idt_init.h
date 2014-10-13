extern int in_dx(int x);
extern void out_dx(int x, int y);
extern void lidt(long x);

void idt_init(void);
void idt_add(unsigned char entry, unsigned long address, unsigned char flags);
