#!/bin/bash

# Environment switch: Set to either "local" or "codespaces"
ENVIRONMENT="codespaces"

# Database credentials for local environment
LOCAL_USER="root"
LOCAL_PASSWORD="root_password"
LOCAL_DB="StudentRegistration"
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

# Prompt user for course details
echo "Enter the course code (e.g., CS101):"
read course_code

echo "Enter the course name:"
read course_name

echo "Enter the instructor's name:"
read instructor

echo "Enter the number of credits for the course:"
read credits

# Insert the course into the Courses table
$MYSQL_CMD -e "INSERT INTO Courses (course_code, course_name, instructor, credits) VALUES ('$course_code', '$course_name', '$instructor', '$credits');"

echo "Course $course_name has been successfully created!"
