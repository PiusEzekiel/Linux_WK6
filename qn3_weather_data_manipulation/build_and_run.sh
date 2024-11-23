#!/bin/bash

# Script to automate building, compiling, and running the programs

echo -e "\n🛠️ \033[1;32mStarting Build and Test Process...\033[0m\n"


# Define file names and directories
C_FILE="weather_analysis.c"
SETUP_FILE="setup.py"
PYTHON_SCRIPT="main.py"
BUILD_DIR="build"
DATASET_FILE="weather.csv"

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
for FILE in "$C_FILE" "$SETUP_FILE" "$PYTHON_SCRIPT" "$DATASET_FILE"; do
    if [ ! -f "$FILE" ]; then
        print_error "Required file '$FILE' is missing."
    else
        print_success "Found '$FILE'."
    fi
done

# Step 2: Clean up existing build directory
print_header "Cleaning Build Directory"
if [ -d "$BUILD_DIR" ]; then
    rm -rf "$BUILD_DIR" && print_success "Removed existing build directory."
else
    print_success "No existing build directory found."
fi

# Step 3: Compile the C extension
print_header "Compiling the C Extension"
if python3 "$SETUP_FILE" build; then
    print_success "C extension compiled successfully."
else
    print_error "Error during compilation."
fi

# Step 4: Move the compiled .so file
print_header "Moving Compiled Shared Object (.so) File"
COMPILED_SO=$(find "$BUILD_DIR" -name "*.so" 2>/dev/null)
if [ -n "$COMPILED_SO" ]; then
    cp "$COMPILED_SO" . && print_success "Moved compiled .so file to the current directory."
else
    print_error "Compiled .so file not found."
fi

# Step 5: Run the Python script
print_header "Running the Python Script"
if python3 "$PYTHON_SCRIPT"; then
    print_success "Python script executed successfully."
else
    print_error "Error during Python script execution."
fi

# Final success message
print_header "Process Completed"
echo -e "\033[1;34m🎉 All steps were completed successfully!🎉\033[0m\n"
