USE platopizza;

-- Total Qty of Orders (21,350)
SELECT
	COUNT(order_id) AS 'Total Order Qty'
FROM 
	orders;

-- Total pizzas ordered (49,574)
SELECT 
	SUM(quantity) AS 'Total Pizzas Ordered'
FROM 
	order_details; 

-- Average amount of pizzas ordered per order
SELECT 
	AVG(quantity) AS 'AVG Pizzas per Order'
FROM 
	order_details; 

-- Calculating 2015 Total Revenue ($817,860.05)
SELECT 
	SUM(price * quantity) AS 'Total Revenue'
FROM 
	order_details 
LEFT JOIN pizzas
ON order_details.pizza_id = pizzas.pizza_id;

-- pulling monthly revenue for 2015
SELECT
	date,
    MONTH(date) AS month,
    SUM(price * quantity) AS 'Total Revenue'
FROM orders
LEFT JOIN order_details
ON orders.order_id = order_details.order_id
LEFT JOIN pizzas
ON order_details.pizza_id = pizzas.pizza_id
WHERE YEAR(date) = 2015
GROUP BY date,MONTH(date);

-- 2015 revenue by quarter
SELECT
    QUARTER(date) AS QUARTER,
    SUM(price * quantity) AS 'Total Revenue'
FROM orders
LEFT JOIN order_details
ON orders.order_id = order_details.order_id
LEFT JOIN pizzas
ON order_details.pizza_id = pizzas.pizza_id
WHERE YEAR(date) = 2015
GROUP BY QUARTER(date);

-- Pulling pizza type, size large, the top 3 sellers, and the total number of orders of each type of pizza
SELECT 
	pizzas.pizza_type_id, 
    pizzas.size,
    pizzas.price,
    COUNT(order_id) AS '# of Orders'
FROM order_details
LEFT JOIN pizzas
ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizzas.size, pizza_type_id, pizzas.price
HAVING size = 'L'
ORDER BY COUNT(order_id) DESC
LIMIT 5;

/* 
What is the best selling pizza and the worst?  
Best selling pizza type of the year is The Thai Chicken Pizza at $42332.25, total 2325 pizzas of this type sold
Worst selling pizza type is The Brie Carre Pizza at $11351.99, total 480 pizzas sold
*/

SELECT 
	pizza_type_id,
    COUNT(order_id) as 'Quantity',
    SUM(price) as 'Total'
FROM order_details
LEFT JOIN pizzas
ON order_details.pizza_id = pizzas.pizza_id
GROUP BY 
	pizza_type_id
ORDER BY 
	SUM(price) ASC
LIMIT 5;
    
-- Pizza types with total order quantity => 1,000
SELECT 
	pizza_id, 
    COUNT(quantity) as 'Quantity of Pizzas'
FROM order_details 
GROUP BY pizza_id
HAVING COUNT(quantity) >= 1000
ORDER BY COUNT(quantity) DESC

-- Pulling top selling pizza, during busy 1 o'clock hour on 1/1/2015
SELECT
	orders.order_id,
    orders.date,
    orders.time,
    pizzas.pizza_type_id,
    pizzas.price    
FROM orders
LEFT JOIN order_details
ON orders.order_id = order_details.order_id
LEFT JOIN pizzas
ON order_details.pizza_id = pizzas.pizza_id
WHERE 
	date = '2015-01-01'
	AND time BETWEEN '13:00:00' AND '14:00:00'
ORDER BY 
	price DESC
LIMIT 1; 

-- Number of orders by MONTH in 2015
SELECT
    MONTH(date) AS month,
    COUNT(order_id) AS 'Number of Orders'
FROM orders
WHERE 
	YEAR(date) = 2015
GROUP BY 
	MONTH(date);

-- Number of orders by QUARTER in 2015
SELECT
    QUARTER(date) AS QUARTER,
    COUNT(order_id) AS 'Number of Orders'
FROM orders
WHERE 
	YEAR(date) = 2015
GROUP BY 
	QUARTER(date);


-- Finding the average amount of money spent per order
	WITH CTE_avg_order_amount
	AS
	(
	Select 
		orders.order_id,
		SUM(pizzas.price) AS total_order_amount
	FROM orders
		LEFT JOIN order_details
		ON orders.order_id = order_details.order_id
		LEFT JOIN pizzas
		ON order_details.pizza_id = pizzas.pizza_id	
	GROUP BY order_id
	)
	SELECT
	(AVG(total_order_amount))AS avg_order_amount
	FROM CTE_avg_order_amount;


-- Finding the average number of orders by day
WITH CTE_avg_orders_by_day
	AS
	(
SELECT
    date,
    COUNT(order_id) AS Number_of_orders
FROM orders
WHERE 
	YEAR(date) = 2015
GROUP BY 
	date
)
	SELECT
	ROUND(AVG(number_of_orders))AS avg_orders_by_day
	FROM CTE_avg_orders_by_day;

-- Pulling Number of Orders by the hour at Platos
SELECT 
    HOUR(time) AS 'HOUR',
    COUNT(order_id) AS 'ORDERS'
FROM orders
GROUP BY HOUR(time)
ORDER BY HOUR(time)

