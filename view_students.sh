#!/bin/bash

# Database credentials
USER="root"
#PASSWORD="root_password"
#DB="appDb"
#HOST="127.0.0.1"
#PORT="3306"
DB="StudentRegistration"

# Retrieve and display all students
sudo mysql -u $USER -D $DB -e "SELECT student_id, name, email, phone FROM Students;"

if [ $? -eq 0 ]; then
    echo "Successfully retrieved student information."
else
    echo "Failed to retrieve student information."
fi
