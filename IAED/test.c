#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main() {

	char *line_name;
	int i;

	if ((line_name = readNextWord(buffer)) == NULL) {
		listLines(sys);
	} else {
		if ((i = isLine(sys, line_name)) == NOT_FOUND) {
			createLine(sys, line_name);
		} else {
			listLineStops(sys->line_list[i], buffer);
		}
	}
	free(line_name);

	return 0;
}