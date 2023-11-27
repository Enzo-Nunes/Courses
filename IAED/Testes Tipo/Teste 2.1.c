#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>

double expo(double x, int n) {

    double result = 1;
    int i;

    for (i = 0; i < n; i++) {
        result *= x;
    }

    return result;
}

double polyval(double pol[], int size, double x) {

    double result = 0;
    int i;

    for (i = 0; i < size; i++) {
        result += pol[i] * expo(x, i);
    }
}