#!/bin/bash

username=$1
role=$2

if [ "$role" == "student" ]; then
    echo "Redirecting to the student menu..."
    # Call the student menu script or student operation functions
    ./student_menu.sh $username
elif [ "$role" == "admin" ]; then
    echo "Redirecting to the admin menu..."
    # Call the admin menu script or admin operation functions
    ./admin_menu.sh $username
else
    echo "Invalid role!"
    exit 1
fi

