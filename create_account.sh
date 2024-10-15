#!/bin/bash

# Database credentials
USER="root"
#PASSWORD="root_password"
#DB="appDb"
#HOST="127.0.0.1"
#PORT="3306"
DB="StudentRegistration"

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
#user_exists=$(mysql -u $USER -p$PASSWORD -h $HOST -P $PORT -D $DB -s -N -e "SELECT COUNT(*) FROM users WHERE username='$username';")
user_exists=$(sudo mysql -u $USER -D $DB -s -N -e "SELECT COUNT(*) FROM Users WHERE username='$username';")

if [ $user_exists -eq 0 ]; then
    # Insert into the 'users' table (with role = 'student')
    #mysql -u $USER -p$PASSWORD -h $HOST -P $PORT -D $DB -e "INSERT INTO users (username, password, role) VALUES ('$username', '$hashed_password', 'student');"
    sudo mysql -u $USER -D $DB -e "INSERT INTO Users (username, password, role) VALUES ('$username', '$hashed_password', 'student');"
    
    # Get the newly created user_id
    #user_id=$(mysql -u $USER -p$PASSWORD -h $HOST -P $PORT -D $DB -s -N -e "SELECT user_id FROM users WHERE username='$username';")
    user_id=$(sudo mysql -u $USER -D $DB -s -N -e "SELECT user_id FROM Users WHERE username='$username';")
    
    # Insert additional details into the 'students' table
    #mysql -u $USER -p$PASSWORD -h $HOST -P $PORT -D $DB -e "INSERT INTO students (student_id, name, email, phone) VALUES ('$user_id', '$name', '$email', '$phone');"
    sudo mysql -u $USER -D $DB -e "INSERT INTO students (student_id, name, email, phone) VALUES ('$user_id', '$name', '$email', '$phone');"
    
    echo "Account created successfully!"
else
    echo "Username already exists. Please choose a different username."
fi

