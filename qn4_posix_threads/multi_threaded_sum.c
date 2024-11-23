#include <stdio.h>
#include <pthread.h>
#include <stdlib.h>

#define CHUNK_SIZE 100

long long global_sum = 0; // Shared total
pthread_mutex_t lock;

typedef struct {
    int *array;
    int start;
    int end;
} ThreadData;

void* sum_subarray(void* arg) {
    ThreadData* data = (ThreadData*)arg;
    long long local_sum = 0;

    for (int i = data->start; i < data->end; i++) {
        local_sum += data->array[i];
    }

    pthread_mutex_lock(&lock);
    global_sum += local_sum;
    pthread_mutex_unlock(&lock);

    free(data);
    return NULL;
}

int main() {
    int n;
    printf("Enter the value of n (200 < n <= 2000): ");
    scanf("%d", &n);

    if (n <= 200 || n > 2000000) {
        printf("Invalid value of n.\n");
        return -1;
    }

    int *array = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        array[i] = i + 1; // Fill array with 1 to n
    }

    int num_threads = (n + CHUNK_SIZE - 1) / CHUNK_SIZE;
    pthread_t threads[num_threads];
    pthread_mutex_init(&lock, NULL);

    for (int i = 0; i < num_threads; i++) {
        ThreadData *data = (ThreadData*)malloc(sizeof(ThreadData));
        data->array = array;
        data->start = i * CHUNK_SIZE;
        data->end = (i + 1) * CHUNK_SIZE > n ? n : (i + 1) * CHUNK_SIZE;

        pthread_create(&threads[i], NULL, sum_subarray, data);
    }

    for (int i = 0; i < num_threads; i++) {
        pthread_join(threads[i], NULL);
    }

    printf("Multi-threaded sum: %lld\n", global_sum);

    pthread_mutex_destroy(&lock);
    free(array);
    return 0;
}
