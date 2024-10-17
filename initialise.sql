-- Step 1: Delete database if it exists then create it
DROP DATABASE IF EXISTS StudentRegistration;
CREATE DATABASE StudentRegistration;

-- Step 2: Use the newly created database
USE StudentRegistration;

-- Step 3: Create the Users table
CREATE TABLE IF NOT EXISTS Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(32) NOT NULL,  -- MD5 hashes are 32 characters long
    role ENUM('admin', 'student') NOT NULL
);

-- Step 4: Create the Students table with independent student_id
CREATE TABLE IF NOT EXISTS Students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,  -- Independent auto-incrementing primary key
    user_id INT,  -- Foreign key to Users table
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(15),
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

-- Step 5: Create the Courses table
CREATE TABLE IF NOT EXISTS Courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_code VARCHAR(10) NOT NULL UNIQUE,
    course_name VARCHAR(100) NOT NULL,
    description TEXT,
    credits INT NOT NULL
);

-- Step 6: Create the Registrations table with registration_date
CREATE TABLE IF NOT EXISTS Registrations (
    registration_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    course_id INT,
    registration_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES Students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES Courses(course_id) ON DELETE CASCADE,
    UNIQUE (student_id, course_id)  -- Prevents duplicate registrations
);

-- Step 7: Insert dummy values into Users
INSERT INTO Users (username, password, role) VALUES 
('admin', MD5('admin'), 'admin'),
('student1', MD5('student'), 'student'),
('student2', MD5('student'), 'student'),
('student3', MD5('student'), 'student');

-- Step 8: Insert additional details into the Students table using user_id as foreign key
INSERT INTO Students (user_id, name, email, phone) VALUES 
((SELECT user_id FROM Users WHERE username = 'student1'), 'John Doe', 'john.doe@example.com', '1234567890'),
((SELECT user_id FROM Users WHERE username = 'student2'), 'Jane Smith', 'jane.smith@example.com', '0987654321'),
((SELECT user_id FROM Users WHERE username = 'student3'), 'Emily Johnson', 'emily.johnson@example.com', '1122334455');

-- Step 9: Insert dummy values into Courses
INSERT INTO Courses (course_code, course_name, description, credits) VALUES 
('CS101', 'Introduction to Computer Science', 'Learn the basics of computer science.', 3),
('MATH101', 'Calculus I', 'An introduction to calculus concepts and techniques.', 4),
('ENG101', 'English Composition', 'Develop writing skills and techniques.', 3),
('HIST101', 'World History', 'Overview of world history from ancient to modern times.', 3);

-- Step 10: Register students for courses with registration dates
INSERT INTO Registrations (student_id, course_id) VALUES 
((SELECT student_id FROM Students WHERE name = 'John Doe'), (SELECT course_id FROM Courses WHERE course_code = 'CS101')),
((SELECT student_id FROM Students WHERE name = 'Jane Smith'), (SELECT course_id FROM Courses WHERE course_code = 'MATH101')),
((SELECT student_id FROM Students WHERE name = 'Emily Johnson'), (SELECT course_id FROM Courses WHERE course_code = 'ENG101'));

-- Optional: Verify the data inserted
SELECT * FROM Users;
SELECT * FROM Students;
SELECT * FROM Courses;
SELECT * FROM Registrations;
