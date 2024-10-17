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

#get the id of logged in user
student_id=$(cat session.txt | grep "user_id")

#show student courses
echo "===== Your courses ====="
sudo mysql -u $USER -p$PASSWORD -h $HOST -P $PORT -D $DB -e "
SELECT Courses.id, Courses.course_name 
FROM Courses 
JOIN Registration ON Courses.id = Registration.course_id 
WHERE Registration.student_id='$student_id';
"


echo "Insert the ID of course You want withdraw: "
read course_id

# check if the course exists
course_exists=$(mysql -u $USER -p$PASSWORD -h $HOST -P $PORT -D $DB -sse "
SELECT COUNT(*) 
FROM Courses 
WHERE id = '$course_id';
")

if [ "$course_exists" -eq 0 ]; then
    echo "This course does not exist!"
    exit 1
fi

#check if student is registered
exists=$(sudo mysql -u $USER -p $PASSWORD -h $HOST -P $PORT -D $DB -e "
SELECT * FROM Registration 
WHERE student_id='$student_id' AND course_id='$course_id';
" | wc -l)

#delete student from course
if [ "$exists" -gt 1 ]; then
	sudo mysql -u $USER -p$PASSWORD -h $HOST -P $PORT -D $DB -e "
	DELETE FROM Registration 
	WHERE student_id='$student_id' AND course_id='$course_id';
	"
	echo "You withdraw from a course: $course_id"
else
	echo "You are not registered to this course"
fi

