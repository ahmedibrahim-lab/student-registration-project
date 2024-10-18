#!/bin/bash

# Environment switch: Set to either "local" or "codespaces"
ENVIRONMENT="local"

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

# Prompt user for input
echo "Enter your desired username:"
read username

echo "Enter your desired password:"
read -s password  # -s hides the input for password

echo "Enter your full name:"
read name

echo "Enter your email address:"
read email

echo "Enter your phone number (optional):"
read phone

# Hash the password (using md5, you can use more secure hashing like sha256)
hashed_password=$(echo -n "$password" | md5sum | awk '{print $1}')

# Check if the username already exists
user_exists=$($MYSQL_CMD -e "SELECT COUNT(*) FROM Users WHERE username='$username';")

if [ $user_exists -eq 0 ]; then
    # Insert into the 'users' table (with role = 'student')
    $MYSQL_CMD -e "INSERT INTO Users (username, password, role) VALUES ('$username', '$hashed_password', 'student');"
    
    # Get the newly created user_id
    user_id=$($MYSQL_CMD -sse "SELECT user_id FROM Users WHERE username='$username';") 
    
    # Check if user_id was successfully retrieved
    if [ -z "$user_id" ]; then
        echo "Failed to retrieve user_id."
        exit 1
    fi
    
    # Insert additional details into the 'students' table
    $MYSQL_CMD -e "INSERT INTO Students (user_id, name, email, phone) VALUES ('$user_id','$name', '$email', '$phone');"
    
    echo "Account created successfully!"
else
    echo "Username already exists. Please choose a different username."
fi
