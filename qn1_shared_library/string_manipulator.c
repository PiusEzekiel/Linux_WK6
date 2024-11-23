#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Maximum length for a name
#define MAX_NAME_LEN 100
#define MAX_ENTRIES 1000

// Function to sort names
void sort_names(const char *filename) {
    char names[MAX_ENTRIES][MAX_NAME_LEN];
    int count = 0;

    FILE *file = fopen(filename, "r");
    if (!file) {
        perror("Error opening file");
        return;
    }

    while (fgets(names[count], MAX_NAME_LEN, file) && count < MAX_ENTRIES) {
        // Remove trailing newline
        names[count][strcspn(names[count], "\n")] = '\0';
        count++;
    }
    fclose(file);

    // Sort names
    for (int i = 0; i < count - 1; i++) {
        for (int j = i + 1; j < count; j++) {
            if (strcmp(names[i], names[j]) > 0) {
                char temp[MAX_NAME_LEN];
                strcpy(temp, names[i]);
                strcpy(names[i], names[j]);
                strcpy(names[j], temp);
            }
        }
    }

    printf("Sorted Names:\n");
    for (int i = 0; i < count; i++) {
        printf("%s\n", names[i]);
    }
}

// Function to count entries
int count_entries(const char *filename) {
    int count = 0;
    char buffer[MAX_NAME_LEN];

    FILE *file = fopen(filename, "r");
    if (!file) {
        perror("Error opening file");
        return -1;
    }

    while (fgets(buffer, MAX_NAME_LEN, file)) {
        count++;
    }
    fclose(file);

    printf("Number of entries: %d\n", count);
    return count;
}
