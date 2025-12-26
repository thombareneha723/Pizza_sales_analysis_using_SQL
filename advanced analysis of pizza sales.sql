# Q11 Calculate the percentage contribution of each pizza type to total revenue.
select * from pizza_types;
select * from order_details;
select * from pizzas;

SELECT 
    a.category,
    (SUM(quantity * price) / (SELECT 
            SUM(quantity * price)
        FROM
            order_details AS a
                JOIN
            pizzas AS b ON a.pizza_id = b.pizza_id)) * 100 AS revenue
FROM
    pizza_types AS a
        JOIN
    pizzas AS b ON a.pizza_type_id = b.pizza_type_id
        JOIN
    order_details AS c ON b.pizza_id = c.pizza_id
GROUP BY a.category
ORDER BY revenue DESC;

# Q12 Analyze the cumulative revenue generated over time.
select * from pizza_types;
select * from order_details;
select * from pizzas;
select order_date,sum(revenue) over(order by order_date) as cum_revenue
 from
(select order_date,sum(quantity*price) as revenue
from order_details  as a join pizzas as b
on a.pizza_id=b.pizza_id
join orders as c
on c.order_id=a.order_id
group by order_date) as revenue_data;

# Q13 Determine the top 3 most ordered pizza types based on revenue for each pizza category.
select category,name,revenue from
(select category,name,revenue,rank() over(partition by category order by revenue desc) as rn from
(select  a.category,a.name,sum(quantity*price) as revenue
from pizza_types as a
join pizzas as b
on a.pizza_type_id=b.pizza_type_id
join 
order_details as c
on b.pizza_id=c.pizza_id
group by a.category, a.name
order by revenue desc) as a) as b
where rn<=3;