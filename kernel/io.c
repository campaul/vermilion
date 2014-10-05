#include "io.h"

int width = 80;
int height = 10;

volatile char *video_memory = (char*)0xb8000;
volatile char *cursor = (char*)0xb8000;

void kprint(const char *string) {
    kprintc(string, 15);
}

void kprintc(const char *string, int color) {

    int relative;
    int column;
    int row;

    while(*string != 0) {
        *cursor++ = *string++;
        *cursor++ = color;

        relative = (int)(cursor - video_memory) / 2;
        column = relative % width;
        row = relative / width;
    }

    // Insert newline
    cursor += (width - column) * 2;
 
}
