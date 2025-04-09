#!/bin/bash

# Set log file path from environment variable or use default
LOG_FILE="${REMOVE_LOG_PATH:-$HOME/.local/logs/removed.log}"

# Create log directory if it doesn't exist
mkdir -p "$(dirname "$LOG_FILE")"

# Create the log file if it doesn't exist, exit if creation fails
if [ ! -f "$LOG_FILE" ]; then
    touch "$LOG_FILE" || {
        echo "Failed to create log file at $LOG_FILE" >&2
        exit 1
    }
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
        # Log deletion if not in silent mode
        if [ "$SILENT" = false ]; then
            echo "$(date) - User: $(whoami) - Removed: $FILE" >> "$LOG_FILE"
        fi
        rm -rf "$FILE"
    else
        echo "$FILE does not exist." >&2
        echo "$(date) - User: $(whoami) - Failed to remove (not found): $FILE" >> "$LOG_FILE"
    fi
done
