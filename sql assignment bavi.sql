use customer_orders;
Create Table Customers (customer_id int auto_increment primary key,
first_name varchar(50) not null, last_name varchar(50) not null, email_id varchar(255) unique,
phone_number varchar(20));

insert into Customers values(1001, "Judy", "Hopps", "judyhopps@gmail.com","8976545789");
insert into Customers values(1002, "Bull", "Hopps", "Bullhopps@gmail.com","8976545781");

insert into Customers values(1003, "Fox", "Hopps", "foxhopps@gmail.com","8976545780");
select * from Customers;

-- Create a table named Orders to store information about customer orders. Include the following 
-- columns:order_id: This should be an integer set as the PRIMARY KEY and AUTO_INCREMENT.
-- customer_id: This should be an integer referencing the customer_id in the Customers table  (FOREIGN KEY).
-- order_date: This should be a DATE data type to store the order date.
-- total_amount: This should be a DECIMAL(10,2) to store the total order amount

Drop table Orders;

Create Table Orders (order_id int auto_increment primary key,customer_id int not null, 
foreign key (customer_id) references Customers(customer_id),order_date date, total_amount Decimal(10,2),CHECK (total_amount>0));

insert into Orders values(11001, 1001,'2026-09-26', 567.10);
insert into Orders values(11002, 1003,'2026-09-27', 555.00);
insert into Orders values(11003, 1002,'2026-09-27', -100.00);
select*from orders;
-- . Create a table project with below fields.EmployeeID : integer set as the PRIMARY KEY and AUTO_INCREMENT.
-- FullName: varchar(50) with no null valuesGender : Values should be only ‘Male’  or ‘Female’ManagerID: integer 
create database practice;
use practice;
Drop table project;

create table project(EmployeeID int auto_increment primary key, FullName varchar(50) not null, Gender varchar(10), Check (Gender IN ("Male","Female")), ManagerID int);
insert into project values(1,"Pranaya","Male",3);
insert into project values(2,"Priyanka","Female",1);
insert into project values(3,"Preety","Female",NULL);
insert into project values(4,"Anurag","Male",1);
insert into project values(5,"Sambit","Male",1);
insert into project values(6,"Rajesh","Male",3);
insert into project values(7,"Hina","Female",3);
select*from project;
select b.fullname as Manager_Name, a.fullname as EmpName from project as a join project as b on
a.ManagerID=b.EmployeeID order by Manager_Name;
use classicmodels;
drop table Facility;
create table Facility(FacilityID int not null, Name varchar(100),State varchar(100), country varchar(100));
alter table Facility modify column FacilityID int not null auto_increment primary key;
alter table Facility add column City varchar(100) after Name;
select*from Facility;
show tables;
select * from productlines;
select * from products;
select * from orders;
select * from orderdetails;
create view product_category_sales_view as select p.productLine, sum(od.quantityordered*od.priceeach) as total_Sales ,count(distinct(od.ordernumber)) as number_of_orders from productlines as p 
join products as pr on pr.productline = p.productline 
join orderdetails as od on od.productcode=pr.productcode 
join orders as ors on ors.ordernumber=od.ordernumber group by p.productline;
-- Create a stored procedure Get_country_payments which takes in year and country as inputs and gives year wise, 
-- country wise total amount as an output. Format the total amount to nearest thousand unit (K)
select * from customers;
select * from payments;
select * from orders;
select distinct Year(a.paymentdate)as yyear, b.Country as Country, a.amount as Total_amount from payments as a inner join customers as b
on a.customerNumber=b.customerNumber group by 1,2,3;

select Year, Country, sum(total_amount) as Totalamount from paymentstable group by Country,year;
use classicmodels;

-- Question 1:

-- Question 1 (a): 

select * from employees;

select employeeNumber, firstName, lastName from employees
Where reportsTo = 1102 and jobTitle like "Sales Rep";

-- Question 1 (b)

select * from products;

select productLine from products where productLine like "% cars";

-- Question 2 - Case Statements for segmentation

select * from customers;

select customerNumber, customerName, case when country in ("USA","Canada") then "North America"
when country in ("UK","France","Germany") then "Europe"
else "Others"
end as CustomerSegment from customers;


-- Question 3 A- Aggregate Functions Group by, Having clause and date& time

select * from orderdetails;

select productCode, sum(quantityOrdered) as TotalOrdered from orderdetails group by productCode order by sum(quantityOrdered) desc limit 10;

-- Question 3 b 
select * from payments;

select monthname(paymentDate) as payment_month, count(amount) as num_payment from payments group by monthname(paymentDate) having count(amount)>20;


-- Question 4 A- CONSTRAINTS: Primary, key, foreign key, Unique, check, not null, default
create database customer_orders;

use customer_orders;
Create Table Customers (customer_id int auto_increment primary key,
first_name varchar(50) not null, last_name varchar(50) not null, email_id varchar(255) unique,
phone_number varchar(20));

insert into Customers values(1001, "Judy", "Hopps", "judyhopps@gmail.com","8976545789");
insert into Customers values(1003, "Fox", "Hopps", "foxhopps@gmail.com","8976545780");
select * from Customers;

