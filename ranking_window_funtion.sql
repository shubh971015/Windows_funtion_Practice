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

####################################################################################################################
use windows;
CREATE TABLE Movies (
    movie_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100),
    genre_id INT,
    FOREIGN KEY (genre_id) REFERENCES Genres(genre_id)
);
CREATE TABLE Genres (
    genre_id INT AUTO_INCREMENT PRIMARY KEY,
    genre_name VARCHAR(50)
);

INSERT INTO Genres (genre_name) VALUES
('Action'),
('Comedy'),
('Drama');

INSERT INTO Movies (title, genre_id) VALUES
('Movie 1', 1),
('Movie 2', 2),
('Movie 3', 1),
('Movie 4', 2),
('Movie 5', 3);
CREATE TABLE Rentals (
    rental_id INT AUTO_INCREMENT PRIMARY KEY,
    movie_id INT,
    rental_date DATE,
    payment_amount DECIMAL(8, 2),
    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id)
);

INSERT INTO Rentals (movie_id, rental_date, payment_amount) VALUES
(1, '2024-01-01', 10.50),
(2, '2024-01-02', 12.75),
(3, '2024-01-03', 8.99),
(4, '2024-01-04', 14.25),
(5, '2024-01-05', 9.99),
(1, '2024-01-06', 11.75),
(2, '2024-01-07', 10.99),
(3, '2024-01-08', 13.50),
(4, '2024-01-09', 11.25),
(5, '2024-01-10', 9.75);

UPDATE Movies SET title = 'The Matrix' WHERE movie_id = 1;
UPDATE Movies SET title = 'Pulp Fiction' WHERE movie_id = 2;
UPDATE Movies SET title = 'Forrest Gump' WHERE movie_id = 3;
UPDATE Movies SET title = 'The Shawshank Redemption' WHERE movie_id = 4;
UPDATE Movies SET title = 'Inception' WHERE movie_id = 5;
select * from movies;
select * from genres;
select * from rentals;
use windows;
select *,
rank() over(partition by genre_name order by payment_amount desc)
from(
select m.movie_id,g.genre_name,r.payment_amount
from movies m
join genres g
	on m.genre_id=g.genre_id
join rentals r
	on m.Movie_id=r.Movie_id)as temp;
###########
-- learnsql https://learnsql.com/blog/how-to-rank-rows-in-sql/#:~:text=The%20RANK()%20function%20creates,next%20spot%20is%20shifted%20accordingly.
CREATE TABLE Ranking (
    ranking INT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    points INT
);
INSERT INTO Ranking (ranking, first_name, last_name, points) VALUES
(1, 'Eryk', 'Myers', 90),
(2, 'Marius', 'Williamson', 90),
(2, 'Marius', 'Powell', 90),
(4, 'Marlene', 'Duncan', 90),
(5, 'Evie-May', 'Boyer', 80),
(6, 'Dina', 'Morin', 70),
(7, 'Emyr', 'Downes', 70),
(8, 'Nora', 'Parkinson', 60),
(9, 'Joanne', 'Goddard', 50),
(10, 'Trystan', 'Oconnor', 40);
select * from ranking;
select *,
rank() over(order by points desc,first_name asc )
from ranking;

