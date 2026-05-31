Select * from Global_Superstore

/*Phase 1: SQL Schema Creation (Star Schema Design)*/

-- 1. Create Dimension: Customer
CREATE TABLE Dim_Customers (
    Customer_ID VARCHAR(50) PRIMARY KEY,
    Customer_Name NVARCHAR(100),
    Segment VARCHAR(50)
);

INSERT INTO Dim_Customers (Customer_ID, Customer_Name, Segment)
SELECT DISTINCT 
    TRIM(Customer_ID), 
    CAST(TRIM(Customer_Name) AS NVARCHAR(100)), 
    TRIM(Segment)
FROM Global_Superstore;

Select * from Dim_Customers

-- 2. Dimension Table: Products
CREATE TABLE Dim_Products (
    Product_ID VARCHAR(50),
    Product_Name NVARCHAR(255),
    Category VARCHAR(50),
    Sub_Category VARCHAR(50),
);
With RankedProducts as (
    Select Product_ID,Product_Name,Category,Sub_Category,
    ROW_NUMBER() over (Partition by Product_ID Order By(Select Null)) as RN
    from Global_Superstore)

Insert into Dim_Products
Select Product_ID,Product_Name,Category,Sub_Category
from RankedProducts
where RN=1;

Select * from Dim_Products

-- 3. Fact Table: Sales
CREATE TABLE Fact_Sales (
    Order_ID VARCHAR(50),
    Order_Date DATE,
    Ship_Date DATE,
    Ship_Mode VARCHAR(50),
    Customer_ID VARCHAR(50),
    Product_ID VARCHAR(50),
    Product_Name NVARCHAR(255),
    City NVARCHAR(100),
    State NVARCHAR(100),
    Region VARCHAR(50),
    Country VARCHAR(50),
    Sales_Amount DECIMAL(18,2),
    Quantity INT,
    Discount DECIMAL(4,2),
    Profit_Amount DECIMAL(18,2),
    Shipping_Cost DECIMAL(18,2)
);

ALTER TABLE Fact_Sales ADD Shipping_Cost DECIMAL(18,2);

INSERT INTO Fact_Sales (Order_ID, Order_Date, Ship_Date, Ship_Mode, Customer_ID, Product_ID, Product_Name, City, State, Region, Country, Sales_Amount, Quantity, Discount, Profit_Amount, Shipping_Cost)
SELECT 
    TRIM(s.Order_ID),
    CAST(s.Order_Date AS DATE),
    CAST(s.Ship_Date AS DATE),
    TRIM(s.Ship_Mode),
    TRIM(s.Customer_ID),
    TRIM(s.Product_ID),
    CAST(TRIM(s.Product_Name) AS NVARCHAR(255)),
    CAST(TRIM(s.City) AS NVARCHAR(100)),
    CAST(TRIM(s.State) AS NVARCHAR(100)),
    TRIM(s.Region),
    TRIM(s.Country),
    CAST(s.Sales AS DECIMAL(18,2)),
    CAST(s.Quantity AS INT),
    CAST(s.Discount AS DECIMAL(4,2)),
    CAST(s.Profit AS DECIMAL(18,2)),
    CAST(s.Shipping_Cost AS DECIMAL(18,2))
FROM Global_Superstore s;

Select * from Fact_Sales

Select COUNT(*) from Global_Superstore;
Select COUNT(*) from Fact_Sales;





                    