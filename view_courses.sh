#!/bin/bash

# Database credentials

#PASSWORD="root_password"
#DB="appDb"
#HOST="127.0.0.1"
#PORT="3306"

USER="root"
DB="StudentRegistration"

# Retrieve and display all courses
sudo mysql -u $USER -D $DB -e "SELECT course_id, course_code, course_name, instructor, credits FROM Courses;"

if [ $? -eq 0 ]; then
    echo "Successfully retrieved course information."
else
    echo "Failed to retrieve course information."
fi
