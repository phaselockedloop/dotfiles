#!/usr/bin/env bash

# Check for correct usage
if [ $# -ne 2 ]; then
    echo "Usage: $0 <directory> <search_string>"
    exit 1
fi

# Set variables
DIRECTORY=$1
SEARCH_STRING=$2

while true; do
    # Use ripgrep to find files containing the search string
    match=$(rg -n -m 1 $SEARCH_STRING $DIRECTORY | head -n 1)

    # Check if ripgrep found a match
    if [[ -z "$match" ]]; then
        echo "No more matches found."
        break
    fi

    # Extract the filename and line number from the match
    filename=$(echo $match | cut -d ':' -f 1)
    line=$(echo $match | cut -d ':' -f 2)

    # Open neovim at the line where the match was found
    nvim +$line $filename
done
