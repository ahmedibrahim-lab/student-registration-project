#!/bin/bash

# Database credentials
USER="root"
DB="StudentRegistration"

# Prompt user for the course code to delete
echo "Enter the course code of the course to delete (e.g., CS101):"
read course_code

# Delete the course from the Courses table
sudo mysql -u $USER -D $DB -e "DELETE FROM Courses WHERE course_code='$course_code';"

echo "Course $course_code has been successfully deleted!"
