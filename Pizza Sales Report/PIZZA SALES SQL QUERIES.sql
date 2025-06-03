CREATE DATABASE PizzaDB

SELECT * FROM dbo.pizza_sales;

/*KPI's*/

--- Total Revenue:

SELECT SUM(total_price) AS [Total Revenue] FROM dbo.pizza_sales;

--- Average Order Value:

SELECT SUM(total_price)/COUNT(DISTINCT order_id) AS [Average Order Value] FROM dbo.pizza_sales;

---Total Pizzas Sold

SELECT SUM(quantity) AS [Total pizza sold] FROM dbo.pizza_sales;

--- Total Orders

SELECT COUNT(DISTINCT order_id) AS [Total Orders] FROM pizza_sales;

--- Average Pizzas Per Order

SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / 
CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2))
AS [Avg Pizzas per order]
FROM pizza_sales;

-----------------------------------------------------------------------------------
/*Daily Trend for Total Orders*/

SELECT DATENAME(DW, order_date) AS order_day, COUNT(DISTINCT order_id) AS [Total Orders] 
FROM pizza_sales
GROUP BY DATENAME(DW, order_date);

------------------------------------------------------------------------------------

/*Monthly Trend for Orders*/

select DATENAME(MONTH, order_date) as [Month Name], COUNT(DISTINCT order_id) as [Total Orders]
from pizza_sales
GROUP BY DATENAME(MONTH, order_date)
ORDER BY [Total Orders] DESC;

---% of Sales by Pizza Category

SELECT pizza_category, SUM(total_price) as [Total_sales] , CAST(SUM(total_price)*100/
(SELECT SUM(total_price) FROM pizza_sales WHERE MONTH(order_date) = 1) AS decimal(10,2)) AS PCT
FROM pizza_sales
WHERE MONTH(order_date) = 1
GROUP BY pizza_category;

--- % of Sales by Pizza Size

SELECT pizza_size, CAST(SUM(total_price) AS decimal(10,2)) as [Total_sales] , CAST(SUM(total_price)*100/
(SELECT SUM(total_price) FROM pizza_sales WHERE DATEPART(QUARTER,order_date) = 1 ) AS decimal(10,2)) AS PCT
FROM pizza_sales
WHERE DATEPART(QUARTER,order_date) = 1
GROUP BY pizza_size
ORDER BY PCT DESC;

--- Total Pizzas Sold by Pizza Category

SELECT pizza_category, SUM(quantity) AS [Total Quantity Sold] 
FROM pizza_sales
WHERE MONTH(order_date) = 2
GROUP BY pizza_category
ORDER BY [Total Quantity Sold] DESC


--- Top 5 Pizzas by Revenue

SELECT TOP 5 pizza_name, SUM(total_price) AS [Total Revenue] FROM pizza_sales
GROUP BY pizza_name
ORDER BY [Total Revenue] DESC

--- Bottom 5 Pizzas by Revenue

SELECT TOP 5 pizza_name, CAST(SUM(total_price) AS decimal(10,2)) AS [Total Revenue] 
FROM pizza_sales
GROUP BY pizza_name
ORDER BY [Total Revenue] ASC

--- Top 5 Pizzas by Quantity

SELECT TOP 5 pizza_name, SUM(quantity) AS [Total Quantity] 
FROM pizza_sales
GROUP BY pizza_name
ORDER BY [Total Quantity]  DESC;


--- Bottom 5 Pizzas by Quantity

SELECT TOP 5 pizza_name, SUM(quantity) AS [Total Quantity] 
FROM pizza_sales
GROUP BY pizza_name
ORDER BY [Total Quantity]  ASC;

--- Top 5 Pizzas by Total Orders
SELECT Top 5 pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders DESC


--- Bottom 5 Pizzas by Total Orders
SELECT Top 5 pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders ASC


