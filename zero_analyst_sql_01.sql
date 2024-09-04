create database sql_challenge_zero_analyst;
use sql_challenge_zero_analyst;

-- Amazon Interview Practice 21/02/2024


/* 1. You have two tables: Product and Supplier.
- Product Table Columns: Product_id, Product_Name, Supplier_id, Price
- Supplier Table Columns: Supplier_id, Supplier_Name, Country
*/
-- Write an SQL query to find the name of the product with the highest 
-- price in each country.

-- creating the product table 

-- creating supplier table 

create table  Supplier(Supplier_id int primary key, Supplier_Name varchar(50), Country varchar(50));
INSERT INTO supplier
VALUES(501, 'alan', 'India'),
		(502, 'rex', 'US'),
		(503, 'dodo', 'India'),
		(504, 'rahul', 'US'),
		(505, 'zara', 'Canda'),
		(506, 'max', 'Canada')
;
CREATE INDEX idx_supplier_id ON Supplier(Supplier_id);
CREATE TABLE product (
    product_id int PRIMARY KEY,
    product_name varchar(25),
    supplier_id int,
    price float,
    FOREIGN KEY (supplier_id) REFERENCES Supplier(Supplier_id)
);
INSERT INTO product
VALUES	(201, 'iPhone 14', '501', 1299),
		(202, 'iPhone 8', '502', 999),
		(204, 'iPhone 13', '502', 1199),
		(203, 'iPhone 11', '503', 1199),
		(205, 'iPhone 12', '502', 1199),
		(206, 'iPhone 14', '501', 1399),
		(214, 'iPhone 15', '503', 1499),
		(207, 'iPhone 15', '505', 1499),
		(208, 'iPhone 15', '504', 1499),
		(209, 'iPhone 12', '502', 1299),
		(210, 'iPhone 13', '502', 1199),
		(211, 'iPhone 11', '501', 1099),
		(212, 'iPhone 14', '503', 1399),
		(213, 'iPhone 8', '502', 1099)
;
INSERT INTO product
VALUES	(222, 'Samsung Galaxy S21', '504', 1699),
		(223, 'Samsung Galaxy S20', '505', 1899),
		(224, 'Google Pixel 6', '501', 899),
		(225, 'Google Pixel 5', '502', 799),
		(226, 'OnePlus 9 Pro', '503', 1699),
		(227, 'OnePlus 9', '502', 1999),
		(228, 'Xiaomi Mi 11', '501', 899),
		(229, 'Xiaomi Mi 10', '504', 699),
		(230, 'Huawei P40 Pro', '505', 1099),
		(231, 'Huawei P30', '502', 1299),
		(232, 'Sony Xperia 1 III', '503', 1199),
		(233, 'Sony Xperia 5 III', '501', 999),
		(234, 'LG Velvet', '505', 1899),
		(235, 'LG G8 ThinQ', '504', 799),
		(236, 'Motorola Edge Plus', '502', 1099),
		(237, 'Motorola One 5G', '501', 799),
		(238, 'ASUS ROG Phone 5', '503', 1999),
		(239, 'ASUS ZenFone 8', '504', 999),
		(240, 'Nokia 8.3 5G', '502', 899),
		(241, 'Nokia 7.2', '501', 699),
		(242, 'BlackBerry Key2', '504', 1899),
		(243, 'BlackBerry Motion', '502', 799),
		(244, 'HTC U12 Plus', '501', 899),
		(245, 'HTC Desire 20 Pro', '505', 699),
		(246, 'Lenovo Legion Phone Duel', '503', 1499),
		(247, 'Lenovo K12 Note', '504', 1499),
		(248, 'ZTE Axon 30 Ultra', '501', 1299),
		(249, 'ZTE Blade 20', '502', 1599),
		(250, 'Oppo Find X3 Pro', '503', 1999);
select * from product;
select * from supplier;

-- ----------------------------------------------
-- My solution
-- ----------------------------------------------
-- -- Write an SQL query to find the name of the product with the highest price in each country.
with rankprodut as 
  (
		select product_name, price,country,
		rank() over(partition by country order by price desc) as rank_product
		from (
				select s.country,s.Supplier_id ,p.price,p.product_name from supplier as s
				join product p
				on s.supplier_id=p.supplier_id
		     ) 	as temp
    )  
select * from rankprodut
where rank_product = 1;

/* 
You have two tables: Customer and Transaction.
- Customer Table Columns: Customer_id, Customer_Name, Registration_Date
- Transaction Table Columns: Transaction_id, Customer_id, Transaction_Date, Amount

-- Write an SQL query to calculate the total transaction amount for each customer for the current year. 
The output should contain Customer_Name and the total amount.
*/


-- 1. find total transaction amt group by each customer filter with current year 
-- put where condition to check if the transaction are current year year 1  

select 
		c.Customer_Name,
		sum(t.amount) as total
from transaction t
		join customers as c 
		on  t.Customer_id=c.Customer_id
where  extract(year from t.Transaction_Date)= extract(year from current_date())
group by c.Customer_id
;
s






CREATE TABLE Customers (
    Customer_id INT PRIMARY KEY,
    Customer_Name VARCHAR(100),
    Registration_Date DATE
);
CREATE TABLE Transaction (
    Transaction_id INT PRIMARY KEY,
    Customer_id INT,
    Transaction_Date DATE,
    Amount DECIMAL(10, 2),
    FOREIGN KEY (Customer_id) REFERENCES Customers(Customer_id)
);

-- Insert records into Customer table
INSERT INTO Customers (Customer_id, Customer_Name, Registration_Date)
VALUES
    (1, 'John Doe', '2023-01-15'),
    (2, 'Jane Smith', '2023-02-20'),
    (3, 'Michael Johnson', '2023-03-10');
    -- Insert records into Transaction table
INSERT INTO Transaction (Transaction_id, Customer_id, Transaction_Date, Amount)
VALUES
    (201, 1, '2024-01-20', 50.00),
    (202, 1, '2024-02-05', 75.50),
    (203, 2, '2023-02-22', 100.00),
    (204, 3, '2022-03-15', 200.00),
    (205, 2, '2024-03-20', 120.75),
	(301, 1, '2024-01-20', 50.00),
    (302, 1, '2024-02-05', 75.50),
    (403, 2, '2023-02-22', 100.00),
    (304, 3, '2022-03-15', 200.00),
    (505, 2, '2024-03-20', 120.75);

SELECT * FROM customers;
SELECT * FROM transaction;
s
-- ----------------------------------------------
-- My solution
-- ----------------------------------------------




