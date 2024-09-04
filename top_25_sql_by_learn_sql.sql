select * from ranking4
order by department;
-- Create the Employees table
CREATE TABLE ranking4 (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(50),
    salary DECIMAL(10, 2)
);

-- Insert data into the Employees table
INSERT INTO ranking4 (id, name, department, salary) VALUES
(100, 'Mary Johns', 'SALES', 1000.00),
(101, 'Sean Moldy', 'IT', 1500.00),
(102, 'Peter Dugan', 'SALES', 2000.00),
(103, 'Lilian Penn', 'SALES', 1700.00),
(104, 'Milton Kowarsky', 'IT', 1800.00),
(105, 'Mareen Bisset', 'ACCOUNTS', 1200.00),
(106, 'Airton Graue', 'ACCOUNTS', 1100.00);
-- Let’s use it to rank salaries within departments:
select *,
rank() over(partition by department order by salary)
from ranking4;

select id,name,salary,department,
salary /
max(salary) over(partition by department) as salary_metric,
		--  how each employee's salary compares to the maximum salary within their department
		--  It provides insight into the salary distribution within each department and helps identify employees whose salaries are relatively
		-- high or low compared to their peers in the same department
max(salary) over(partition by department)/salary  as  revers_salary_metric
from ranking4
order by salary_metric;

####################################################################################################################################
-- https://learnsql.com/blog/25-advanced-sql-query-examples/-- 
-- Create table statement
CREATE TABLE emp_learn_sql (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    dept_id VARCHAR(50),
    manager_id INT,
    salary DECIMAL(10, 2),
    expertise VARCHAR(50)
);

-- Insert into statement
INSERT INTO emp_learn_sql (employee_id, first_name, last_name, dept_id, manager_id, salary, expertise) VALUES
(100, 'John', 'White', 'IT', 103, 120000.00, 'Senior'),
(101, 'Mary', 'Danner', 'Account', 109, 80000.00, 'Junior'),
(102, 'Ann', 'Lynn', 'Sales', 107, 140000.00, 'Semisenior'),
(103, 'Peter', 'O''connor', 'IT', 110, 130000.00, 'Senior'),
(106, 'Sue', 'Sanchez', 'Sales', 107, 110000.00, 'Junior'),
(107, 'Marta', 'Doe', 'Sales', 110, 180000.00, 'Senior'),
(109, 'Ann', 'Danner', 'Account', 110, 90000.00, 'Senior'),
(110, 'Simon', 'Yang', 'CEO', NULL, 250000.00, 'Senior'),
(111, 'Juan', 'Graue', 'Sales', 102, 37000.00, 'Junior');

DELIMITER //

CREATE PROCEDURE emp_learn_sql()
BEGIN
    SELECT * FROM emp_learn_sql;
END //

DELIMITER ;
call emp_learn_sql;

-- Example #1 - Ranking Rows Based on a Specific Ordering Criteria
select *,
rank() over(order by salary desc) from emp_learn_sql;

-- Example #2 - List The First 5 Rows of a Result Set
select * from(
select *,
rank() over(order by salary desc) as rank_salary from emp_learn_sql ) as temp
order by rank_salary 
limit 5 
;

select * from(
select *,
rank() over(order by salary desc) as rank_highest_salary from emp_learn_sql ) as temp
where rank_highest_salary <=5 
order by rank_highest_salary 
;
-- Example #3 - List the Last 5 Rows of a Result Set
select * from(
select *,
rank() over(order by salary asc) as rank_lowest_salary from emp_learn_sql ) as temp
order by rank_lowest_salary 
limit 5 
;

-- Example #4 - List The Second Highest Row of a Result Set
--  it might possiblt that we have same salary for more than one employee then for safaty purpose we can use rank with out row_number
-- dense_rank   
call emp_learn_sql;
select * from (select * ,
rank() over(order by salary desc) as row_number_salary_desc 
from emp_learn_sql) as temp 
where row_number_salary_desc =2;

-- Example #5 - List the Second Highest Salary By Department
select * from (
select * ,
rank() over(partition by dept_id order by salary desc) as row_number_salary_desc 
from emp_learn_sql
) as temp 
where row_number_salary_desc =2;
-- Example #6 - List the First 50% Rows in a Result Set
select * from
(select *,
ntile(2) over(order by salary ) as ntiles
from emp_learn_sql
) as temp
where ntiles=1 
order by salary desc;
-- Example #7 - List the Last 25% Rows in a Result Set
select * from
(select *,
ntile(4) over(order by salary ) as ntiles
from emp_learn_sql
) as temp
where ntiles=4
order by salary desc;
-- Example #8 - Number the Rows in a Result Set
select * ,
row_number() over(order by employee_id )
from emp_learn_sql;

-- Example #9 - List All Combinations of Rows from Two Tables --  cross join
-- solve kr kela nahi solve	
-- Create the product table
CREATE TABLE product_learn_sql (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(50),
    price DECIMAL(10, 2)
);

