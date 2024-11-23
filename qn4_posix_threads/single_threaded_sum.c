#include <stdio.h>
#include <stdlib.h>

int main() {
    int n;
    printf("Enter the value of n (200 < n <= 2000): ");
    scanf("%d", &n);

    if (n <= 200 || n > 20000000) {
        printf("Invalid value of n.\n");
        return -1;
    }

    int *array = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        array[i] = i + 1; // Fill array with 1 to n
    }

    long long sum = 0;
    for (int i = 0; i < n; i++) {
        sum += array[i];
    }

    printf("Single-threaded sum: %lld\n", sum);

    free(array);
    return 0;
}
