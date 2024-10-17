#!/bin/bash

username=$1

while true; do
    echo "Welcome, $username! You are logged in as an admin."
    echo "Please choose an option:"
    echo "1. View all students"
    echo "2. View all courses"
    echo "3. Create a course"
    echo "4. Delete a course"
    echo "5. Register a student for a course"
    echo "6. Unregister a student from a course"
    echo "7. Create a new student"
    echo "8. Delete a student"
    echo "9. Logout"

    read -p "Enter your choice [1-9]: " choice

    case $choice in
        1)
            echo "Fetching all students..."
            ./view_students.sh
            ;;
        2)
            echo "Fetching all courses..."
            ./view_courses.sh
            ;;
        3)
            echo "Creating a new course..."
            ./create_course.sh
            ;;
        4)
            echo "Deleting a course..."
            ./delete_course.sh
            ;;
        5)
            echo "Registering a student for a course..."
            ./admin_register_student.sh
            ;;
        6)
            echo "Unregistering a student from a course..."
            ./admin_unregister_student.sh
            ;;
        7)
            echo "Creating a new student..."
            ./create_student.sh
            ;;
        8)
            echo "Deleting a student..."
            ./delete_student.sh
            ;;
        9)
            echo "Logging out..."
            exit 0
            ;;
        *)
            echo "Invalid option. Please try again."
            ;;
    esac
done
