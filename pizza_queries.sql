CREATE DATABASE pizza_factory;

USE pizza_factory;

-- First Table: pizza_types

CREATE TABLE pizza_types (
pizza_type_id VARCHAR(50) PRIMARY KEY,
name VARCHAR(100) NOT NULL,
category VARCHAR(50) NOT NULL,
ingredients TEXT
);

-- second table: pizzas

CREATE TABLE pizzas (
pizza_id VARCHAR(50) PRIMARY KEY,
pizza_type_id VARCHAR(50),
size VARCHAR(10) NOT NULL,
price DECIMAL(10, 2) NOT NULL,
FOREIGN KEY (pizza_type_id) REFERENCES  pizza_types(pizza_type_id)
);

-- Third table: orders

CREATE TABLE orders (
order_id INT PRIMARY KEY,
date DATE NOT NULL,
time TIME NOT NULL
);

-- Fourth table: order_details

CREATE TABLE order_details (
order_details_id INT PRIMARY KEY,
order_id INT,
pizza_id VARCHAR(50),
quantity INT NOT NULL,
FOREIGN KEY (order_id) REFERENCES orders(order_id),
FOREIGN KEY (pizza_id) REFERENCES pizzas(pizza_id)
);

SELECT * FROM pizza_types;
SELECT * FROM pizzas;
SELECT * FROM orders;
SELECT * FROM order_details;

-- A. KPI’s
-- 1. Total Revenue:

SELECT
    ROUND(SUM(od.quantity * p.price),2) AS Total_revenue
FROM pizzas p
JOIN 
    order_details od ON od.pizza_id = p.pizza_id;

-- 2. Average Order Value (AOV):

SELECT
	ROUND(SUM(od.quantity * p.price)/COUNT(DISTINCT od.order_id),2) AS Average_Order_Value
FROM pizzas p
JOIN 
    order_details od ON od.pizza_id = p.pizza_id;
    
-- 3. Total Pizzas Sold:

SELECT
    SUM(quantity) AS Total_Pizzas_Sold
FROM order_details;
    
-- 4. Total Orders:

SELECT
    COUNT(DISTINCT order_id) AS Total_Oders
FROM orders;

-- 5. Average Pizzas Per Order:

SELECT 
    ROUND(SUM(quantity) / COUNT(DISTINCT order_id),
            2) AS Avg_Pizzas_Per_Order
FROM
    order_details;

-- B. CHART
    
-- 1. Daily Trend for Total Orders:

SELECT 
    DAYNAME(date) AS Order_Day, 
    COUNT(DISTINCT order_id) AS Total_Orders
FROM 
   orders
GROUP BY
	DAYNAME(date),
    DAYOFWEEK(date)
ORDER BY 
    DAYOFWEEK(date);

-- 2. Monthly Trend for Total Orders:

SELECT
    MONTHNAME(date) AS Month_Name,
    COUNT(DISTINCT order_id) AS Total_Orders
FROM
    orders
GROUP BY 
    MONTHNAME(date),
    MONTH(date)
ORDER BY 
	MONTH(date);
    
-- C. Category Splits    
-- 3. Percentage of Sales by Pizza Category

SELECT 
    pt.category AS Pizza_Category,
    ROUND(SUM(od.quantity * p.price), 2) AS Total_Sales,
    ROUND(
        (SUM(od.quantity * p.price) / 
         (SELECT SUM(order_details.quantity * pizzas.price) 
          FROM order_details 
          JOIN pizzas ON order_details.pizza_id = pizzas.pizza_id)
        ) * 100, 2) AS Percentage_Contribution
FROM 
    order_details od
JOIN 
    pizzas p ON od.pizza_id = p.pizza_id
JOIN 
    pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY 
    pt.category
ORDER BY 
    Percentage_Contribution DESC;

  -- 4. % of Sales by Pizza Size:
  
SELECT 
    p.size AS pizza_size,
    ROUND(SUM(od.quantity * p.price), 2) AS Total_Sales,
    ROUND(
        (SUM(od.quantity * p.price) / 
         (SELECT SUM(order_details.quantity * pizzas.price) 
          FROM order_details 
          JOIN pizzas ON order_details.pizza_id = pizzas.pizza_id)
        ) * 100, 
        2
    ) AS percentage_contribution
FROM 
    order_details od
JOIN 
    pizzas p ON od.pizza_id = p.pizza_id
GROUP BY 
    p.size
ORDER BY 
    percentage_contribution DESC;

-- 5. Total Pizzas Sold by Pizza Category:

SELECT 
    pt.category AS Pizza_Category,
    SUM(od.quantity) AS Total_Quantity_Sold
FROM 
    order_details od
JOIN 
    pizzas p ON od.pizza_id = p.pizza_id
JOIN 
    pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY 
    pt.category
ORDER BY 
	Total_Quantity_Sold DESC;
    
-- D. Top/Bottom Analysis
-- 6. Top 5 Pizzas by Revenue:

SELECT 
	pt.name AS Pizza_Name,
    ROUND(SUM(od.quantity * p.price), 2) AS Total_Revenue
FROM 
    order_details od
JOIN 
    pizzas p ON od.pizza_id = p.pizza_id
JOIN 
    pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY 
    pt.name
ORDER BY 
    Total_Revenue DESC
LIMIT 5;

-- 7. Bottom 5 Pizzas by Revenue:

SELECT 
    pt.name AS Pizza_Name,
    ROUND(SUM(od.quantity * p.price), 2) AS Total_Revenue
FROM 
    order_details od
JOIN 
    pizzas p ON od.pizza_id = p.pizza_id
JOIN 
    pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY 
    pt.name
ORDER BY 
    Total_Revenue ASC
LIMIT 5;

-- 8.. Top 5 Pizzas by Quantity:

SELECT 
    pt.name AS Pizza_Name,
    SUM(od.quantity) AS Total_Quantity_Sold
FROM 
    order_details od
JOIN 
    pizzas p ON od.pizza_id = p.pizza_id
JOIN 
    pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY 
    pt.name
ORDER BY 
    Total_Quantity_Sold DESC
LIMIT 5;

-- 9. Bottom 5 Pizzas by Quantity:

SELECT 
    pt.name AS Pizza_Name,
    SUM(od.quantity) AS Total_Quantity_Sold
FROM 
    order_details od
JOIN 
    pizzas p ON od.pizza_id = p.pizza_id
JOIN 
    pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY 
    pt.name
ORDER BY 
    Total_Quantity_Sold ASC
LIMIT 5;

-- 10. Top 5 Pizzas by Total Orders:

SELECT 
    pt.name AS Pizza_Name,
    COUNT(DISTINCT od.order_id) AS Total_Orders_Count
FROM 
    order_details od
JOIN 
    pizzas p ON od.pizza_id = p.pizza_id
JOIN 
    pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY 
    pt.name
ORDER BY 
    Total_Orders_Count DESC
LIMIT 5;

-- 11. Bottom 5 Pizzas by Total Orders:

SELECT 
    pt.name AS Pizza_Name,
    COUNT(DISTINCT od.order_id) AS Total_Orders_Count
FROM 
    order_details od
JOIN 
    pizzas p ON od.pizza_id = p.pizza_id
JOIN 
    pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY 
    pt.name
ORDER BY 
    Total_Orders_Count ASC
LIMIT 5;