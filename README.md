# Student Registration Project

# Project Modules

## 1. Authentication and Authorization Module (Mahammad)
**Description:** This module is responsible for user login and account creation, ensuring that students and admins are correctly authenticated and authorized.

**Key Features:**
- Implement student and admin login.
- Account creation for students (admins will not have the ability to create accounts for themselves; they'll be predefined in the database).
- Maintain user roles (student/admin) in the database.
- Validate logins (check whether the user is a student or admin) and route them to the appropriate menu.

**Database Work:**
- Create a `Users` table that stores login information, along with role identifiers for students and admins.
  
**Shell Scripts:**
- `create_account.sh`: For students to create accounts.
- `login.sh`: For both students and admins to log in.
- `auth.sh`: Handle session and role-based redirection (i.e., send students to student menu and admins to admin menu).

## 2. Student Operations Module (Szymon)
**Description:** This module is responsible for all operations that students can perform after they log in, such as registering and withdrawing from courses.

**Key Features:**
- Once logged in as a student, allow them to:
- View available courses.
- Register themselves for courses.
- Withdraw from courses they are already registered for.
- Create the student interface to interact with the system.

**Database Work:**
- Create and manage the `Registration` table that records the courses a student is enrolled in.
- Query courses and student-course relationships.

**Shell Scripts:**
- `view_courses.sh`: Display available courses to the student.
- `register_course.sh`: Register the logged-in student for a course.
- `withdraw_course.sh`: Withdraw the student from a course.
- Ensure all operations are linked to the logged-in student's account.

## 3. Admin Operations Module (Ahmed)
**Description:** The admin is responsible for managing the system data, including creating, viewing, and deleting both student and course records. Admins can also register/unregister students from courses.

**Key Features:**
- Once logged in as an admin, allow them to:
- View all students and courses.
- Create/Delete courses.
- Create/Delete students.
- Register/Unregister students for courses (i.e., admin-based registration management).
- Admin interface for the system.

**Database Work:**
- Manage the `Student` and `Course` tables and update student-course relationships.
- Create and delete records in the respective tables.

**Shell Scripts:**
- `create_course.sh`: Add a new course to the system.
- `delete_course.sh`: Remove a course.
- `create_student.sh`: Add a new student (if necessary).
- `delete_student.sh`: Remove a student.
- `admin_register_student.sh`: Register a student for a course.
- `admin_unregister_student.sh`: Unregister a student from a course.

# Database Tables

## 1. Users Table
This table stores authentication details for both students and admins.

| Column      | Data Type         | Description                                                         |
|-------------|-------------------|---------------------------------------------------------------------|
| user_id     | INT (PK)          | Auto-incremented primary key for each user.                        |
| username     | VARCHAR(50)       | Unique username for the user.                                      |
| password    | VARCHAR(255)      | Hashed password for authentication.                                 |
| role        | ENUM('student', 'admin') | Defines whether the user is a student or admin.                |

**Primary Key:** `user_id`  
**Purpose:** Handles authentication and role-based access.

---

## 2. Students Table
This table holds additional information about students. It links to the Users table for authentication and login purposes.

| Column      | Data Type         | Description                                                         |
|-------------|-------------------|---------------------------------------------------------------------|
| student_id  | INT (PK)          |  Auto-incremented primary key for each user.                       |
| user_id     | INT (FK)          | References `user_id` from the Users table.                         |
| name        | VARCHAR(100)      | Full name of the student.                                          |
| email       | VARCHAR(100)      | Email address of the student.                                      |
| phone       | VARCHAR(20)       | Contact number of the student.                                     |

**Primary Key:** `student_id`  
**Foreign Key:** `user_id` references `user_id` in the Users table.  
**Purpose:** Stores detailed information about students, including contact details.

---

## 3. Courses Table
This table stores details of courses that students can register for.

| Column      | Data Type         | Description                                                         |
|-------------|-------------------|---------------------------------------------------------------------|
| course_id   | INT (PK)          | Auto-incremented primary key for each course.                     |
| course_code  | VARCHAR(10)       | Unique course code (e.g., CS101).                                 |
| course_name | VARCHAR(100)      | The name of the course.                                           |
| description  | VARCHAR(100)      | A description of the course.                                    |
| credits     | INT               | Number of credits the course is worth.                             |

**Primary Key:** `course_id`  
**Purpose:** Stores all course-related details such as the course code, instructor, and credit value.

---

## 4. Registrations Table
This table manages the many-to-many relationship between students and courses. Each entry represents a student’s registration for a specific course.

| Column             | Data Type         | Description                                                         |
|--------------------|-------------------|---------------------------------------------------------------------|
| registration_id     | INT (PK)         | Auto-incremented primary key for each registration record.         |
| student_id         | INT (FK)         | References `student_id` from the Students table.                   |
| course_id          | INT (FK)         | References `course_id` from the Courses table.                     |
| registration_date   | DATE             | The date the student registered for the course.                    |

**Primary Key:** `registration_id`  
**Foreign Keys:**
- `student_id` references `student_id` in the Students table.
- `course_id` references `course_id` in the Courses table.  
**Purpose:** Links students to the courses they have registered for and tracks the registration date.

---

## Database Relationships:
- **Users → Students:** One-to-one relationship where each student has a user account (`student_id` is a foreign key in the Students table).
- **Students → Registrations:** One-to-many relationship where a student can register for multiple courses.
- **Courses → Registrations:** One-to-many relationship where a course can have multiple students registered.
- **Registrations:** Acts as the bridge for the many-to-many relationship between Students and Courses.

## Codespaces:

- Run the following command to start mysql service.
```
sudo service mysql start
```
- You can access the sql cli by running the following command. There is no password.
```
sudo mysql -u root -p
```

