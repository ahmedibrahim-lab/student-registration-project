#!/bin/bash

#mysql datas
USER="root"
PASSWORD="root"
DB="studentRegistrationProject"
HOST="127.0.0.1"
PORT="3306"

#check if the session exists
if [ ! session.txt ]; then
        echo "You are not logged in!"
        exit 1
fi

#get student's id
student_id=$(cat session.txt | grep "user_id")

#show courses user is already registered
echo "Your courses: "
sudo mysql -u $USER -p$PASSWORD -h $HOST -P $PORT -D $DB -e "
SELECT Courses.id, Courses.course_name 
FROM Courses 
JOIN Registration ON Courses.id = Registration.course_id 
WHERE Registration.student_id = '$student_is';
"

#show available courses to register
echo "Available courses: "
sudo mysql -u $USER -p$PASSWORD -h $HOST -P $PORT -D $DB -e "
SELECT id, course_name, description, credits 
FROM Courses 
WHERE id NOT IN (
SELECT course_id FROM Registration WHERE student_id='$student_id'
);
"

# ask user of course id
read -p "Enter ID of course to register: " course_id

# check if this course exists
course_exists=$(mysql -u $USER -p$PASSWORD -h $HOST -P $PORT -D $DB -sse "
SELECT COUNT(*) 
FROM Courses 
WHERE id = '$course_id';
")

if [ "$course_exists" -eq 0 ]; then
    echo "This course does not exist!"
    exit 1
fi

# register user to a course
mysql -u $USER -p$PASSWORD -h $HOST -P $PORT -D $DB -e "
INSERT INTO Registrations (student_id, course_id)
VALUES ('$student_id', '$course_id');
"

echo "You got registered to course: $course_id"


