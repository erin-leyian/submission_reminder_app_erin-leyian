#!/bin/bash
read -p "Enter your name:" yourname


# creating the directory
app_dir="submission_reminder_${yourname}"
mkdir -p "${app_dir}"

mkdir -p "${app_dir}/config"
mkdir -p "${app_dir}/assets"
mkdir -p "${app_dir}/modules"
mkdir -p "${app_dir}/app"

cat > "${app_dir}/config/config.env" << 'EOL' 
#This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
EOL

cat > "$app_dir/modules/functions.sh" <<'EOL'
#!/bin/bash

# Function to read submissions file and output students who have not submitted
function check_submissions {
    local submissions_file=$1
    echo "Checking submissions in $submissions_file"

    # Skip the header and iterate through the lines
    while IFS=, read -r student assignment status; do
        # Remove leading and trailing whitespace
        student=$(echo "$student" | xargs)
        assignment=$(echo "$assignment" | xargs)
        status=$(echo "$status" | xargs)

        # Check if assignment matches and status is 'not submitted'
        if [[ "$assignment" == "$ASSIGNMENT" && "$status" == "not submitted" ]]; then
            echo "Reminder: $student has not submitted the $ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "$submissions_file") # Skip the header
}
EOL

cat > "$app_dir/app/reminder.sh" << EOL
#!/bin/bash

resolved_path="\$(readlink -f "\${BASH_SOURCE[0]}")"
echo "Resolved path: \$resolved_path"

script_dir="\$(dirname "\$resolved_path")"
echo "Script directory: \$script_dir"

# Go up one level to basefolder
base_dir="\$(dirname "\$script_dir")"

echo "file \$base_dir"

# Source environment variables and helper functions
source "\$base_dir/config/config.env"
source "\$base_dir/modules/functions.sh"

# Path to the submissions file
submissions_file="\$base_dir/assets/submissions.txt"

echo "\$submissions_file"

# Print remaining time and run the reminder function
echo "Assignment: \$ASSIGNMENT"
echo "Days remaining to submit: \$DAYS_REMAINING days"
echo "--------------------------------------------"
check_submissions "\$submissions_file"
EOL

cat > "$app_dir/assets/submissions.txt" << EOL
student, assignment, submission status
Erin,Shell Redirections, submitted
Grace, Shell basics, not submitted
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Divine, Shell Navigation, not submitted
Terry, Git, not submitted
Anissa, Shell Basics, submitted
EOL

cat > "$app_dir/startup.sh" <<EOL
#!/bin/bash
app_dir="$(dirname "$(readlink -f "$0")")"

chmod +x "$app_dir/app/reminder.sh"
chmod +x "$app_dir/modules/functions.sh"
bash "$app_dir/app/reminder.sh"
EOL

chmod +x "$app_dir/startup.sh"

echo "Setup is complete in $app_dir"
echo "Run the app using :bash $app_dir/startup.sh"

