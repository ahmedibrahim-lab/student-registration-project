#!/bin/bash

# Environment switch: Set to either "local" or "codespaces"
ENVIRONMENT="codespaces"

# Database credentials for local environment
LOCAL_USER="root"
LOCAL_PASSWORD="root_password"
LOCAL_DB="studentRegistrationProject"
LOCAL_HOST="127.0.0.1"
LOCAL_PORT="3306"

# Database credentials for Codespaces environment
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
    MYSQL_CMD="mysql -u $USER -p$PASSWORD -h $HOST -P $PORT -D $DB"
elif [ "$ENVIRONMENT" == "codespaces" ]; then
    USER=$CODESPACES_USER
    DB=$CODESPACES_DB
    MYSQL_CMD="sudo mysql -u $USER -D $DB"
fi

# Check if the session exists
if [ ! -f session.txt ]; then
    echo "You are not logged in!"
    exit 1
fi

# Get the ID of the logged-in user
student_id=$(grep "user_id" session.txt | awk -F '=' '{print $2}')

# Show student courses
echo "===== Your courses ====="
$MYSQL_CMD -e "
SELECT Courses.course_id, Courses.course_name 
FROM Courses 
JOIN Registrations ON Courses.course_id = Registrations.course_id 
WHERE Registrations.student_id='$student_id';
"

echo "Insert the ID of the course you want to withdraw from: "
read course_id

# Check if the course exists
course_exists=$($MYSQL_CMD -sse "
SELECT COUNT(*) 
FROM Courses 
WHERE course_id = '$course_id';
")

if [ "$course_exists" -eq 0 ]; then
    echo "This course does not exist!"
    exit 1
fi

# Check if the student is registered
exists=$($MYSQL_CMD -e "
SELECT * FROM Registrations 
WHERE student_id='$student_id' AND course_id='$course_id';
" | wc -l)

# Delete student from course
if [ "$exists" -gt 0 ]; then
    $MYSQL_CMD -e "
    DELETE FROM Registrations 
    WHERE student_id='$student_id' AND course_id='$course_id';
    "
    echo "You have withdrawn from the course: $course_id"
else
    echo "You are not registered in this course"
fi
