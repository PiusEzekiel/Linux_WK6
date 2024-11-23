# Qn1. Create a Shared Library

## Overview

The **String Manipulator Library** is a C-based library designed to perform basic text processing operations, such as sorting names and counting entries in a text file. This library can be used in various text-processing applications. It supports both static and dynamic linking, making it versatile for different use cases.

This project includes:
- The implementation of the **String Manipulator Library**.
- A test program to demonstrate the functionality of the library.

## Features

The library provides the following functions:
- **Sort Names**: Reads names (first name, last name) from a text file, sorts them in ascending order, and displays the sorted list.
- **Count Entries**: Counts the total number of lines (entries) in the text file and returns the count.

## Requirements

To use the library and run the test program, you need:
- **GCC**: GNU Compiler Collection
- A Linux-based system (or any system with `make`, `gcc`, and `readelf` support)

## Usage

1. **Run the Build Script**:  
   Execute the build and test automation script to compile, link, and test the program:
   ```bash
   ./build_and_test.sh
   ```

## How It Works

### **Script Workflow**

The `build_and_test.sh` script automates the following steps:

1. **Check Required Files**:  
   Ensures all necessary files (`string_manipulator.c` and `test.c`) exist before proceeding.

2. **Clean Up Old Build Artifacts**:  
   Removes old object files, static libraries, shared libraries, and executables to ensure a clean build.

3. **Compile Object File**:  
   Uses GCC to compile `string_manipulator.c` into an object file (`string_manipulator.o`).

4. **Create Static Library**:  
   Generates a static library (`libstring_manipulator.a`) using the compiled object file.

5. **Create Shared Library**:  
   Creates a shared library (`libstring_manipulator.so`) for dynamic linking.

6. **Compile Test Programs**:  
   - Links `test.c` with the static library to produce the `test1` executable.
   - Links `test.c` with the shared library to produce the `test2` executable.

7. **Run Test Programs**:  
   - Executes `test1` to validate the static library.
   - Executes `test2` to validate the shared library.

8. **Verify ELF Files**:  
   Uses `readelf` to confirm that the generated libraries and executables are valid ELF files.

---

## File Structure

- **Source Files**:
  - `string_manipulator.c`: Contains the library implementation with functions for sorting and counting names.
  - `test.c`: A test program that uses the library functions.

- **Generated Files**:
  - `string_manipulator.o`: Object file created from `string_manipulator.c`.
  - `libstring_manipulator.a`: Static library for linking.
  - `libstring_manipulator.so`: Shared library for dynamic linking.
  - `test1`: Executable linked with the static library.
  - `test2`: Executable linked with the shared library.

- **Script**:
  - `build_and_test.sh`: Automates the build, test, and verification process.

- **Sample Input**:
  - `names.txt`: Example input file containing names to test the library.