#!/bin/bash

# Define the log file location
LOG_FILE="$HOME/Desktop/removed.log"

# Create the log file if it doesn't exist
if [ ! -f "$LOG_FILE" ]; then
    touch "$LOG_FILE"
fi

# Check if the number of arguments is zero
if [ "$#" -eq 0 ]; then
    echo "Please enter a list of files or directories to delete" >&2
    exit 1
fi

# Initialize silent mode
SILENT=false

# Check for the silent option
if [ "$1" == "-s" ]; then
    SILENT=true
    shift  # Shift arguments to remove -s
fi

# Loop through all provided arguments
for FILE in "$@"; do
    if [ -e "$FILE" ]; then
        # If not in silent mode, echo details
        if [ "$SILENT" = false ]; then
            echo "$(date) - User: $(whoami) - Removed: $FILE" >> "$LOG_FILE"
        fi
        # Remove the file
        rm -rf "$FILE"
    else
        echo "$FILE does not exist." >&2
    fi
done

