#!/bin/bash
# Student registration project by Ahmed, Muhammad and Szymon
# A simple menu interface

while true; do
	echo " "
	echo " "
	echo " "
	echo "===== Student's menu ====="
	echo "1. Show available courses"
	echo "2. Register for a course"
	echo "3. Withdraw from the course"
	echo "4. Logout"
	read -p "Choose an option: " choice
	
	clear

	case $choice in
		1)
			./view_courses.sh
			;;
		2)
			./register_courses.sh
			;;
		3)
			./withdraw_courses.sh
			;;
		4)
			echo "Logging out..."
			exit 0
			;;
		*)
			echo "Wrong choice. Try again."
			;;
	esac
done
