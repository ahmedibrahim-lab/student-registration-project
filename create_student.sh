#!/bin/bash

# Database credentials
USER="root"
DB="StudentRegistration"

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
sudo mysql -u $USER -D $DB -e "INSERT INTO Users (username, password, role) VALUES ('$username', '$hashed_password', 'student');"
user_id=$(sudo mysql -u $USER -D $DB -s -N -e "SELECT user_id FROM Users WHERE username='$username';")
sudo mysql -u $USER -D $DB -e "INSERT INTO Students (student_id, name, email, phone) VALUES ('$user_id', '$name', '$email', '$phone');"

echo "Student $name has been successfully created!"
