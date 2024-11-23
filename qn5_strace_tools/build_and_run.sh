#!/bin/bash

# Script to automate building, compiling, and running the programs

echo -e "\n🛠️ \033[1;32mStarting Build, Compile, and Run Process...\033[0m\n"

# Define file names
C_FILE="fork_exec.c"
EXECUTABLE="fork_exec"
LOG_FILE="trace.log"

# Styled output functions
print_header() {
    echo -e "\n\033[1;34m===== $1 =====\033[0m\n"
}

print_success() {
    echo -e "\033[1;32m✔ $1\033[0m"
}

print_error() {
    echo -e "\033[1;31m✘ $1\033[0m"
    exit 1
}

# Step 1: Check for the C source file
print_header "Checking Required Files"
if [ ! -f "$C_FILE" ]; then
    print_error "Required C file '$C_FILE' is missing."
else
    print_success "Found '$C_FILE'."
fi

# Step 2: Clean up existing executable and log files
print_header "Cleaning Up Previous Builds"
if [ -f "$EXECUTABLE" ]; then
    rm -f "$EXECUTABLE" && print_success "Removed existing executable."
else
    print_success "No existing executable found."
fi

if [ -f "$LOG_FILE" ]; then
    rm -f "$LOG_FILE" && print_success "Removed existing log file."
else
    print_success "No existing log file found."
fi

# Step 3: Compile the C program
print_header "Compiling the C Program"
if gcc -o "$EXECUTABLE" "$C_FILE"; then
    print_success "Compilation successful."
else
    print_error "Error during compilation."
fi

# Step 4: Run the program with strace
print_header "Running the Program with Strace"
if strace -f -o "$LOG_FILE" ./"$EXECUTABLE"; then
    print_success "Program executed successfully with strace."
else
    print_error "Error during program execution."
fi

# Step 5: Display strace output location
print_header "Strace Log File"
if [ -f "$LOG_FILE" ]; then
    print_success "Strace log saved to '$LOG_FILE'."
else
    print_error "Failed to create strace log."
fi

# Final success message
print_header "Process Completed"
echo -e "\033[1;34m🎉 All steps were completed successfully!🎉\033[0m\n"
