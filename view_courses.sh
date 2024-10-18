#!/bin/bash

# Environment switch: Set to either "local" or "codespaces"
ENVIRONMENT="codespaces"

# Database credentials for local environment
LOCAL_USER="root"
LOCAL_PASSWORD="root"
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

# Check if the session exists
if [ ! -f session.txt ]; then
    echo "You are not logged in!"
    exit 1
fi

# Get the student's ID 
user_id=$(cat session.txt | grep "user_id" | awk -F= '{print $2}')
role=$(cat session.txt | grep "role" | awk -F= '{print $2}')

# Show all available courses
echo "===== Available courses ====="
$MYSQL_CMD -e "SELECT * FROM Courses;"

if [ "$role" == "student" ]; then
    student_id=$($MYSQL_CMD -e "SELECT student_id FROM Students WHERE user_id='$user_id';")

    # Show the student's registered courses
    echo "===== Your courses ====="
    $MYSQL_CMD -e "
    SELECT Courses.course_id, Courses.course_code, Courses.course_name 
    FROM Courses 
    JOIN Registrations ON Courses.course_id = Registrations.course_id 
    WHERE Registrations.student_id = '$student_id';
    "
fi
