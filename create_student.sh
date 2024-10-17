#!/bin/bash

# Environment switch: Set to either "local" or "codespaces"
ENVIRONMENT="codespaces"

# Database credentials for local environment
LOCAL_USER="root"
LOCAL_PASSWORD="root_password"
LOCAL_DB="appDb"
LOCAL_HOST="127.0.0.1"
LOCAL_PORT="3306"

# Database credentials for codespaces environment
CODESPACES_USER="root"
CODESPACES_DB="StudentRegistration"

# Database variables (These will be updated based on ENVIRONMENT)
USER=""
PASSWORD=""
DB=""
HOST=""
PORT=""
MYSQL_CMD=""

# Set environment-specific variables
if [ "$ENVIRONMENT" == "local" ]; then
    USER=$LOCAL_USER
    PASSWORD=$LOCAL_PASSWORD
    DB=$LOCAL_DB
    HOST=$LOCAL_HOST
    PORT=$LOCAL_PORT
    MYSQL_CMD="mysql -u $USER -p$PASSWORD -h $HOST -P $PORT -D $DB -s -N"
elif [ "$ENVIRONMENT" == "codespaces" ]; then
    USER=$CODESPACES_USER
    DB=$CODESPACES_DB
    MYSQL_CMD="sudo mysql -u $USER -D $DB -s -N"
fi

# Prompt user for student details
echo "Enter the username for the student:"
read username

echo "Enter a password for the student:"
read -s password

echo "Enter the student's full name:"
read name

echo "Enter the student's email:"
read email

echo "Enter the student's phone number (optional):"
read phone

# Hash the password
hashed_password=$(echo -n "$password" | md5sum | awk '{print $1}')

# Insert the student into the Users and Students tables
$MYSQL_CMD -e "INSERT INTO Users (username, password, role) VALUES ('$username', '$hashed_password', 'student');"
user_id=$($MYSQL_CMD -e "SELECT user_id FROM Users WHERE username='$username';")
$MYSQL_CMD -e "INSERT INTO Students (student_id, name, email, phone) VALUES ('$user_id', '$name', '$email', '$phone');"

echo "Student $name has been successfully created!"
