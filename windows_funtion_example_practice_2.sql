##############	WINDOW ###################
CREATE DATABASE IF NOT EXISTS StudentDB;

USE StudentDB;

CREATE TABLE IF NOT EXISTS Students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    batch INT,
    name VARCHAR(255),
    stream VARCHAR(50),
    marks FLOAT,
    mail_id VARCHAR(255)
);
USE StudentDB;

INSERT INTO Students (batch, name, stream, marks, mail_id) VALUES
(2022, 'John Doe', 'Science', 85.5, 'john.doe@example.com'),
(2023, 'Alice Smith', 'Engineering', 78.2, 'alice.smith@example.com'),
(2022, 'Bob Johnson', 'Arts', 65.9, 'bob.johnson@example.com'),
(2024, 'Emily Brown', 'Commerce', 92.0, 'emily.brown@example.com'),
(2023, 'Michael Wilson', 'Science', 81.7, 'michael.wilson@example.com'),
(2024, 'Sarah Lee', 'Engineering', 76.3, 'sarah.lee@example.com'),
(2022, 'David Taylor', 'Arts', 71.8, 'david.taylor@example.com'),
(2023, 'Emma Martinez', 'Commerce', 89.5, 'emma.martinez@example.com'),
(2024, 'James Anderson', 'Science', 88.1, 'james.anderson@example.com'),
(2022, 'Olivia Rodriguez', 'Engineering', 79.6, 'olivia.rodriguez@example.com');
SELECT MAX(MARKS),STREAM FROM STUDENTS
GROUP BY STREAM;
SELECT *,AVG(MARKS) OVER(partition by BATCH) FROM STUDENTS
;
-- WHOS HAS RECEIVED HIGHEST,2ND HIGHEST MARKS;
SELECT *, RANK() OVER(partition by MARKS order by MARKS ASC ) FROM STUDENTS;
SELECT * FROM studentS
order  BY STREAM;
SELECT NAME,MARKS,STREAM FROM studentS
WHERE MARKS IN(
SELECT MAX(MARKS) FROM STUDENTS
GROUP BY STREAM
ORDER BY STREAM 
LIMIT 2,1);
SELECT * FROM STUDENTS
WHERE STREAM="Engineering"
order by MARKS DESC
LIMIT 2,1;
select * from (SELECT Name,stream,marks, row_number() over(partition by stream order by marks  )  as 'row_num'from students
) as test
where row_num =1;

SELECT *
FROM (
    SELECT Name, stream, marks, ROW_NUMBER() OVER (PARTITION BY stream ORDER BY marks desc) AS 'row_num'
    FROM students
) AS test
WHERE row_num = 1;

