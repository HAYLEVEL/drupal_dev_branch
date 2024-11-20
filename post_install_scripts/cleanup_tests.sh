#!/bin/bash

# Description: This script searches for all directories named "tests"
# within the current directory and its subdirectories, then deletes them.
# It also provides output regarding the progress and whether any folders were deleted.

# Variable to track if anything was deleted
deleted_any=false

# Using 'find' to search for all directories named "tests" within the current directory
# '-type d' ensures we only find directories
# '-name "tests"' specifies the exact name to search for.
# Store the result of the find command in a variable.
dirs=$(find . -type d -name "tests")

# Loop over the found directories
for dir in $dirs; do
  # If any "tests" directories are found, delete them and echo their paths
  if [ -d "$dir" ]; then
    echo "Deleting directory: $dir"
    rm -rf "$dir"
    deleted_any=true
  fi
done

# Check if any directories were deleted and print an appropriate message
if [ "$deleted_any" = true ]; then
  echo "All 'tests' folders have been successfully deleted."
else
  echo "No 'tests' folders found."
fi
