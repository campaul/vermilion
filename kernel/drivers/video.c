#include "../io.h"
#include "video.h"

int width = 80;
int height = 10;

char *video_memory = (char*)0xb8000;
char *cursor = (char*)0xb8000;

int relative() {
    return (int)(cursor - video_memory) / 2;
}

int column() {
    return relative() % width;
}

int row() {
    return relative() / width;
}

void kprint(const char *string) {
    kprintc(string, 15);
}

void kprintc(const char *string, int color) {
    while(*string != 0) {
        *cursor++ = *string++;
        *cursor++ = color;
    }

    update_cursor();
}

void update_cursor() {
    unsigned int position = row() * width + column();
    outb(0x3D4, 0x0F);
    outb(0x3D5, (unsigned char)(position & 0xFF));
    outb(0x3D4, 0x0E);
    outb(0x3D5, (unsigned char )(position >> 8));
}
void kprintln(const char *string) {
    kprintlnc(string, 15);
}

void kprintlnc(const char *string, int color) {
    kprintc(string, color);
    line_break();
}

void line_break() {
    cursor += (width - column()) * 2;
    update_cursor();
}

void clear_screen() {
    cursor = video_memory;
    for (int i = 0; i < width * height; i++) {
        kprint(" ");
    }
    cursor = video_memory;
}
