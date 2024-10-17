#!/bin/bash

# Database credentials (LOCAL)
USER="root"
PASSWORD="root_password"
DB="appDb"
HOST="127.0.0.1"
PORT="3306"

# Database credentials (CODESPACES)
#USER="root"
#DB="StudentRegistration"

# Prompt user for the student username to delete
echo "Enter the username of the student to delete:"
read username

# Delete the student from the Users and Students tables
# LOCAL
user_id=$(mysql -u $USER -p$PASSWORD -h $HOST -P $PORT -D $DB -e "SELECT user_id FROM Users WHERE username='$username';")
mysql -u $USER -p$PASSWORD -h $HOST -P $PORT -D $DB -e "DELETE FROM Students WHERE student_id='$user_id';"
mysql -u $USER -p$PASSWORD -h $HOST -P $PORT -D $DB -e "DELETE FROM Users WHERE username='$username';"
# CODESPACES
#user_id=$(sudo mysql -u $USER -D $DB -s -N -e "SELECT user_id FROM Users WHERE username='$username';")
#sudo mysql -u $USER -D $DB -e "DELETE FROM Students WHERE student_id='$user_id';"
#sudo mysql -u $USER -D $DB -e "DELETE FROM Users WHERE username='$username';"

echo "Student $username has been successfully deleted!"
