# Qn4. POSIX Threads 

## Overview

The **Multi-Threaded Summation** project showcases how to implement a multi-threaded program to calculate the sum of a sequence of numbers in C. This project automates the process of compiling, building, and running single-threaded and multi-threaded versions of the summation program.

The project includes:
- A single-threaded implementation of the summation logic.
- A multi-threaded implementation to divide the workload across threads.
- An automated build and run script to compile, execute, and validate both implementations.

---

## Features

The project provides the following functionality:
1. Single-threaded summation program:
   - Calculates the sum of numbers sequentially.
2. Multi-threaded summation program:
   - Divides the summation task across multiple threads for better performance on larger data sets.
3. Automation script to:
   - Compile both programs.
   - Run them with sample inputs and validate outputs.

---

## Usage

### Run the Automation Script:
Execute the build and run script:
```bash
./build_and_run.sh
```

---

## How It Works

### Script Workflow

The `build_and_run.sh` script automates the following steps:

1. **Check Source Files**:  
   Verifies that the required source files (`single_threaded_sum.c`, `multi_threaded_sum.c`) are present.

2. **Create Build Directory**:  
   Ensures a clean build directory for compiled executables.

3. **Compile the Programs**:  
   - Compiles `single_threaded_sum.c` and `multi_threaded_sum.c` into executables.
   - Links with the POSIX threads library (`-lpthread`) for multi-threaded support.

4. **Run the Programs**:  
   - Executes both programs with a sample input.
   - Validates the output and logs the results.

---

### File Structure

- `single_threaded_sum.c`: Single-threaded implementation of the summation logic.
- `multi_threaded_sum.c`: Multi-threaded implementation of the summation logic.
- `build_and_run.sh`: Automation script to compile and execute the programs.
- `build/`: Directory for storing compiled executables (`single_threaded_sum`, `multi_threaded_sum`).

---

