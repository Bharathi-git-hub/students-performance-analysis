create database Mini_project;

create table customers
(
customer_id int,
customer_name varchar(20),
city varchar(20)
);

insert into customers values
(1022, 'Sreedhar', 'Hyderabad'),
(1102, 'Bharathi', 'Kadapa'),
(1025, 'Vijay', 'Kurnool'),
(1108, 'Vinay', 'Vizag'),
(1120, 'Eligibeth', 'America'),
(1212, 'Emma', 'America'),
(1145, 'Devid', 'Kerala'),
(1001, 'Alia', 'Hyderabad'),
(1006, 'Srija', 'Banglore'),
(1304, 'Taylore', 'Kerala'),
(1016, 'John', 'Vizag'),
(1229, 'Rupa', 'Hyderabad'); 

select * from customers;

create table orders
(
order_id int,
customer_id int,
order_date date,
amount int
);

insert into orders values
(1, 1022, '2010-4-15', 25000),
(2, 1025, '2010-5-13', 35600),
(3, 1102, '2011-5-30', 9000),
(4, 1120, '2010-2-19', 10500),
(5, 1155, '2012-12-5', 25500),
(6, 1212, '2010-9-16', 50300),
(7, 1001, '2016-6-25', 44000),
(8, 1006, '2016-6-29', 65500),
(9, 1304, '2016-2-28', 42000),
(10, 1016, '2015-9-22', 30500);

insert into orders values(3, 1102, '2011-5-30', 90000);
select * from orders;

create table products
(
product_id int,
product_name varchar(20),
Price int
);

insert into products values
(1, 'Oppo Mobile', 20000),
(2, 'Laptop', 45000),
(3, 'Apple iPhone', 70000),
(4, 'Earbuds', 5000),
(5, 'Charger', 1500),
(6, 'Oppo Mobile', 15000),
(7, 'Laptop', 30000),
(8, 'Charger', 1300),
(9, 'iPhone', 65000),
(10, 'Earbuds', 9000),
(11, 'Laptop', 66000),
(12, 'Kettle', 2000),
(13, 'Smart Watch', 8500),
(14, 'iPad', 90000),
(15, 'Smart Watch', 9000),
(16, 'EarBuds', 5300),
(17, 'Charger', 3000),
(18, 'Apple iPhone', 53000),
(19, 'Oppo Mobile', 25000),
(20, 'iPad', 98000);

select * from products;


create table order_items
(
order_id int,
product_id int,
Quantity varchar(20)
);

insert into order_items values
(1, 3, 'Small Order'),
(2, 4, 'Large Order'),
(3, 5, 'Large Order'),
(4, 9, 'Small Order'),
(5, 7, 'Small Order'),
(7, 10, 'Large Order'),
(6, 13, 'Large Order'),
(8, 10, 'Small Order'),
(9, 12, 'Large Order'),
(10, 11, 'Small Order'),
(11, 14, 'Small Order'),
(12, 17, 'Small Order'),
(13, 15, 'Large Order'),
(15, 19, 'Small Order'),
(24, 20, 'Large Order'),
(29, 24, 'Large Order');

select * from order_items;

-- Get all customers from a specific city (e.g., Hyderabad)
select *
from customers
where city = 'Hyderabad';  -- or

select customer_name from customers
where city = 'Hyderabad';

-- Find total number of orders placed by each customer

select customer_name, count(order_id) as Total
from customers c left join orders o on c.customer_id = o.customer_id
group by customer_name;

-- Find customers who placed at least one order

select customer_name 
from customers
where customer_id in (select customer_id from orders);

-- Find customers who never placed any order
 select customer_name
 from customers
 where customer_id not in (select customer_id from orders);

-- Find the second highest order amount

select amount
from orders
order by amount desc
limit 1 offset 1; -- or

select max(amount) as Second_higest
from orders
where amount < (select max(amount) from orders);


-- Question: Find products that were never ordered

select * from orders
where order_id not in (select product_id 
						from products);

-- Question: Find customers who placed more orders than average number of orders per customer

select customer_name
from customers
where customer_id > (select avg(order_id) from orders);

-- Question: Find employees/customers whose order amount is highest in their city

select c.customer_name, c.city, o.amount
from customers c join orders o on c.customer_id = o.customer_id
join(select c.city, max(o.amount) as max_amount
from customers c join orders o on c.customer_id = o.customer_id
group by c.city) b
on c.city = b.city and o.amount = b.max_amount;

-- Question: Find orders that contain products with price greater than average product price

select o.order_id, p.product_name, p.price
from orders o join products p on o.amount = p.price
where price > (select avg(price) 
from products);

-- question: Find customers who bought all products

select c.customer_name, o.order_id, p.product_name
from customers c join orders o on c.customer_id = o.customer_id
join products p on o.amount = p.price;





