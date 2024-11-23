#!/bin/bash

# Script to automate building, compiling, and running the programs

echo -e "\n🛠️ \033[1;32mStarting Build and Test Process...\033[0m\n"



# Define file names
SOURCE_FILE="string_manipulator.c"
TEST_FILE="test.c"
STATIC_LIB="libstring_manipulator.a"
SHARED_LIB="libstring_manipulator.so"
TEST_EXEC_STATIC="test1"
TEST_EXEC_DYNAMIC="test2"

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
for FILE in "$SOURCE_FILE" "$TEST_FILE"; do
    if [ ! -f "$FILE" ]; then
        print_error "Required file '$FILE' is missing."
    else
        print_success "Found '$FILE'."
    fi
done

# Step 2: Clean up old files
print_header "Cleaning Up Old Files"
FILES_TO_CLEAN=("$STATIC_LIB" "$SHARED_LIB" "$TEST_EXEC_STATIC" "$TEST_EXEC_DYNAMIC" "*.o")
for FILE in "${FILES_TO_CLEAN[@]}"; do
    if [ -f $FILE ] || [ -d $FILE ]; then
        rm -rf $FILE && print_success "Removed '$FILE'."
    fi
done

# Step 3: Compile object file
print_header "Compiling Object File"
if gcc -c -fPIC "$SOURCE_FILE" -o string_manipulator.o; then
    print_success "Object file compiled successfully."
else
    print_error "Failed to compile object file."
fi

# Step 4: Create static library
print_header "Creating Static Library"
if ar rcs "$STATIC_LIB" string_manipulator.o; then
    print_success "Static library created successfully."
else
    print_error "Failed to create static library."
fi

# Step 5: Create shared library
print_header "Creating Shared Library"
if gcc -shared -o "$SHARED_LIB" string_manipulator.o; then
    print_success "Shared library created successfully."
else
    print_error "Failed to create shared library."
fi

# Step 6: Compile test program with static library
print_header "Compiling Test Program with Static Library"
if gcc "$TEST_FILE" -L. -lstring_manipulator -o "$TEST_EXEC_STATIC"; then
    print_success "Test program compiled successfully with static library."
else
    print_error "Failed to compile test program with static library."
fi

# Step 7: Compile test program with shared library
print_header "Compiling Test Program with Shared Library"
if gcc "$TEST_FILE" -L. -lstring_manipulator -o "$TEST_EXEC_DYNAMIC"; then
    print_success "Test program compiled successfully with shared library."
else
    print_error "Failed to compile test program with shared library."
fi

# Step 8: Run test program with static library
print_header "Running Test Program with Static Library"
if ./"$TEST_EXEC_STATIC"; then
    print_success "Test program executed successfully with static library."
else
    print_error "Test program execution failed with static library."
fi

# Step 9: Run test program with shared library
print_header "Running Test Program with Shared Library"
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:.
if ./"$TEST_EXEC_DYNAMIC"; then
    print_success "Test program executed successfully with shared library."
else
    print_error "Test program execution failed with shared library."
fi

# Step 10: Verify ELF files
print_header "Verifying ELF Files"
FILES_TO_VERIFY=("$TEST_EXEC_STATIC" "$TEST_EXEC_DYNAMIC" "$SHARED_LIB")
for FILE in "${FILES_TO_VERIFY[@]}"; do
    if [ -f "$FILE" ]; then
        readelf -h "$FILE"
        if [ $? -eq 0 ]; then
            print_success "'$FILE' is a valid ELF file."
        else
            print_error "'$FILE' is not a valid ELF file."
        fi
    else
        print_error "'$FILE' does not exist for verification."
    fi
done

# Final success message
print_header "Process Completed"
echo -e "\033[1;34m🎉 All steps were completed successfully! 🎉\033[0m\n"
