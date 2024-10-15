#!/bin/bash

# Database credentials
USER="root"
DB="StudentRegistration"

# Prompt user for course details
echo "Enter the course code (e.g., CS101):"
read course_code

echo "Enter the course name:"
read course_name

echo "Enter the instructor's name:"
read instructor

echo "Enter the number of credits for the course:"
read credits

# Insert the course into the Courses table
sudo mysql -u $USER -D $DB -e "INSERT INTO Courses (course_code, course_name, instructor, credits) VALUES ('$course_code', '$course_name', '$instructor', '$credits');"

echo "Course $course_name has been successfully created!"
