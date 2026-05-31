--SQL Queries for Business Insights
Select * from Global_Superstore
--1.Top 5 Customers per Region by Total Sales
WITH CustomerRegionalSales AS (
    SELECT 
        f.Region,
        c.Customer_Name,
        SUM(f.Sales_Amount) AS Total_Sales,
        DENSE_RANK() OVER (PARTITION BY f.Region ORDER BY SUM(f.Sales_Amount) DESC) AS Sales_Rank
    FROM Fact_Sales f
    JOIN Dim_Customers c ON f.Customer_ID = c.Customer_ID
    GROUP BY f.Region, c.Customer_Name
)
SELECT Region, Customer_Name, Total_Sales, Sales_Rank
FROM CustomerRegionalSales
WHERE Sales_Rank <= 5;


--2.Year-over-Year (YoY) Sales Growth Tracking
WITH AnnualSales AS (
    SELECT 
        YEAR(Order_Date) AS Sales_Year,
        SUM(Sales_Amount) AS Current_Year_Sales
    FROM Fact_Sales
    GROUP BY YEAR(Order_Date)
),
LaggedSales AS (
    SELECT 
        Sales_Year,
        Current_Year_Sales,
        LAG(Current_Year_Sales, 1) OVER (ORDER BY Sales_Year) AS Previous_Year_Sales
    FROM AnnualSales
)
SELECT 
    Sales_Year,
    Current_Year_Sales,
    Previous_Year_Sales,
    ROUND(((Current_Year_Sales - Previous_Year_Sales) / Previous_Year_Sales) * 100, 2) AS YoY_Growth_Percent
FROM LaggedSales;

--3.Identifying High-Value Deficit Products
SELECT TOP 10
    p.Product_Name,
    p.Category,
    SUM(f.Sales_Amount) AS Total_Revenue,
    SUM(f.Quantity) AS Total_Units_Sold,
    SUM(f.Profit_Amount) AS Total_Loss
FROM Fact_Sales f
JOIN Dim_Products p ON f.Product_ID = p.Product_ID
WHERE f.Profit_Amount < 0
GROUP BY p.Product_Name, p.Category
ORDER BY Total_Loss ASC;

Select * from Fact_Sales

--4.Month-over-Month (MoM) Sales Performance and Growth Velocity
WITH Monthly_Sales AS (
    SELECT 
        YEAR(Order_Date) as Sales_Year,
        MONTH(Order_Date) as Sales_Month,
        SUM(Sales_Amount) as Current_Month_Sales
    FROM Fact_Sales
    GROUP BY YEAR(Order_Date), MONTH(Order_Date)
)
SELECT 
    Sales_Year,
    Sales_Month,
    Current_Month_Sales,
    LAG(Current_Month_Sales, 1) OVER (ORDER BY Sales_Year, Sales_Month) as Previous_Month_Sales,
    ROUND(((Current_Month_Sales - LAG(Current_Month_Sales, 1) OVER (ORDER BY Sales_Year, Sales_Month)) / 
    LAG(Current_Month_Sales, 1) OVER (ORDER BY Sales_Year, Sales_Month)) * 100, 2) as MoM_Growth_Pct
FROM Monthly_Sales;

--5.Operational Logistics Efficiency & Fulfillment Performance
SELECT 
    Ship_Mode,
    COUNT(Order_ID) as Total_Orders,
    AVG(DATEDIFF(day, Order_Date, Ship_Date)) as Avg_Days_To_Ship,
    Cast(AVG(Shipping_Cost) as decimal(10,2)) as Avg_Shipping_Cost_USD
FROM Fact_Sales
GROUP BY Ship_Mode
ORDER BY Avg_Days_To_Ship ASC;

--6.Core Customer Retention Cohort Analysis (Year-Over-Year Validation)
WITH Active_2013 AS (
    SELECT DISTINCT Customer_ID FROM Fact_Sales WHERE Datepart(Year,Order_Date) = 2013
),
Active_2014 AS (
    SELECT DISTINCT Customer_ID FROM Fact_Sales WHERE Datepart(Year,Order_Date) = 2014
)
SELECT 
    (SELECT COUNT(*) FROM Active_2013) as Active_Customers_2013,
    COUNT(a14.Customer_ID) as Retained_Customers_2014,
    Cast((COUNT(a14.Customer_ID) * 100.0) / (SELECT COUNT(*) FROM Active_2013) as decimal(10,2)) as Cohort_Retention_Rate_Pct
FROM Active_2013 a13
JOIN Active_2014 a14 ON a13.Customer_ID = a14.Customer_ID;