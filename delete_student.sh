#!/bin/bash

# Database credentials
USER="root"
DB="StudentRegistration"

# Prompt user for the student username to delete
echo "Enter the username of the student to delete:"
read username

# Delete the student from the Users and Students tables
user_id=$(sudo mysql -u $USER -D $DB -s -N -e "SELECT user_id FROM Users WHERE username='$username';")
sudo mysql -u $USER -D $DB -e "DELETE FROM Students WHERE student_id='$user_id';"
sudo mysql -u $USER -D $DB -e "DELETE FROM Users WHERE username='$username';"

echo "Student $username has been successfully deleted!"
