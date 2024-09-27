#!/bin/bash

# Find and delete all "tests" folders in the current directory and subdirectories
find . -type d -name "tests" -exec rm -rf {} +

echo "All 'tests' folders have been deleted."
