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
# LOCAL
mysql -u $USER -p$PASSWORD -h $HOST -P $PORT -D $DB -e "INSERT INTO Users (username, password, role) VALUES ('$username', '$hashed_password', 'student');"
user_id=$(mysql -u $USER -p$PASSWORD -h $HOST -P $PORT -D $DB -e "SELECT user_id FROM Users WHERE username='$username';")
mysql -u $USER -p$PASSWORD -h $HOST -P $PORT -D $DB -e "INSERT INTO Students (student_id, name, email, phone) VALUES ('$user_id', '$name', '$email', '$phone');"
# CODESPACES
#sudo mysql -u $USER -D $DB -e "INSERT INTO Users (username, password, role) VALUES ('$username', '$hashed_password', 'student');"
#user_id=$(sudo mysql -u $USER -D $DB -s -N -e "SELECT user_id FROM Users WHERE username='$username';")
#sudo mysql -u $USER -D $DB -e "INSERT INTO Students (student_id, name, email, phone) VALUES ('$user_id', '$name', '$email', '$phone');"

echo "Student $name has been successfully created!"
