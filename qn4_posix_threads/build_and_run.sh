#!/bin/bash

# Script to automate building, compiling, and running the programs

echo -e "\n🛠️ \033[1;32mStarting Build and Test Process...\033[0m\n"

# Define file names and directories
SOURCE_FILES=("single_threaded_sum.c" "multi_threaded_sum.c")
EXECUTABLES=("single_threaded_sum" "multi_threaded_sum")
BUILD_DIR="build"

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

# Step 1: Check for required source files
print_header "Checking Required Files"
for FILE in "${SOURCE_FILES[@]}"; do
    if [ ! -f "$FILE" ]; then
        print_error "Required source file '$FILE' is missing."
    else
        print_success "Found '$FILE'."
    fi
done

# Step 2: Create or clean the build directory
print_header "Preparing Build Directory"
if [ -d "$BUILD_DIR" ]; then
    rm -rf "$BUILD_DIR" && print_success "Removed existing build directory."
fi
mkdir "$BUILD_DIR" && print_success "Build directory created."

# Step 3: Compile the C programs
print_header "Compiling Programs"
for ((i=0; i<${#SOURCE_FILES[@]}; i++)); do
    SOURCE_FILE=${SOURCE_FILES[$i]}
    EXECUTABLE_FILE="$BUILD_DIR/${EXECUTABLES[$i]}"

    echo -e "\n🔨 Compiling $SOURCE_FILE..."
    if gcc -o "$EXECUTABLE_FILE" "$SOURCE_FILE" -lpthread; then
        print_success "Compiled '$SOURCE_FILE' to '$EXECUTABLE_FILE'."
    else
        print_error "Error compiling '$SOURCE_FILE'."
    fi
done

# Step 4: Run the executables
print_header "Running Programs"
for EXECUTABLE in "${EXECUTABLES[@]}"; do
    EXEC_PATH="$BUILD_DIR/$EXECUTABLE"
    echo -e "\n🚀 Running $EXECUTABLE..."
    if [ -x "$EXEC_PATH" ]; then
        if "$EXEC_PATH" <<< 400; then
            print_success "'$EXECUTABLE' executed successfully."
        else
            print_error "Error executing '$EXECUTABLE'."
        fi
    else
        print_error "'$EXECUTABLE' is not executable."
    fi
done

# Final success message
print_header "Process Completed"
echo -e "\033[1;34m🎉 All steps were completed successfully!🎉\033[0m\n"