-- Insert sample data into the product table
INSERT INTO product_learn_sql (product_name, price) VALUES
('corn flakes', 5.99),
('sugared corn flakes', 6.99),
('rice flakes', 4.99),
('corn flakes', 5.99),
('sugared corn flakes', 6.99),
('rice flakes', 4.99),
('corn flakes', 5.99),
('sugared corn flakes', 6.99),
('rice flakes', 4.99),
('corn flakes', 5.99);

-- Create the box_size table
CREATE TABLE box_size_learn_sql (
    box_id INT AUTO_INCREMENT PRIMARY KEY,
    box_size VARCHAR(20),
    price DECIMAL(10, 2)
);

-- Insert sample data into the box_size table
INSERT INTO box_size_learn_sql (box_size, price) VALUES
('1 pound', 2.99),
('3 pounds', 7.99),
('5 pounds', 10.99),
('1 pound', 2.99),
('3 pounds', 7.99),
('5 pounds', 10.99),
('1 pound', 2.99),
('3 pounds', 7.99),
('5 pounds', 10.99),
('1 pound', 2.99);

-- Example #10 – Join a Table to Itself
-- Example #11 – Show All Rows with an Above-Average Value
call emp_learn_sql;
select * from emp_learn_sql
where salary > (
select avg(salary) from emp_learn_sql
)
;
-- Example #12 – Employees with Salaries Higher Than Their Departmental Average
								select * from emp_learn_sql e1 					-- not understand properly	
								where salary > (
								select  avg(salary) from emp_learn_sql e2
								where e1. dept_id=e2.dept_id
								);

select * from (
 select *, 
 round(avg(salary) over(partition by dept_id)) avg_dept_salary  from emp_learn_sql 
 ) as temp 
 where salary > avg_dept_salary 
 ;
 
 -- Example #13 – Obtain All Rows Where a Value Is in a Subquery Result 
 -- we have two table emp_detaits, departmet in that (manager is comman)
 call  emp_learn_sql;
 
 -- Example #14 – Find Duplicate Rows in SQL
 select manager_id,expertise from emp_learn_sql  -- execute line by line then see result
 group by  manager_id,expertise 
 having count(*) > 1;
 -- Example #15 – Count Duplicate Rows

  select manager_id,expertise,count(*) from emp_learn_sql -- proper logic samjun ghe
 group by  manager_id,expertise 
 having count(*) > 1;
 
 -- Example #16 – Find Common Records Between Tables -- inner join
 
 -- Example #17 – Grouping Data with ROLLUP  -- 
 SELECT 
  dept_id,
  expertise,
  SUM(salary) total_salary
FROM    emp_learn_sql
GROUP BY dept_id, expertise;
-- Example #17 – Grouping Data with ROLLUP
-- Example #18 – Conditional Summation -- sum with specific condition
call emp_learn_sql;
use windows;

select 
sum(case when dept_id in ('it','account') then salary else 0 end ),
sum(case when dept_id in ('sales','ceo') then salary else 0 end )
from emp_learn_sql;

-- Example #19 – Group Rows by a Range
call emp_learn_sql;
select count(*),
case when salary <= 50000 and salary < 100000 then 'low' 
	 when salary > 50000 and salary < 100000 then 'low+'
	 when salary >= 100000 and salary < 150000 then 'medium'
	 when   salary > 150000 then 'high'
	 end as salary_distribution
     from emp_learn_sql
     group by 
     case when salary <= 50000  then 'low' 
          when salary > 50000 and salary < 100000 then 'low+'
		  when salary >= 100000 and salary < 150000 then 'medium'
          when   salary > 150000 then 'high'
	 end;
-- Example #20 – Compute a Running Total in SQL

select *  from ranking2;
select *, sum(points) over() from ranking;
select *, sum(sales) over(partition by city ) as running_total from ranking2
order by running_total desc ;
select *, sum(salary) over(partition by department) from ranking4;

-- Example #21 – Compute a Moving Average in SQL
select *, avg(points) over() from ranking;
select *, avg(salary) over(partition by department) from ranking4;
select *, avg(sales) over(partition by city ) as running_total from ranking2
order by running_total desc ;
################################################################################################################
	-- MOST IMP MOST ADVANCE FOR ME
-- Example #22 – Compute a Difference (Delta) Between Two Columns on Different Rows
-- Example #23 – Compute a Year-Over-Year Difference
-- Example #24 – Use Recursive Queries to Manage Data Hierarchies
-- Example #25 – Find the Length of a Series Using Window Functions


use windows;
select * from ranking4;             
select department,salary
from ranking4
group by department,salary 
union all
select department,null salary
from ranking4
group by department,salary ;
select department,salary,rollup(department,salary)

from ranking4;
alter table ranking4 add column country varchar(50);
update  ranking4 set country='usa' where id=100;
update  ranking4 set country='india' where id=101;
update  ranking4 set country='usa' where id=102;
update  ranking4 set country='chaina' where id=103;
update  ranking4 set country='usa' where id=104;
update  ranking4 set country='india' where id=105;
update  ranking4 set country='chaina' where id=106;
select rollup(department ,salary,country),sum(salary)
from ranking4;




SELECT department, sum(salary), country
FROM ranking4
GROUP BY department, salary, country WITH rollup
UNION ALL 
SELECT NULL department, sum(salary), country
FROM ranking4
GROUP BY department, salary, country;

