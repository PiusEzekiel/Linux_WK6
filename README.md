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

## Installation

1. **Clone or Download the Project**:  
   Clone the repository or copy the project files to your system.

2. **Prepare the Environment**:  
   Ensure GCC and related build tools are installed. For Debian-based systems:
   ```bash
   sudo apt-get update
   sudo apt-get install gcc binutils make
   ```

3. **Run the Build Script**:  
   Execute the build and test automation script to compile, link, and test the program:
   ```bash
   ./build_and_test.sh
   ```