-- rank ()  with top 20 records
INSERT INTO Ranking (ranking, first_name, last_name, points) VALUES
(11, 'Aiden', 'Ford', 99),
(12, 'Lara', 'Dean', 98),
(13, 'Koby', 'Edwards', 97),
(14, 'Karim', 'Ali', 96),
(15, 'Siobhan', 'Burns', 95),
(16, 'Aysha', 'Thornton', 94),
(17, 'Caiden', 'Crawford', 93),
(18, 'Elsa', 'Patel', 92),
(19, 'Reema', 'Khan', 91),
(20, 'Zara', 'Hussain', 99),
(21, 'Toby', 'Hawkins', 98),
(22, 'Lacey', 'Cooper', 97),
(23, 'Yasmin', 'Taylor', 96),
(24, 'Ibrahim', 'Rahman', 95),
(25, 'Lara', 'Hill', 94),
(26, 'Hamza', 'Ali', 93),
(27, 'Molly', 'Perry', 92),
(28, 'Roman', 'Fletcher', 91),
(29, 'Oscar', 'Davies', 99),
(30, 'Alyssa', 'Clark', 98);
select * from ranking;
########## top 20 records -- 
select * from (
select * ,
row_number() over(order by points desc) as rowss ,
dense_rank() over(order by points desc)
from ranking
) as temp
where  rowss <= 20 
;
##################################################################################################################################
-- ranking() by date
select * from ranking1;
select  *, 
rank() over(order by exam_date asc )
from ranking1;
CREATE TABLE Ranking1 (
    ranking INT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    exam_date date
);


INSERT INTO Ranking1 (ranking, first_name, last_name, exam_date) VALUES
(1, 'Emyr', 'Downes', '2018-12-18'),
(2, 'Evie-May', 'Boyer', '2019-01-23'),
(2, 'Dina', 'Morin', '2019-01-17'),
(4, 'Nora', 'Parkinson', '2019-02-16'),
(4, 'Trystan', 'Oconnor', '2019-02-28'),
(6, 'Marlene', 'Duncan', '2019-06-13'),
(6, 'Eryk', 'Myers', '2019-06-07'),
(8, 'Marius', 'Powell', '2019-11-13'),
(9, 'Joanne', 'Goddard', '2019-12-18'),
(10, 'Marius', 'Williamson', '2020-01-02');
###########
-- rank () over month
select * ,
extract(month from exam_date),
rank() over(order by extract(year from exam_date),extract(month from exam_date))
from ranking1
 ;
############
--- RANK OVER ALL---
select * ,
rank() over(order by marks desc) from students;
#####################################################################################################################
-- ranking With GROUP BY  (analyse group by and  partition by)
CREATE TABLE Ranking2(
    id INT AUTO_INCREMENT PRIMARY KEY,
    city VARCHAR(50),
    sales INT
);
INSERT INTO Ranking2 (city, sales) VALUES
('New York', 100),
('New York', 120),
('Los Angeles', 80),
('Los Angeles', 90),
('Chicago', 70),
('Chicago', 85),
('Houston', 110),
('Houston', 95),
('Phoenix', 60),
('Phoenix', 75),
('New York', 130),
('New York', 105),
('Los Angeles', 85),
('Los Angeles', 75),
('Chicago', 90),
('Chicago', 80),
('Houston', 100),
('Houston', 85),
('Phoenix', 65),
('Phoenix', 70),
('New York', 115),
('New York', 125),
('Los Angeles', 95),
('Los Angeles', 80),
('Chicago', 75),
('Chicago', 85),
('Houston', 105),
('Houston', 90),
('Phoenix', 70),
('Phoenix', 75);

select * from ranking2;
select id,city,sum(sales),
rank() over(order by sum(sales) desc)
from ranking2
group by city;


select id,city,sales,
rank() over(partition by city  order by sum(sales) desc)
from ranking2
;
SELECT id, city, SUM(sales),
RANK() OVER (ORDER BY SUM(sales) DESC)
FROM (
    SELECT id, city, sales,
    RANK() OVER (PARTITION BY city ORDER BY sales DESC) AS city_rank
    FROM Ranking2
) AS ranked_sales
GROUP BY city;

##################################################################################################################################
--- rank with count
select * from ranking2;
select *,count(sales),
rank() over( order by count(sales)) from ranking2
group by city; -- same number of sales done in citys

##################################################################################################################################
--- RANK() OVER(PARTITION BY ...)—Single Column
-- Create the table
CREATE TABLE Ranking3 (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ranking INT,
    city VARCHAR(50),
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    exam_date DATE
);

