create database windows;
use windows;
CREATE TABLE EmployeeInformation (
    EmployeeID INT,
    Name VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10, 2)
);

INSERT INTO EmployeeInformation (EmployeeID, Name, Department, Salary)
VALUES
    (1, 'John Smith', 'HR', 50000.00),
    (2, 'Alice Lee', 'Sales', 60000.00),
    (3, 'Bob Johnson', 'HR', 55000.00),
    (4, 'Emily Chen', 'Marketing', 48000.00),
    (5, 'Michael Tan', 'Sales', 52000.00),
    (6, 'Sarah Park', 'Marketing', 51000.00),
    (7, 'David Kim', 'HR', 47000.00),
    (8, 'Jessica Wu', 'Sales', 54000.00),
    (9, 'Ryan Wong', 'Marketing', 49000.00),
    (10, 'Michelle Liu', 'Sales', 58000.00),
    (11, 'Kevin Tran', 'HR', 51000.00),
    (12, 'Cindy Wang', 'Marketing', 53000.00),
    (13, 'Brian Chen', 'HR', 49000.00),
    (14, 'Jennifer Ng', 'Sales', 55000.00),
    (15, 'Steven Lee', 'Marketing', 52000.00),
    (16, 'Karen Zhang', 'HR', 47000.00),
    (17, 'Jason Liu', 'Sales', 56000.00),
    (18, 'Lisa Li', 'Marketing', 50000.00),
    (19, 'Eric Wong', 'HR', 48000.00),
    (20, 'Michelle Chen', 'Sales', 59000.00);

select * from EmployeeInformation;
select * from salesdata;
-- For the Employee Information dataset, 
-- can you provide the row number for each employee when ordered by their salary in ascending order?

select *, row_number() over(order by salary asc),
rank() over(order by salary asc),
dense_rank() over(order by salary asc) from EmployeeInformation
;
-- In the Sales Data dataset, what is the dense rank of each order's 
-- amount when ordered by the order date in ascending order?
select *, 
	dense_rank() over(order by orderdate) from salesdata;
-- How can we find the rank of each employee's salary in the Employee Information dataset 
-- when ordered by their department and then by salary in descending order ?
select * from EmployeeInformation;
select * from salesdata;
select *,
	rank() over(order by department ,salary desc) from EmployeeInformation;
-- For the Sales Data dataset, what is the row number of each orders 
-- amount when ordered by the customer ID in ascending order?
select *,
	row_number() over(order by customerid asc) from salesdata;
-- Can you determine the dense rank of each employee's salary in the Employee Information dataset 
-- when ordered by their department and then by salary in ascending order?
select *,
	dense_rank() over(order by department ,salary asc) from EmployeeInformation;
    
-- In the Sales Data dataset, what is the rank of each order's amount
--  when ordered by the order date in descending order?
select *,
	rank() over(order by orderdate desc	) from salesdata;
    






CREATE TABLE SalesData (
    OrderID INT,
    CustomerID INT,
    OrderDate DATE,
    Amount DECIMAL(10, 2)
);

INSERT INTO SalesData (OrderID, CustomerID, OrderDate, Amount)
VALUES
    (1001, 101, '2024-03-01', 2000.00),
    (1002, 102, '2024-03-02', 1500.00),
    (1003, 103, '2024-03-03', 1800.00),
    (1004, 104, '2024-03-04', 2200.00),
    (1005, 105, '2024-03-05', 2500.00),
    (1006, 106, '2024-03-06', 2100.00),
    (1007, 107, '2024-03-07', 1900.00),
    (1008, 108, '2024-03-08', 2300.00),
    (1009, 109, '2024-03-09', 2400.00),
    (1010, 110, '2024-03-10', 2600.00),
    (1011, 111, '2024-03-11', 1700.00),
    (1012, 112, '2024-03-12', 2100.00),
    (1013, 113, '2024-03-13', 2300.00),
    (1014, 114, '2024-03-14', 1900.00),
    (1015, 115, '2024-03-15', 2000.00),
    (1016, 116, '2024-03-16', 1800.00),
    (1017, 117, '2024-03-17', 2500.00),
    (1018, 118, '2024-03-18', 2200.00),
    (1019, 119, '2024-03-19', 1900.00),
    (1020, 120, '2024-03-20', 2600.00);
