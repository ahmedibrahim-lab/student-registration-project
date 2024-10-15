#!/bin/bash

# Database credentials
USER="root"
#PASSWORD="root_password"
#DB="appDb"
#HOST="127.0.0.1"
#PORT="3306"
DB="StudentRegistration"


# Prompt user for input
echo "Enter your username:"
read username

echo "Enter your password:"
read -s password

# Hash the entered password to compare with the stored hash
hashed_password=$(echo -n "$password" | md5sum | awk '{print $1}')

# Check if the username and password match
#user_info=$(mysql -u $USER -p$PASSWORD -h $HOST -D $DB -s -N -e "SELECT username, role FROM users WHERE username='$username' AND password='$hashed_password';")
user_info=$(sudo mysql -u $USER -D $DB -s -N -e "SELECT username, role FROM Users WHERE username='$username' AND password='$hashed_password';")

if [ -z "$user_info" ]; then
    echo "Invalid username or password."
    exit 1
else
    username=$(echo $user_info | awk '{print $1}')
    role=$(echo $user_info | awk '{print $2}')
    echo "Login successful! Welcome, $username."

    # Redirect based on role (student or admin)
    ./auth.sh $username $role
fi

