CREATE database XXX;
USE XXX;

CREATE TABLE Student (
    StudentID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Age INT,
    Grade VARCHAR(2),
    MARKS INT,
    BRANCH VARCHAR(50)
);
INSERT INTO Student (StudentID, FirstName, LastName, Age, Grade, Marks, Branch) 
VALUES 
(21, 'David', 'Wilson', 20, 'A', 85.50, 'Computer Science'),
(22, 'Sophie', 'Johnson', 21, 'B', 78.00, 'Electrical Engineering'),
(23, 'Ryan', 'Brown', 19, 'C', 69.75, 'Mechanical Engineering'),
(24, 'Chloe', 'Garcia', 20, 'A', 92.25, 'Chemistry'),
(25, 'Samuel', 'Miller', 22, 'B', 81.50, 'Physics'),
(26, 'Grace', 'Martinez', 19, 'C', 67.75, 'Biology'),
(27, 'Luke', 'Hernandez', 20, 'A', 88.75, 'Mathematics'),
(28, 'Lily', 'Lopez', 21, 'B', 75.00, 'Computer Engineering'),
(29, 'Noah', 'Perez', 18, 'C', 63.25, 'Civil Engineering'),
(30, 'Hannah', 'Scott', 20, 'A', 90.00, 'Psychology'),
(31, 'Elijah', 'Adams', 19, 'B', 79.75, 'Sociology'),
(32, 'Avery', 'Taylor', 21, 'C', 68.50, 'English'),
(33, 'Sofia', 'Morris', 20, 'A', 87.25, 'History'),
(34, 'Jackson', 'Nelson', 22, 'B', 82.50, 'Political Science'),
(35, 'Aria', 'Carter', 19, 'C', 70.25, 'Economics'),
(36, 'Daniel', 'Roberts', 20, 'A', 91.75, 'Geology'),
(37, 'Evelyn', 'Cook', 21, 'B', 77.50, 'Environmental Science'),
(38, 'Gabriel', 'Parker', 18, 'C', 65.25, 'Anthropology'),
(39, 'Mason', 'Wright', 20, 'A', 89.50, 'Philosophy'),
(40, 'Harper', 'Evans', 19, 'B', 80.25, 'Fine Arts');
SELECT * FROM Student;
SELECT * ,first_value(marks) OVER(partition by grade ORDER BY MARKS DESC) FROM STUDENT;
 SELECT * ,last_value(marks) OVER(ORDER BY MARKS DESC) FROM STUDENT;
 SELECT * , lag(marks) over(order by studentid),
 lead(marks) over(order by studentid)
 FROM Student;
 
 

 




