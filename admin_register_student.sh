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

# Prompt admin for the student username and course code
echo "Enter the username of the student to register:"
read username

echo "Enter the course code (e.g., CS101) to register the student for:"
read course_code

# Find student ID and course ID
student_id=$($MYSQL_CMD -e "SELECT student_id FROM Students WHERE user_id=(SELECT user_id FROM Users WHERE username='$username');")
course_id=$($MYSQL_CMD -e "SELECT course_id FROM Courses WHERE course_code='$course_code';")

# Register the student for the course
$MYSQL_CMD -e "INSERT INTO Registrations (student_id, course_id) VALUES ('$student_id', '$course_id');"

student_name=$($MYSQL_CMD -e "SELECT name FROM Students WHERE user_id=(SELECT user_id FROM Users WHERE username='$username');")

echo "Student $student_name has been successfully registered for course $course_code!"
