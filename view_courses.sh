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


#get the student's ID from the session.txt file
student_id=$(cat session.txt | grep "user_id")

#show all available courses
echo "===== Available courses ====="
sudo mysql -u $USER -p$PASSWORD -h $HOST -P $PORT -D $DB -e "
SELECT id, course_name, description, credits 
FROM Courses;
"

#show student's courses
echo "===== Your courses ====="
sudo mysql -u $USER -p$PASSWORD -h $HOST -P $PORT -D $DB -e "
SELECT Courses.id, Courses.course_name 
FROM Courses 
JOIN Registration ON Courses.id = Registration.course_id 
WHERE Registration.student='$student_id';
"

