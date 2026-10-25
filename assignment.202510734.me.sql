-- Assignment III: SQL Practical Exercise
-- Project: Student Registration System
-- PostgreSQL / pgAdmin 4
--
-- IMPORTANT: This is a consolidated submission script for review.
-- Run only in a NEW/EMPTY database. Do NOT run the entire file in your
-- existing database, because tables/data may already exist.
-- Verify sample values against your assignment instructions before submission.

-- Q1: Create tables
CREATE TABLE students (
    student_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    first_name VARCHAR(40),
    last_name VARCHAR(40),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20)
);

CREATE TABLE courses (
    course_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    course_name VARCHAR(80),
    department VARCHAR(60),
    fee NUMERIC(8,2)
);

CREATE TABLE enrollments (
    enrollment_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    student_id INTEGER REFERENCES students(student_id),
    course_id INTEGER REFERENCES courses(course_id),
    enrollment_date DATE,
    status VARCHAR(20) CHECK (status IN ('Active', 'Completed', 'Pending'))
);

-- Sample data
INSERT INTO students (first_name, last_name, email, phone) VALUES
('Aline', 'Uwimana', 'aline.uwimana@example.com', '0780000001'),
('Jean', 'Niyonsenga', 'jean.niyonsenga@example.com', '0780000002'),
('Marie', 'Mukamana', 'marie.mukamana@example.com', '0780000003'),
('Eric', 'Habimana', 'eric.habimana@example.com', '0780000004'),
('Grace', 'Ingabire', 'grace.ingabire@example.com', '0780000005');

INSERT INTO courses (course_name, department, fee) VALUES
('Database Systems', 'Information Technology', 150000.00),
('Programming Fundamentals', 'Computer Science', 120000.00),
('Networking', 'Information Technology', 130000.00),
('Web Development', 'Computer Science', 110000.00),
('Data Analytics', 'Information Technology', 140000.00);

INSERT INTO enrollments (student_id, course_id, enrollment_date, status) VALUES
(1, 1, '2026-10-01', 'Active'),
(2, 2, '2026-10-02', 'Active'),
(3, 3, '2026-10-03', 'Completed'),
(4, 4, '2026-10-04', 'Pending'),
(5, 5, '2026-10-05', 'Active');

-- Q1: SELECT tasks
-- Q1.1
SELECT * FROM students;
-- Q1.2
SELECT * FROM courses;
-- Q1.3
SELECT * FROM enrollments;

-- Q2: JOIN tasks
-- Q2.1
SELECT s.student_id, s.first_name, s.last_name,
       e.enrollment_id, e.enrollment_date, e.status
FROM students AS s
JOIN enrollments AS e ON e.student_id = s.student_id;

-- Q2.2
SELECT c.course_id, c.course_name, s.first_name, s.last_name,
       e.enrollment_date, e.status
FROM courses AS c
JOIN enrollments AS e ON e.course_id = c.course_id
JOIN students AS s ON s.student_id = e.student_id;

-- Q2.3
SELECT s.student_id, s.first_name, s.last_name, c.course_name,
       c.department, e.enrollment_date, e.status
FROM enrollments AS e
JOIN students AS s ON s.student_id = e.student_id
JOIN courses AS c ON c.course_id = e.course_id;

-- Q3: UPDATE tasks
-- Q3.1
UPDATE students
SET phone = '0780999999'
WHERE first_name = 'Aline' AND last_name = 'Uwimana';

-- Q3.2
UPDATE enrollments
SET status = 'Pending'
WHERE status = 'Active';

-- Q3.3
UPDATE courses
SET fee = fee * 0.90
WHERE fee > 120000;

-- Q4: ALTER TABLE tasks
-- Q4.1
ALTER TABLE students RENAME COLUMN phone TO phone_number;
-- Q4.2
ALTER TABLE courses ALTER COLUMN course_name TYPE VARCHAR(120);
-- Q4.3
ALTER TABLE courses
ADD COLUMN course_level VARCHAR(20) NOT NULL DEFAULT 'Undergraduate';

-- Q5: Additional INSERT tasks
-- Q5.1
INSERT INTO students (first_name, last_name, email, phone_number)
VALUES ('Test', 'Student', 'test.student@example.com', '0780888888');

-- Q5.2
INSERT INTO courses (course_name, department, fee, course_level) VALUES
('Mobile App Development', 'Information Technology', 160000.00, 'Undergraduate'),
('Cybersecurity Basics', 'Information Technology', 170000.00, 'Undergraduate');

-- Q5.3: Verify/adjust IDs if your database uses different IDs
INSERT INTO enrollments (student_id, course_id, enrollment_date, status)
VALUES (1, 1, CURRENT_DATE, 'Pending');

-- Final verification
SELECT * FROM students;
SELECT * FROM courses;
SELECT * FROM enrollments;

-- End of Assignment III SQL Practical Exercise
