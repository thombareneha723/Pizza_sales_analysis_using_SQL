create database pizzahut;

create table orders (
order_id int  not null ,
order_date date not null ,
order_time time not null ,
primary key(order_id) );

#   Identify the highest-priced pizza.



create table order_details(
order_details_id int not null,
order_id int  not null ,
pizza_id text not null,
quantity int not null,
primary key(order_details_id));

select * from pizzahut.order_details;
# Q1. Retrieve the total number of orders placed
select * from orders;
SELECT 
    COUNT(order_id) AS total_orders
FROM
    orders;

# Q2 Calculate the total revenue generated from pizza sales.
select * from pizzas;
select * from order_details;
SELECT 
    ROUND(SUM(quantity * price), 2) AS total_revenue_pizza
FROM
    order_details AS a
        LEFT JOIN
    pizzas AS b ON a.pizza_id = b.pizza_id;

# Q3.Identify the highest-priced pizza.
select * from pizzas;
select * from pizza_types;
SELECT 
    *
FROM
    pizzas
WHERE
    price = (SELECT 
            MAX(price)
        FROM
            pizzas);
-- OR
SELECT 
    a.name, b.price
FROM
    pizza_types AS a
        JOIN
    pizzas AS b ON a.pizza_type_id = b.pizza_type_id
ORDER BY b.price DESC
LIMIT 1;

# Q4 Identify the most common pizza size ordered.
select * from order_details;
select * from pizzas;
SELECT 
    b.size, COUNT(b.size) AS order_count
FROM
    order_details AS a
        LEFT JOIN
    pizzas AS b ON a.pizza_id = b.pizza_id
GROUP BY b.size
ORDER BY order_count DESC
LIMIT 1;

# Q5 List the top 5 most ordered pizza types along with their quantities.
select * from pizzas;
select * from order_details;
select * from pizza_types;

SELECT 
    c.name, SUM(quantity) AS total_quantity
FROM
    order_details AS a
        JOIN
    pizzas AS b ON a.pizza_id = b.pizza_id
        JOIN
    pizza_types AS c ON b.pizza_type_id = c.pizza_type_id
GROUP BY c.name
ORDER BY total_quantity DESC
LIMIT 5;




