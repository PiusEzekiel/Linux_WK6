#!/bin/bash

# Script to automate building, compiling, and running the C program and assembly

echo -e "\n🛠️ \033[1;32mStarting Build and Test Process...\033[0m\n"

# Define file names
C_FILE="calculator.c"
ASSEMBLY_FILE="calculator.s"
OBJECT_FILE="calculator.o"
EXECUTABLE="calculator"

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

# Step 1: Check for required files
print_header "Checking Required Files"
if [ ! -f "$C_FILE" ]; then
    print_error "Required file '$C_FILE' is missing."
else
    print_success "Found '$C_FILE'."
fi

# Step 2: Generate Assembly Code
print_header "Generating Assembly Code from C"
if gcc -S "$C_FILE" -o "$ASSEMBLY_FILE"; then
    print_success "Generated assembly code: $ASSEMBLY_FILE"
else
    print_error "Failed to generate assembly code."
fi

# Step 3: Assemble the Assembly Code
print_header "Assembling the Assembly Code"
if as "$ASSEMBLY_FILE" -o "$OBJECT_FILE"; then
    print_success "Assembled to object file: $OBJECT_FILE"
else
    print_error "Failed to assemble the assembly code."
fi

# Step 4: Link the Object File to Create Executable
print_header "Linking Object File"
if gcc "$OBJECT_FILE" -o "$EXECUTABLE"; then
    print_success "Linked successfully. Executable: $EXECUTABLE"
else
    print_error "Failed to link object file."
fi

# Step 5: Run the Executable
print_header "Running the Executable"
if ./"$EXECUTABLE"; then
    print_success "Executable ran successfully."
else
    print_error "Error while running the executable."
fi

# Final success message
print_header "Process Completed"
echo -e "\033[1;34m🎉 All steps were completed successfully!🎉\033[0m\n"
