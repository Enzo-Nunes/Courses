#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>

#define MAX 100

int moda() {

    int i, j, count = 0, prev_count = 0;
    char n; 
    int buffer[BUFSIZ];

    for (i = 0; (n = getchar) - '0' >= 0; i++) {
        buffer[i] = n - '0';
    }

    for (i = 0; i < sizeof(buffer); i++) {
        for (j = 0; j < MAX; j++) {
            if (buffer[j] = i) {
                count++;
            }
            if (count > prev_count) {
                prev_count = count;
            }
        }
    }

}