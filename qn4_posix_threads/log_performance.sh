#!/bin/bash

# Program definitions
SINGLE_THREADED="./build/single_threaded_sum"
MULTI_THREADED="./build/multi_threaded_sum"
LOG_FILE="performance_log.txt"  # Define the log file

# Function to log performance in the specified format
log_performance() {
    PROGRAM=$1
    INPUT_SIZE=$2

    if [[ -x "$PROGRAM" ]]; then
        # Capture program output and timing metrics separately
        PROGRAM_OUTPUT=$($PROGRAM <<< $INPUT_SIZE 2>&1)
        TIMING_OUTPUT=$(/usr/bin/time -f "%e %U %S" $PROGRAM <<< $INPUT_SIZE 2>&1)
        EXIT_CODE=$?

        echo "Program Output: $PROGRAM_OUTPUT"  # Debugging: Print program output
        echo "Timing Output: $TIMING_OUTPUT"    # Debugging: Print timing output

        if [[ $EXIT_CODE -eq 0 ]]; then
            # Parse the timing output into variables
            REALTIME=$(echo $TIMING_OUTPUT | awk '{printf "%.0f", $1 * 1000000}')  # Convert seconds to microseconds
            USERTIME=$(echo $TIMING_OUTPUT | awk '{printf "%.0f", $2 * 1000000}')
            SYSTIME=$(echo $TIMING_OUTPUT | awk '{printf "%.0f", $3 * 1000000}')
            TOTALTIME=$((REALTIME + USERTIME + SYSTIME))

            # Log to the file
            {
                echo ""
                echo "$PROGRAM run:"
                echo "When n = $INPUT_SIZE,"
                echo " Program Output: $PROGRAM_OUTPUT"
                echo " CPU Usage:"
                echo "  CPU RealTime: ${REALTIME} microseconds"
                echo "  System CPU Time: ${SYSTIME} microseconds"
                echo "  CPU UserTime: ${USERTIME} microseconds"
                echo "  Total CPU Time: ${TOTALTIME} microseconds"
            } >> $LOG_FILE
        else
            # Log error to the file
            echo "" >> $LOG_FILE
            echo "$PROGRAM run:" >> $LOG_FILE
            echo "When n = $INPUT_SIZE, execution failed. Error encountered." >> $LOG_FILE
            echo " Program Output: $PROGRAM_OUTPUT" >> $LOG_FILE
        fi
    else
        # Log if the program is not executable
        echo "" >> $LOG_FILE
        echo "$PROGRAM run:" >> $LOG_FILE
        echo "When n = $INPUT_SIZE, program not executable." >> $LOG_FILE
    fi
}

# Clear the log file before starting
> $LOG_FILE

# Test for multiple input sizes within the valid range
for INPUT_SIZE in 400 800 1600 2000; do
    log_performance $SINGLE_THREADED $INPUT_SIZE
    log_performance $MULTI_THREADED $INPUT_SIZE
done

echo "Performance log written to $LOG_FILE"
