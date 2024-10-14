#!/bin/bash

# MySQL credentials
USER="root"

# Database and table names
DATABASE="StudentRegistration"
TABLE="student"

# Create the database if it doesn't exist
sudo mysql -u $USER -e "CREATE DATABASE IF NOT EXISTS $DATABASE;"

# Create the table if it doesn't exist
sudo mysql -u $USER -D $DATABASE -e "CREATE TABLE IF NOT EXISTS $TABLE (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50)
);"

# Insert student names
sudo mysql -u $USER -D $DATABASE -e "INSERT INTO $TABLE (first_name, last_name) VALUES
    ('John', 'Doe'),
    ('Jane', 'Smith'),
    ('Michael', 'Johnson'),
    ('Emily', 'Davis'),
    ('David', 'Wilson');"

echo "Database and table setup complete. 5 students have been added."

