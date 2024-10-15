#!/bin/bash

username=$1

while true; do
    echo "Welcome, $username! You are logged in as a student."
    echo "Please choose an option:"
    echo "1. View available courses"
    echo "2. Register for a course"
    echo "3. Withdraw from a course"
    echo "4. Logout"

    read -p "Enter your choice [1-4]: " choice

    case $choice in
        1)
            echo "Fetching available courses..."
            ./view_courses.sh
            ;;
        2)
            echo "Registering for a course..."
            ./register_course.sh $username
            ;;
        3)
            echo "Withdrawing from a course..."
            ./withdraw_course.sh $username
            ;;
        4)
            echo "Logging out..."
            exit 0
            ;;
        *)
            echo "Invalid option. Please try again."
            ;;
    esac
done
