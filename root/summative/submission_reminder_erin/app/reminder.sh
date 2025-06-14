#!/bin/bash

resolved_path="$(readlink -f "${BASH_SOURCE[0]}")"
echo "Resolved path: $resolved_path"

script_dir="$(dirname "$resolved_path")"
echo "Script directory: $script_dir"

# Go up one level to basefolder
base_dir="$(dirname "$script_dir")"

echo "file $base_dir"

# Source environment variables and helper functions
source "$base_dir/config/config.env"
source "$base_dir/modules/functions.sh"

# Path to the submissions file
submissions_file="$base_dir/assets/submissions.txt"

echo "$submissions_file"

# Print remaining time and run the reminder function
echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING days"
echo "--------------------------------------------"
check_submissions "$submissions_file"