-- Question 4 B- CONSTRAINTS: Primary, key, foreign key, Unique, check, not null, default

Create Table Orders (order_id int auto_increment primary key,customer_id int not null, 
foreign key (customer_id) references Customers(customer_id),order_date date, total_amount Decimal(10,2),CHECK (total_amount>0));

insert into Orders values(11001, 1001,'2026-09-26', 567.10);
insert into Orders values(11002, 1003,'2026-09-27', 555.00);
select*from orders;

-- Question 5 Joins

select * from orders;
select * from customers;

select b.country,count(ordernumber) as order_count from orders as a join customers as b
on a.customerNumber=b.customerNumber group by b.country order by order_count desc limit 5;

-- Question 6 Self join

create table project(EmployeeID int auto_increment primary key, FullName varchar(50) not null, Gender varchar(10), Check (Gender IN ("Male","Female")), ManagerID int);
insert into project values(1,"Pranaya","Male",3);
insert into project values(2,"Priyanka","Female",1);
insert into project values(3,"Preety","Female",NULL);
insert into project values(4,"Anurag","Male",1);
insert into project values(5,"Sambit","Male",1);
insert into project values(6,"Rajesh","Male",3);
insert into project values(7,"Hina","Female",3);
select*from project;
select b.fullname as Manager_Name, a.fullname as EmpName from project as a join project as b on
a.ManagerID=b.EmployeeID order by Manager_Name;


-- Question 7 - DDL Commands: Create, Alter, Rename
-- i
create table Facility(FacilityID int not null, Name varchar(100),State varchar(100), country varchar(100));
alter table Facility modify column FacilityID int not null auto_increment primary key;
-- ii
alter table Facility add column City varchar(100) not null after Name;

select * from Facility;

-- Question 8 Views in SQL

select * from orderdetails;

create view product_category_sales_view as select p.productLine, 
sum(od.quantityordered*od.priceeach) as total_Sales,
count(distinct(ors.ordernumber)) as number_of_orders 
from productlines as p join products as pr on pr.productline = p.productline 
join orderdetails as od on od.productcode=pr.productcode 
join orders as ors on ors.ordernumber=od.ordernumber 
group by p.productline;

select * from product_category_sales_view;

-- Question 9 Stored Procedure
CALL get_country_payments(2003,'France');

-- Question 10 i) Window functions - Rank, dense_rank, lead and lag

SELECT
c.customerName,count(o.orderNumber) as Order_count,
DENSE_RANK() OVER ( ORDER BY COUNT(o.orderNumber) DESC
) AS order_frequency_rank
FROM customers c
JOIN orders o
ON c.customerNumber = o.customerNumber
GROUP BY
c.customerNumberGet_country_payments
;

-- Question 10 ii 

select* from orders;

WITH monthly_orders AS (SELECT YEAR(orderDate) AS pyear,MONTH(orderDate) AS month_no,
MONTHNAME(orderDate) AS pmonth,
COUNT(orderNumber) AS total_orders FROM orders
GROUP BY YEAR(orderDate),
MONTH(orderDate),
MONTHNAME(orderDate))
SELECT pyear, pmonth , total_orders AS `Total Orders`, CONCAT(ROUND(((total_orders -
LAG(total_orders) OVER (ORDER BY pyear, month_no))) /
LAG(total_orders) OVER (ORDER BY pyear, month_no)*100.0,0),'%') AS `%YoY/MoM Change`
FROM monthly_orders
ORDER BY pyear;

-- Question 11 Subqueries and their applications
select * from products;

SELECT productLine,
    COUNT(productLine) AS Total FROM products
WHERE buyPrice > (
    SELECT AVG(buyPrice)
    FROM products
) GROUP BY productLine;

-- Question 12 Error handling
create table EMP_EH(EMPID int primary key not null, EmpName varchar(50), EmailAddress varchar(100) UNIQUE);
CALL Insert_Emp_EH(101, 'Sunny', 'sunny@gmail.com');
CALL Insert_Emp_EH(101, 'EMILY', 'emily@gmail.com');
CALL Insert_EMP_EH(102,'Essiah','sunny@gmail.com');
CALL Insert_EMP_EH(103,'jkgjbkj','sunny1@gmail.com');
CALL Insert_EMP_EH(105,123,'sunny111@gmail.com');
select*from EMP_EH;


-- Question 13 Triggers

create table EMP_BIT(Name varchar(50),Occupation varchar (30), Working_date date, Working_hours int);
INSERT INTO Emp_BIT VALUES
('Robin', 'Scientist', '2020-10-04', 12),  
('Warner', 'Engineer', '2020-10-04', 10),  
('Peter', 'Actor', '2020-10-04', 13),  
('Marco', 'Doctor', '2020-10-04', 14),  
('Brayden', 'Teacher', '2020-10-04', -12),  
('Antonio', 'Business', '2020-10-04', 11),
('Benedict', 'Business', '2020-10-04', -11);
select * from EMP_BIT;

