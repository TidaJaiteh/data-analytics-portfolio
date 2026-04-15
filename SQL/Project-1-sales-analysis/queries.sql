--1: Total Revenue
SELECT
    SUM(order_items.quantity * products.price) AS total_revenue
FROM order_items 
JOIN products 
     ON order_items.product_id = products.product_id;

--2: Revenue By Product
SELECT products.product_name,
     SUM(order_items.quantity * products.price) AS monthly_revenue
FROM order_items
JOIN products
     ON order_items.product_id = products.product_id
GROUP BY products.product_name
ORDER BY monthly_revenue DESC;

--3: Top Customers
SELECT customer.name,
     SUM(order_items.quantity * products.price) AS total_spent
FROM customer
JOIN orders
     ON customer.customer_id = orders.customer_id
JOIN order_items
     ON orders.order_id = order_items.order_id
JOIN products
     ON order_items.product_id = products.product_id
GROUP BY customer.name
ORDER BY total_spent DESC;

--4: Repeat Customers
SELECT customer.name,
     COUNT(orders.order_id) AS total_orders
FROM customer
JOIN orders
     ON customer.customer_id = orders.customer_id
GROUP BY customer.name
HAVING COUNT (orders.order_id) > 1
ORDER BY total_orders DESC;

--5: Monthly Sales Trend
SELECT
    DATE_TRUNC('month', orders.order_date) AS month,
	SUM(order_items.quantity * products.price) AS revenue
FROM orders
JOIN order_items
     ON orders.order_id = order_items.order_id
JOIN products
     ON order_items.product_id = products.product_id
GROUP BY month
ORDER BY month;
