#include "video.h"

int width = 80;
int height = 10;

volatile char *video_memory = (char*)0xb8000;
volatile char *cursor = (char*)0xb8000;

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
}
void kprintln(const char *string) {
    kprintlnc(string, 15);
}

void kprintlnc(const char *string, int color) {
    kprintc(string, color);

    // Insert newline
    cursor += (width - column()) * 2;
}
