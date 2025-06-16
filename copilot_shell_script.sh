#!/bin/bash

read -p "Enter your username: " username
read -p "Enter the new assignment name:" new_assignment

app_dir="submission_reminder_$username"
CONFIG_FILE="$app_dir/config/config.env"

if [[ ! -f "$CONFIG_FILE" ]]; then
	echo "Error "$CONFIG_FILE" not found"
	exit 1
fi

safe_assignment=$(printf '%s\n' "$new_assignment" | sed 's/[/&]/\\&/g')
sed -i "2s|^.*$|ASSIGNMENT=\"$safe_assignment\"|" "$CONFIG_FILE"

echo "Assignment name has been changed to "$new_assignment" in "$CONFIG_FILE""

read -p "Do you want to run startup.sh now? (y/n): " answer

if [[ "$answer" =~ ^[Yy]$ ]]; then

	if [[ -f "submission_reminder_$username/startup.sh" ]]; then
		bash submission_reminder_$username/startup.sh

	else
        	echo "startup.sh not found in the current directory"
        fi
fi
