 Submission Reminder App

This is a shell scripting project that builds a simple reminder system to track and notify students who have not submitted their assignments. It involves setting up a directory structure, scripting logic for updating assignment info, and checking submission statuses.


 Project Structure

My directory "Submission_reminder_app_erin-leyian" is located inside the summative directory in the root directory.
The directory (Submission_reminder_app_erin-leyian) contains:

- `create_environment.sh`: which when run sets up the `submission_reminder_{YourName}` directory.
                           The `submission_reminder_{YourName} directory is created and contains subdirectories with files in them.
                           submission_reminder_erin/
├── app/
│   └── reminder.sh              # Core script that checks for upcoming deadlines
├── config/
│   └── config.env               # Environment variables used by all scripts
├── assets/
│   └── log.txt                  # Optional: where logs or outputs can go
├── modules/
│   └── notify.sh                # Handles displaying or sending reminders
├── startup.sh                   # Initializes folder structure and default files


- `copilot_shell_script.sh`: Updates the assignment name in the configuration and optionally reruns the reminder.
                             Safely updates any key-value pair in config.env from the terminal.

- `README.md`: Instructions on setting up and running the app.

After running the setup script, you will be prompted for your name and the submission_reminder_{name} will be created. The setup inside will also be created. To run the reminder app, you run the startup.sh file within the the submission_remider_{name} directory.
Then run the copilot shell script which will prompt you to add your name , (the same one from create_environmemt script) and the name of the assignmet,which then it'll remind you of the people who have not completed the assignments and the assignment names.
