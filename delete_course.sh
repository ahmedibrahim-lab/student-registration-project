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

# Prompt user for the course code to delete
echo "Enter the course code of the course to delete (e.g., CS101):"
read course_code

# Delete the course from the Courses table
# LOCAL
mysql -u $USER -p$PASSWORD -h $HOST -P $PORT -D $DB -e "DELETE FROM Courses WHERE course_code='$course_code';"
# CODESPACES
#sudo mysql -u $USER -D $DB -e "DELETE FROM Courses WHERE course_code='$course_code';"

echo "Course $course_code has been successfully deleted!"
