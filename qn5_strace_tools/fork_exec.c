#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h> // Add this header for wait()

int main() {
    pid_t pid;

    // Create a child process
    pid = fork();

    if (pid < 0) {
        perror("Fork failed");
        exit(EXIT_FAILURE);
    } else if (pid == 0) {
        // Child process
        printf("Child process created with PID: %d\n", getpid());
        char *args[] = {"/bin/ls", NULL};  // Replace this with your program
        execvp(args[0], args);            // Execute /bin/ls
        perror("Exec failed");            // If exec fails
        exit(EXIT_FAILURE);
    } else {
        // Parent process
        printf("Parent process with PID: %d\n", getpid());
        wait(NULL); // Wait for child to complete
        printf("Child process completed.\n");
    }

    return 0;
}
