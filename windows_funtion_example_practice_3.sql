SELECT * FROM windows.salesdata;
CREATE TABLE students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    branch VARCHAR(50),
    marks INT
);
INSERT INTO students (name, branch, marks) VALUES
('John Doe', 'Computer Science', 85),
('Jane Smith', 'Electrical Engineering', 78),
('Alice Johnson', 'Mechanical Engineering', 92),
('Bob Williams', 'Chemical Engineering', 79),
('Emily Brown', 'Computer Science', 88),
('Michael Davis', 'Electrical Engineering', 95),
('Sarah Wilson', 'Mechanical Engineering', 82),
('David Miller', 'Chemical Engineering', 87),
('Jennifer Taylor', 'Computer Science', 91),
('Kevin Anderson', 'Electrical Engineering', 84),
('Amanda Martinez', 'Mechanical Engineering', 89),
('James Thompson', 'Chemical Engineering', 76),
('Elizabeth Lee', 'Computer Science', 93),
('Christopher Garcia', 'Electrical Engineering', 90),
('Laura Hernandez', 'Mechanical Engineering', 85),
('Matthew Martinez', 'Chemical Engineering', 88),
('Jessica Lopez', 'Computer Science', 87),
('Daniel Gonzalez', 'Electrical Engineering', 92),
('Ashley Perez', 'Mechanical Engineering', 80),
('Joshua Torres', 'Chemical Engineering', 81),
('Sophia Rivera', 'Computer Science', 86),
('Andrew Moore', 'Electrical Engineering', 94),
('Olivia Sanchez', 'Mechanical Engineering', 83),
('William Johnson', 'Chemical Engineering', 89),
('Isabella Young', 'Computer Science', 90),
('Joseph Reed', 'Electrical Engineering', 88),
('Mia Scott', 'Mechanical Engineering', 91),
('Ethan Hill', 'Chemical Engineering', 82),
('Madison King', 'Computer Science', 92);
##############################################################################################################
-- windows funtion practice from campusx --
-- AVG MARKS FOR ALL BRANCH
select * ,
AVG(MARKS) OVER(partition by BRANCH) from students
;
##############################################################################################################
-- FIND ALL STUDENTS WHO HAVE MARKS HIGHER THAN AVG MARK FROM THEIR REPECTIVE BRANCH
SELECT * FROM students
where marks > (select avg(marks) from students)
group by branch;

-- windows
-- over clause work exactly like group by only difference is we get result line by line 
select * from 
(
select *,
		avg(marks) over(partition by branch) as avg_marks_brach
	from students
) as t
;

-- find min(marks) over (partion by branch) 
-- find max(marks) over (partion by branch) 

##############################################################################################################
-- AGGREGATION FUNTION WITH OVER()
select * from 
(
select *,
		avg(marks) over(partition by branch) as avg_marks_brach,
        rank() over(partition by branch order by marks desc) as rank_within_branch
	from students
) as t
where ranks=1
;
--- RANK OVER ALL---
select * ,
rank() over(order by marks desc) from students;

--- RANK OVER ALL--- partition by -- branch

select * ,
rank() over(partition by branch order by marks desc) from students;

-- dense rank--

-- row number --- 
select *,
row_number() over() from students;


select * ,
row_number() over(partition by branch order by marks desc) 
from students;
-- concation funtion 
select * ,
concat(branch,'-', row_number() over(partition by branch order by marks desc) )
from students;

--
-- find top 2 paying coustomer of each month == good question to solve
-- create roll no from  branch and marks
##############################################################################################################
"""
FIRST_VALUE/LAST_VALUE/NTH_VALUE
"""

SELECT *,concat(first_value(marks) over(order by marks desc),'-' ,
first_value(name) over(order by marks desc) )FROM STUDENTS;

select * , first_value(name) over(order by marks desc)  from students;
select * , first_value(marks) over(order by marks desc)  from students;

select * , first_value(marks) over(partition by branch order by marks desc)  from students;
#####	LAST_VALUE ####
-- COMPLETLY OPPOSITE OF FIRST_VALUE

FRAME IS MOST IMP TOPIC 
##### NTH_VALUE #######







