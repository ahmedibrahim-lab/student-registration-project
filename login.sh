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

# Remove session files from last login
if [ -f session.txt ]; then
    rm session.txt
fi

# Prompt user for input
echo "Enter your username:"
read username

echo "Enter your password:"
read -s password

# Hash the entered password to compare with the stored hash
hashed_password=$(echo -n "$password" | md5sum | awk '{print $1}')

# Check if the username and password match
user_info=$($MYSQL_CMD -e "SELECT user_id, username, role FROM Users WHERE username='$username' AND password='$hashed_password';")

if [ -z "$user_info" ]; then
    echo "Invalid username or password."
    exit 1
else
    user_id=$(echo $user_info | awk '{print $1}')
    username=$(echo $user_info | awk '{print $2}')
    role=$(echo $user_info | awk '{print $3}')
    echo "Login successful! Welcome, $username."
    echo "user_id=$user_id" >> session.txt
    echo "username=$username" >> session.txt
    echo "role=$role" >> session.txt

    # Redirect based on role (student or admin)
    ./auth.sh $username $role
fi
