#!/bin/bash

# MySQL credentials
USER="root"

# Database and table names
DATABASE="StudentRegistration"
TABLE="student"

# Query to retrieve all last names
LAST_NAMES_QUERY="SELECT last_name FROM $TABLE;"

# Query to check if "Smith" exists as a last name
CHECK_LAST_NAME_QUERY="SELECT COUNT(*) FROM $TABLE WHERE last_name = 'Smith';"

# Query to check if "Smith" exists as a first name
CHECK_FIRST_NAME_QUERY="SELECT COUNT(*) FROM $TABLE WHERE first_name = 'Smith';"

# Execute the queries and store results
LAST_NAMES=$(sudo mysql -u $USER -D $DATABASE --skip-column-names -e "$LAST_NAMES_QUERY")
LAST_NAME_COUNT=$(sudo mysql -u $USER -D $DATABASE --skip-column-names -e "$CHECK_LAST_NAME_QUERY")
FIRST_NAME_COUNT=$(sudo mysql -u $USER -D $DATABASE --skip-column-names -e "$CHECK_FIRST_NAME_QUERY")
LAST_NAMES_ARRAY=($(sudo mysql -u $USER -D $DATABASE -e "$LAST_NAMES_QUERY"))
# Output the results
echo "All Last Names:"
echo "$LAST_NAMES"

if [ "$LAST_NAME_COUNT" -gt 0 ]; then
    echo "'Smith' is found as a last name."
else
    echo "'Smith' is not found as a last name."
fi

if [ "$FIRST_NAME_COUNT" -gt 0 ]; then
    echo "'Smith' is found as a first name."
else
    echo "'Smith' is not found as a first name."
fi
echo ${LAST_NAMES_ARRAY[1]}
