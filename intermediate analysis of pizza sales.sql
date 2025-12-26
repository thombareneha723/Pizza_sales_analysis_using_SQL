# Q6 Join the necessary tables to find the total quantity of each pizza category ordered.
select * from pizza_types;
select * from order_details;
select * from pizzas;

SELECT 
    c.category, SUM(a.quantity)
FROM
    order_details AS a
        JOIN
    pizzas AS b ON a.pizza_id = b.pizza_id
        JOIN
    pizza_types AS c ON b.pizza_type_id = c.pizza_type_id
GROUP BY c.category;

# Q7 Determine the distribution of orders by hour of the day.
select * from orders;
SELECT 
    HOUR(order_time), COUNT(order_id)
FROM
    orders
GROUP BY HOUR(order_time);

# Q8 Join relevant tables to find the category-wise distribution of pizzas.
select * from pizza_types;
SELECT 
    category, COUNT(pizza_type_id)
FROM
    pizza_types
GROUP BY category;
SELECT 
    *
FROM
    pizza_types;
SELECT 
    *
FROM
    pizzas;

# Q9 Group the orders by date and calculate the average number of pizzas ordered per day.
select * from orders;
select * from order_details;

select a.order_date,sum(b.quantity) as total_quantity_per_day
from orders as a
join order_details as b
on a.order_id=b.order_id
group by order_date;

SELECT 
    AVG(total_quantity_per_day)
FROM
    (SELECT 
        a.order_date, SUM(b.quantity) AS total_quantity_per_day
    FROM
        orders AS a
    JOIN order_details AS b ON a.order_id = b.order_id
    GROUP BY order_date) AS order_quantity;

# Q10 Determine the top 3 most ordered pizza types based on revenue.
select * from pizza_types;
select * from pizzas;
select * from order_details;

SELECT 
    a.name, SUM(quantity * price) AS total_revenue
FROM
    pizza_types AS a
        JOIN
    pizzas AS b ON a.pizza_type_id = b.pizza_type_id
        JOIN
    order_details AS c ON b.pizza_id = c.pizza_id
GROUP BY a.name
ORDER BY total_revenue DESC
LIMIT 3;
