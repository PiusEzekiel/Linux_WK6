# Qn3. Weather Data Manipulation

## Overview

The **Weather Data Analysis** project demonstrates how to process weather data using a combination of Python and C. It implements a C extension module for Python to efficiently calculate statistical metrics, including mode, standard deviation, and median, from a dataset of average temperatures.

The project includes:
- A **C program** compiled as a Python extension module.
- A **Python script** to load weather data and perform analysis.
- An **automation script** to compile, build, and run the program seamlessly.

---

## Features

The weather analysis program provides the following functionality:
1. Loads temperature data from a CSV file.
2. Calculates:
   - **Mode**: The most frequent temperature.
   - **Standard Deviation**: The spread of the temperature values.
   - **Median**: The middle temperature value.
3. Outputs the results with clear formatting.

---

## Requirements

To build and run the weather analysis project, ensure you have:
- **Python 3.x**: To run the scripts.
- **GCC**: GNU Compiler Collection to compile the C extension.
- **Setuptools**: For building the Python C extension.
- A Linux-based or macOS system (or Windows with WSL or MinGW).

---

## Usage

1. **Run the Automation Script**:  
   Execute the `build_and_run.sh` script to build the C extension and run the program:
   ```bash
   ./build_and_run.sh
   ```


## How It Works

### Script Workflow
The `build_and_run.sh` script automates the following steps:
1. **Check Required Files**:  
   Ensures all necessary files (`weather_analysis.c`, `setup.py`, `main.py`, and `weather.csv`) are present.

2. **Clean Existing Build Directory**:  
   Removes any previous build files to prevent conflicts.

3. **Compile the C Extension**:  
   Uses Python’s `setuptools` to compile the `weather_analysis.c` file into a shared object (`.so`) file.

4. **Move Compiled Library**:  
   Places the compiled `.so` file into the current directory for immediate use.

5. **Run the Python Program**:  
   Executes `main.py` to read the dataset and compute the statistical metrics.

### File Structure
- `weather_analysis.c`: The C implementation of mode, median, and standard deviation calculations.
- `setup.py`: The Python setup script to build the C extension.
- `main.py`: The Python script to load data and use the C extension.
- `weather.csv`: The dataset of average temperatures.
- `build_and_run.sh`: The automation script for building and running the project.

---

