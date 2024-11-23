# Qn5. Using Strace Tool

## Overview

The **Process Tracing with Strace** project demonstrates how to use the `strace` tool to trace system calls in both parent and child processes created by a C program. The project automates the process of compiling, executing, and tracing the program to analyze its behavior.

The project includes:
- A C program that creates a child process using `fork` and executes a new program using `exec`.
- An automation script to build the program, execute it, and trace its system calls using `strace`.

---

## Features

The project provides the following functionality:
1. A **multi-process C program**:
   - Demonstrates how `fork` and `exec` work together to create and execute processes.
   - Logs outputs from the parent and child processes.
2. **Automated strace integration**:
   - Traces system calls made by the parent and child processes.
   - Saves the trace output to a log file for analysis.
3. **Automation script** to:
   - Compile the program.
   - Run it with `strace` and log system call details.

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

1. **Check Source File**:  
   Verifies that the required source file (`fork_exec.c`) is present.

2. **Clean Previous Builds**:  
   Removes any existing executable and log files to ensure a clean build.

3. **Compile the Program**:  
   Compiles `fork_exec.c` into an executable (`fork_exec`).

4. **Run the Program with Strace**:  
   - Executes the program using `strace` with the `-f` flag to trace both parent and child processes.
   - Logs the system call details to `trace.log`.

5. **Output Results**:  
   - Provides feedback on the execution and the location of the trace log file.

---

### File Structure

- `fork_exec.c`: C program that demonstrates the use of `fork` and `exec`.
- `build_and_run.sh`: Automation script to compile and execute the program with `strace`.
- `trace.log`: Log file containing the traced system calls.
- `README.md`: Documentation explaining the project setup and usage.

---