-- Insert data into the table
INSERT INTO Ranking3(ranking, city, first_name, last_name, exam_date) VALUES
(1, 'San Francisco', 'Eryk', 'Myers', '2019-06-07'),
(1, 'San Francisco', 'Evie-May', 'Boyer', '2019-01-23'),
(1, 'San Francisco', 'Emyr', 'Dowes', '2018-12-18'),
(1, 'Los Angeles', 'Dina', 'Morin', '2019-01-17'),
(1, 'Los Angeles', 'Trystan', 'Oconnor', '2019-02-28'),
(1, 'San Diego', 'Marlene', 'Duncan', '2019-06-13'),
(1, 'San Diego', 'Marius', 'Powell', '2019-11-13'),
(2, 'San Diego', 'Marius', 'Williamson', '2020-01-02'),
(1, 'San Diego', 'Nora', 'Parkinson', '2019-02-16'),
(1, 'San Diego', 'Joanne', 'Goddard', '2019-12-18'),
-- Add 7 more records with the same city (San Diego)
(1, 'San Diego', 'John', 'Doe', '2020-05-20'),
(1, 'San Diego', 'Alice', 'Smith', '2020-04-15'),
(1, 'San Diego', 'Michael', 'Johnson', '2020-03-10'),
(2, 'San Diego', 'Sarah', 'Williams', '2020-02-05'),
(1, 'San Diego', 'David', 'Brown', '2020-01-01'),
(1, 'San Diego', 'Jennifer', 'Jones', '2019-12-25'),
(1, 'San Diego', 'Robert', 'Davis', '2019-11-20');
select * from ranking3;-- here i copy resul datasets and so that we get ranking column as
-- RANK() OVER(PARTITION BY ...)—Single Column

select * from ranking2;
##################################################################################################################################
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


###############################################################################################################################
LEAD(expression [, offset [, default]]) OVER (ORDER BY ... ) 
LAG(expression [, offset [, default]]) OVER (ORDER BY ... )

LEAD OR LAG
USE WINDOWS;
select * FROM STUDENTS;
SELECT *,
LAG(MARKS) OVER(PARTITION BY BRANCH ORDER BY ID),
LEAD(MARKS) OVER(partition by BRANCH ORDER BY ID)
FROM STUDENTS;

-- ITS IMPORTANT WHEN TO FIND ROOLING CALCULATION
-- FIND MOM ON MONTH REVENUE OF ZOMATO
-- Create RESTAURANT table
CREATE TABLE RESTAURANT (
    restaurant_id INT AUTO_INCREMENT PRIMARY KEY,
    restaurant_name VARCHAR(100)
);

-- Create ORDER table
CREATE TABLE ORDERS (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    restaurant_id INT,
    order_date DATE,
    order_amount DECIMAL(10, 2),
    FOREIGN KEY (restaurant_id) REFERENCES RESTAURANT(restaurant_id)
);
-- Insert 5 more restaurants into RESTAURANT table
INSERT INTO RESTAURANT (restaurant_name) VALUES
('Restaurant D'),
('Restaurant E'),
('Restaurant F'),
('Restaurant G'),
('Restaurant H');

-- Insert 30 more order records into ORDER table
INSERT INTO ORDERS (restaurant_id, order_date, order_amount) VALUES
(4, '2024-03-10', 450.00),
(5, '2024-03-12', 620.00),
(6, '2024-03-15', 580.00),
(7, '2024-03-18', 700.00),
(8, '2024-03-20', 530.00),
(4, '2024-04-01', 480.00),
(5, '2024-04-03', 640.00),
(6, '2024-04-05', 600.00),
(7, '2024-04-08', 720.00),
(8, '2024-04-10', 550.00),
(4, '2024-05-01', 510.00),
(5, '2024-05-03', 660.00),
(6, '2024-05-05', 620.00),
(7, '2024-05-08', 750.00),
(8, '2024-05-10', 580.00),
(4, '2024-06-01', 540.00),
(5, '2024-06-03', 680.00),
(6, '2024-06-05', 640.00),
(7, '2024-06-08', 770.00),
(8, '2024-06-10', 610.00),
(4, '2024-07-01', 570.00),
(5, '2024-07-03', 700.00),
(6, '2024-07-05', 660.00),
(7, '2024-07-08', 800.00),
(8, '2024-07-10', 630.00),
(4, '2024-08-01', 600.00),
(5, '2024-08-03', 720.00),
(6, '2024-08-05', 680.00),
(7, '2024-08-08', 820.00),
(8, '2024-08-10', 650.00);
SELECT * FROM ORDERS;
SELECT * FROM RESTAURANT;

