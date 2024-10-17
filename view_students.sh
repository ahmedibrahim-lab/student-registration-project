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

# Retrieve and display all students
# LOCAL
mysql -u $USER -p$PASSWORD -h $HOST -P $PORT -D $DB -e "SELECT student_id, name, email, phone FROM Students;"
# CODESPACES
#sudo mysql -u $USER -D $DB -e "SELECT student_id, name, email, phone FROM Students;"

if [ $? -eq 0 ]; then
    echo "Successfully retrieved student information."
else
    echo "Failed to retrieve student information."
fi
