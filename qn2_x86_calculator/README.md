# Qn2. Calculator

## Overview

The **C-to-Assembly Calculator** project demonstrates how to implement a simple calculator in C, convert the C code to assembly, and run the resulting executable. This project automates the process of compiling, assembling, and linking the generated files into a fully functional calculator program.

The project includes:
- A C program implementing the calculator logic.
- An automated build script to generate assembly code, compile, and run the executable.

---

## Features

The calculator provides the following functionality:
1. Prompts the user to input two numbers.
2. Allows the user to select an operation (`+`, `-`, `*`, `/`).
3. Displays the result of the calculation.
4. Handles invalid operations and division by zero gracefully.

---

## Requirements

To build and run the calculator, ensure you have:
- **GCC**: GNU Compiler Collection
- **NASM**: The Netwide Assembler
- A Linux-based system or any system with GCC, NASM, and build utilities installed.


## Usage

1. **Run the Automation Script**:  
   Execute the build and run automation script:
   ```bash
   ./build_and_run.sh
   ```


## How It Works

### Script Workflow
The `build_and_run.sh` script automates the following steps:
1. **Generate Assembly Code from C**:  
   Uses GCC to generate an assembly file (`.s`) from the C program.

2. **Assemble the Assembly Code**:  
   Uses NASM to convert the `.s` file into an object file (`.o`).

3. **Link the Object File**:  
   Uses GCC to link the object file and create an executable.

4. **Run the Program**:  
   Executes the compiled calculator.

### File Structure
- `calculator.c`: The C implementation of the calculator.
- `build_and_run.sh`: The automation script for building and running the program.
- `calculator.s`: Assembly code generated from `calculator.c`.
- `calculator.o`: Object file created from `calculator.s`.