SELECT *,CONCAT(
ROUND(
((CURRENT_MONTH-PREVIOUS_MONTH)/ PREVIOUS_MONTH)*100,2),'%'
) AS MONTHLY_GROWTH  FROM
(
SELECT 
month(ORDER_DATE)AS MONTHS,
SUM(ORDER_AMOUNT) AS CURRENT_MONTH,
LAG(SUM(ORDER_AMOUNT)) OVER(ORDER BY month(ORDER_DATE)) AS PREVIOUS_MONTH
FROM ORDERS
group by month(ORDER_DATE)) TEMP;

-- We use an offset of 1 in the LAG function: LAG(SUM(ORDER_AMOUNT), 1)..
-- This means that we are retrieving the sum of order amounts from the previous row (previous month), as the default offset is 1. 

-- We use an offset of 3 in the LAG function: LAG(SUM(ORDER_AMOUNT), 3).. , 
-- you can set the offset to 3 (assuming you're working with a quarterly dataset) in this data sets we use monthly records.
-- This means that we are retrieving the sum of order amounts from the previous quarter.


CREATE TABLE YouTubeData (
    id INT AUTO_INCREMENT PRIMARY KEY,
    daily_views INT,
    date DATE
);

INSERT INTO YouTubeData (daily_views, date) VALUES
(6196, '2024-01-01'),
(8415, '2024-01-02'),
(6519, '2024-01-03'),
(1727, '2024-01-04'),
(1675, '2024-01-05'),
(2304, '2024-01-06'),
(1860, '2024-01-07'),
(8415, '2024-01-08'),
(9707, '2024-01-09'),
(8549, '2024-01-10'),
(7422, '2024-01-11'),
(4320, '2024-01-12'),
(4484, '2024-01-13'),
(6837, '2024-01-14'),
(4771, '2024-01-15'),
(4416, '2024-01-16'),
(3028, '2024-01-17'),
(7923, '2024-01-18'),
(6595, '2024-01-19'),
(1938, '2024-01-20'),
(1259, '2024-01-21'),
(9784, '2024-01-22'),
(6067, '2024-01-23'),
(1206, '2024-01-24'),
(7259, '2024-01-25'),
(5517, '2024-01-26'),
(7980, '2024-01-27'),
(2362, '2024-01-28'),
(5687, '2024-01-29'),
(7731, '2024-01-30'),
(4128, '2024-01-31'),
(6019, '2024-02-01'),
(3625, '2024-02-02'),
(3766, '2024-02-03'),
(6014, '2024-02-04'),
(5146, '2024-02-05'),
(4870, '2024-02-06'),
(8757, '2024-02-07'),
(3206, '2024-02-08'),
(4416, '2024-02-09'),
(3675, '2024-02-10'),
(1683, '2024-02-11'),
(4630, '2024-02-12'),
(6494, '2024-02-13'),
(1356, '2024-02-14'),
(9225, '2024-02-15'),
(5291, '2024-02-16'),
(5911, '2024-02-17'),
(9057, '2024-02-18'),
(1704, '2024-02-19'),
(1695, '2024-02-20'),
(6698, '2024-02-21'),
(5242, '2024-02-22'),
(8417, '2024-02-23'),
(7957, '2024-02-24'),
(4548, '2024-02-25'),
(9742, '2024-02-26'),
(2160, '2024-02-27'),
(1714, '2024-02-28'),
(8992, '2024-02-29'),
(7096, '2024-03-01'),
(1409, '2024-03-02'),
(9148, '2024-03-03'),
(6589, '2024-03-04'),
(3503, '2024-03-05'),
(4188, '2024-03-06'),
(6680, '2024-03-07'),
(3678, '2024-03-08'),
(6660, '2024-03-09'),
(7638, '2024-03-10'),
(9906, '2024-03-11'),
(2330, '2024-03-12'),
(1147, '2024-03-13'),
(7743, '2024-03-14'),
(7973, '2024-03-15'),
(6459, '2024-03-16'),
(2341, '2024-03-17'),
(8310, '2024-03-18'),
(2720, '2024-03-19'),
(5846, '2024-03-20'),
(3498, '2024-03-21'),
(1082, '2024-03-22'),
(1103, '2024-03-23'),
(1389, '2024-03-24'),
(2153, '2024-03-25'),
(2764, '2024-03-26'),
(9268, '2024-03-27'),
(6240, '2024-03-28'),
(6833, '2024-03-29'),
(3371, '2024-03-30'),
(6744, '2024-03-31'),
(5694, '2024-04-01'),
(7709, '2024-04-02'),
(5894, '2024-04-03'),
(6328, '2024-04-04'),
(2417, '2024-04-05'),
(3533, '2024-04-06'),
(2188, '2024-04-07'),
(7040, '2024-04-08'),
(2137, '2024-04-09'),
(5193, '2024-04-10'),
(7725, '2024-04-11'),
(8948, '2024-04-12'),
(7065, '2024-04-13'),
(5283, '2024-04-14'),
(2603, '2024-04-15'),
(5055, '2024-04-16'),
(8089, '2024-04-17'),
(6251, '2024-04-18'),
(6220, '2024-04-19'),
(9413, '2024-04-20'),
(8061, '2024-04-21'),
(2743, '2024-04-22'),
(1533, '2024-04-23'),
(7790, '2024-04-24'),
(6646, '2024-04-25'),
(8062, '2024-04-26'),
(7561, '2024-04-27'),
(9043, '2024-04-28'),
(9229, '2024-04-29'),
(9069, '2024-04-30'),
(7975, '2024-05-01'),
(6357, '2024-05-02'),
(3316, '2024-05-03'),
(4635, '2024-05-04'),
(7690, '2024-05-05'),
(6347, '2024-05-06'),
(6130, '2024-05-07'),
(3495, '2024-05-08'),
(8997, '2024-05-09'),
(3719, '2024-05-10'),
(2971, '2024-05-11'),
(7835, '2024-05-12'),
(8215, '2024-05-13'),
(9234, '2024-05-14'),
(6532, '2024-05-15'),
(4209, '2024-05-16'),
(8255, '2024-05-17'),
(1395, '2024-05-18'),
(7574, '2024-05-19'),
(9410, '2024-05-20'),
(6234, '2024-05-21'),
(5012, '2024-05-22'),
(1106, '2024-05-23'),
(8049, '2024-05-24'),
(6670, '2024-05-25'),
(5536, '2024-05-26'),
(3595, '2024-05-27'),
(7767, '2024-05-28'),
(5289, '2024-05-29'),
(9952, '2024-05-30'),
(3703, '2024-05-31'),
(4143, '2024-06-01'),
(5926, '2024-06-02'),
(8870, '2024-06-03'),
(4500, '2024-06-04'),
(7386, '2024-06-05'),
(4217, '2024-06-06'),
(6318, '2024-06-07'),
(5865, '2024-06-08'),
(8497, '2024-06-09'),
(5468, '2024-06-10'),
(7656, '2024-06-11'),
(9548, '2024-06-12'),
(4753, '2024-06-13'),
(6621, '2024-06-14'),
(3881, '2024-06-15'),
(9407, '2024-06-16'),
(7946, '2024-06-17'),
(5661, '2024-06-18'),
(1654, '2024-06-19'),
(6664, '2024-06-20'),
(6852, '2024-06-21'),
(8594, '2024-06-22'),
(5707, '2024-06-23'),
(2401, '2024-06-24'),
(8576, '2024-06-25'),
(3024, '2024-06-26'),
(7574, '2024-06-27'),
(7022, '2024-06-28'),
(7791, '2024-06-29'),
(4715, '2024-06-30'),
(2535, '2024-07-01'),
(8161, '2024-07-02'),
(3653, '2024-07-03'),
(6240, '2024-07-04'),
(5305, '2024-07-05'),
(6640, '2024-07-06'),
(1434, '2024-07-07'),
(1579, '2024-07-08'),
(9092, '2024-07-09'),
(2317, '2024-07-10'),
(8390, '2024-07-11'),
(5928, '2024-07-12'),
(3378, '2024-07-13'),
(7915, '2024-07-14'),
(7623, '2024-07-15'),
(2409, '2024-07-16'),
(9298, '2024-07-17'),
(7548, '2024-07-18'),
(6638, '2024-07-19'),
(9666, '2024-07-20'),
(8987, '2024-07-21'),
(1267, '2024-07-22'),
(2281, '2024-07-23'),
(3682, '2024-07-24'),
(4841, '2024-07-25'),
(3166, '2024-07-26'),
(8362, '2024-07-27'),
(3863, '2024-07-28'),
(4305, '2024-07-29'),
(8429, '2024-07-30'),
(1293, '2024-07-31'),
(2645, '2024-08-01'),
(6518, '2024-08-02'),
(7929, '2024-08-03'),
(4025, '2024-08-04'),
(3329, '2024-08-05'),
(2851, '2024-08-06'),
(7069, '2024-08-07'),
(6382, '2024-08-08'),
(2711, '2024-08-09'),
(7568, '2024-08-10'),
(8607, '2024-08-11'),
(6430, '2024-08-12'),
(1279, '2024-08-13'),
(6607, '2024-08-14'),
(4685, '2024-08-15'),
(6559, '2024-08-16'),
(8393, '2024-08-17'),
(1300, '2024-08-18'),
(8028, '2024-08-19'),
(8774, '2024-08-20'),
(6690, '2024-08-21'),
(9228, '2024-08-22'),
(1024, '2024-08-23'),
(9209, '2024-08-24'),
(4868, '2024-08-25'),
(8501, '2024-08-26'),
(6577, '2024-08-27'),
(8947, '2024-08-28'),
(7130, '2024-08-29'),
(8771, '2024-08-30'),
(8403, '2024-08-31'),
(7813, '2024-09-01'),
(4461, '2024-09-02'),
(3647, '2024-09-03'),
(9142, '2024-09-04'),
(8435, '2024-09-05'),
(3652, '2024-09-06'),
(8673, '2024-09-07'),
(1254, '2024-09-08'),
(3800, '2024-09-09'),
(9816, '2024-09-10'),
(1759, '2024-09-11'),
(7311, '2024-09-12'),
(6327, '2024-09-13'),
(8964, '2024-09-14'),
(1509, '2024-09-15'),
(9304, '2024-09-16'),
(8312, '2024-09-17'),
(5499, '2024-09-18'),
(5563, '2024-09-19'),
(4242, '2024-09-20'),
(4287, '2024-09-21'),
(9037, '2024-09-22'),
(9227, '2024-09-23'),
(4721, '2024-09-24'),
(4337, '2024-09-25'),
(5129, '2024-09-26'),
(2847, '2024-09-27'),
(2618, '2024-09-28'),
(7769, '2024-09-29'),
(9475, '2024-09-30'),
(6835, '2024-10-01'),
(2099, '2024-10-02'),
(1314, '2024-10-03'),
(5804, '2024-10-04'),
(3662, '2024-10-05'),
(5418, '2024-10-06'),
(4774, '2024-10-07'),
(9189, '2024-10-08'),
(6583, '2024-10-09'),
(6949, '2024-10-10'),
(2898, '2024-10-11'),
(7564, '2024-10-12'),
(4333, '2024-10-13'),
(9337, '2024-10-14'),
(2309, '2024-10-15'),
(9032, '2024-10-16'),
(1372, '2024-10-17'),
(3414, '2024-10-18'),
(7767, '2024-10-19'),
(7938, '2024-10-20'),
(8919, '2024-10-21'),
(9203, '2024-10-22'),
(4162, '2024-10-23'),
(7081, '2024-10-24'),
(8052, '2024-10-25'),
(7582, '2024-10-26'),
(4905, '2024-10-27'),
(5714, '2024-10-28'),
(3155, '2024-10-29'),
(6105, '2024-10-30'),
(5245, '2024-10-31'),
(3748, '2024-11-01'),
(6330, '2024-11-02'),
(8181, '2024-11-03'),
(9242, '2024-11-04'),
(4621, '2024-11-05'),
(4131, '2024-11-06'),
(4653, '2024-11-07'),
(4755, '2024-11-08'),
(3828, '2024-11-09'),
(5453, '2024-11-10'),
(7965, '2024-11-11'),
(6877, '2024-11-12'),
(3067, '2024-11-13'),
(6047, '2024-11-14'),
(8979, '2024-11-15'),
(1985, '2024-11-16'),
(4204, '2024-11-17'),
(7858, '2024-11-18'),
(3983, '2024-11-19'),
(4907, '2024-11-20'),
(7754, '2024-11-21'),
(7130, '2024-11-22'),
(6947, '2024-11-23'),
(5268, '2024-11-24'),
(6269, '2024-11-25'),
(9061, '2024-11-26'),
(8000, '2024-11-27'),
(2552, '2024-11-28'),
(7435, '2024-11-29'),
(1520, '2024-11-30'),
(6063, '2024-12-01'),
(2980, '2024-12-02'),
(8582, '2024-12-03'),
(9258, '2024-12-04'),
(5163, '2024-12-05'),
(7933, '2024-12-06'),
(7846, '2024-12-07'),
(1544, '2024-12-08'),
(1450, '2024-12-09'),
(6139, '2024-12-10'),
(6777, '2024-12-11'),
(4459, '2024-12-12'),
(2151, '2024-12-13'),
(5515, '2024-12-14'),
(6182, '2024-12-15'),
(6119, '2024-12-16'),
(1463, '2024-12-17'),
(7918, '2024-12-18'),
(9457, '2024-12-19'),
(1894, '2024-12-20'),
(1703, '2024-12-21'),
(7412, '2024-12-22'),
(2888, '2024-12-23'),
(4797, '2024-12-24'),
(5431, '2024-12-25'),
(4964, '2024-12-26'),
(3707, '2024-12-27'),
(6222, '2024-12-28'),
(3241, '2024-12-29'),
(8845, '2024-12-30'),
(8087, '2024-12-31');
########################################################################################################################
-- PERCENTAGE_CHANGE
select * from youtubedata;
select *, month(date),
monthname(date),
sum(daily_views) as monthly_views,
lag(sum(daily_views)) over (order by month(date)) as previous_month_views,
concat(
round(((sum(daily_views)-lag(sum(daily_views)) over (order by month(date))) / 
lag(sum(daily_views)) over (order by month(date)))*100,2),'%') as '% change'
from youtubedata
group by month(date);

-- FIND LAST 7 DAYS VIEWS CHANGES FROM SPECIFIC WEEK OF MONTH( FROM 2ND WEEK OF JULY)
########################################################################################################################







