#include <stdio.h>

// Function prototypes from the library
void sort_names(const char *filename);
int count_entries(const char *filename);

int main() {
    const char *filename = "names.txt";

    // Test sorting names
    sort_names(filename);

    // Test counting entries
    int count = count_entries(filename);
    printf("Total entries counted: %d\n", count);

    return 0;
}
