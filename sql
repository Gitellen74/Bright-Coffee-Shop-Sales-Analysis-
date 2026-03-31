-----------------------------------------------
--*Being able to see the structure of the table*
-------------------------------------------------
SELECT *
FROM workspace.default.bright_coffee_shop_sales limit 10;
---------------------------------------------------------------
--*See beginning and last date of trasactions*
---------------------------------------------------------------
SELECT MIN(transaction_date) AS FirstTransDate
FROM workspace.default.bright_coffee_shop_sales;

SELECT MAX(transaction_date) AS LastTransDate
FROM workspace.default.bright_coffee_shop_sales;
---------------------------------------------------------
--*Number of Stores*
---------------------------------------------------------
SELECT DISTINCT Store_location
from workspace.default.bright_coffee_shop_sales;
---------------------------------------------------------
--*Types and number of Product Categories*
---------------------------------------------------------
SELECT DISTINCT Product_Category
from workspace.default.bright_coffee_shop_sales;
---------------------------------------------------------
--*COUNT THE number of TRANSACTIONS,NUMBER OF STORES,NUMBER OF PRODUCTS,etc*
---------------------------------------------------------------
SELECT COUNT(*) AS numberofrows,
      COUNT(DISTINCT transaction_id) AS numberoftransactions,
      COUNT(DISTINCT store_id) AS numberofstores,
      COUNT(DISTINCT product_id) AS numberofproducts,
      COUNT(DISTINCT product_category) AS ProductCAT,
      COUNT(DISTINCT product_type) AS productTYP,
      COUNT(DISTINCT product_detail) AS productDET
FROM workspace.default.bright_coffee_shop_sales;
---------------------------------------------------------------
--*EXPLORING TRANSACTION DATE,(MONTH,DAY OF WEEK)NAME FUNCTION(TIMEBUCKETS)* 
---------------------------------------------------------
SELECT  transaction_date,
Dayname(transaction_date) AS dayoftheweek,
Monthname(transaction_date) AS monthoftheyear,
--calculating the revenue
SUM (transaction_qty*unit_price) AS Revenue,
COUNT(DISTINCT transaction_id) AS numberoftransactions
FROM workspace.default.bright_coffee_shop_sales
GROUP BY transaction_date,
dayoftheweek,
monthoftheyear;
---------------------------------------------------------
--*UNIQUEPRODUCTDRILLANALYSIS*
---------------------------------------------------------
SELECT 
DISTINCT product_type
FROM workspace.default.bright_coffee_shop_sales;

SELECT 
DISTINCT product_category
FROM workspace.default.bright_coffee_shop_sales;

SELECT
DISTINCT product_detail
FROM workspace.default.bright_coffee_shop_sales;

SELECT  DISTINCT product_category,
       product_detail,
       transaction_qty*unit_price AS revenue
FROM workspace.default.bright_coffee_shop_sales;

GROUP BY product_category,
       product_detail

 ---------------------------------------------------------
 --*ALL PRODUCT PRICES*
 ---------------------------------------------------------
SELECT MIN(unit_price) As cheapest_price
FROM workspace.default.bright_coffee_shop_sales;

SELECT MAX(unit_price) As expensive_price
FROM workspace.default.bright_coffee_shop_sales;

---------------------------------------------------------
--*CODE ASSIGNMENT TO BE SUBMITTED*
---------------------------------------------------------
SELECT  
  transaction_date,
  store_id,
  store_location,
  product_id,
  transaction_id,
  transaction_time,
  unit_price,
  transaction_qty,
  product_detail,
  product_category,
  product_type,
  Dayname(transaction_date) AS dayoftheweek,
  Monthname(transaction_date) AS monthoftheyear,
  Dayofmonth(transaction_date) AS dayofthemonth,
  CASE 
       WHEN Dayname(transaction_date) IN ('Saturday','Sunday') THEN 'Weekend'
       ELSE 'Weekday'
       END AS dayofweek,
  CASE 
        WHEN date_format(transaction_time,'HH:mm:ss') BETWEEN '00:00:00' AND '08:59:59'  THEN '01.Early Morning'
        WHEN date_format(transaction_time,'HH:mm:ss') BETWEEN '09:00:00' AND '11:59:59' THEN '02.Late Morning'
        WHEN date_format(transaction_time,'HH:mm:ss') BETWEEN '12:00:00' AND '13:59:59' THEN '03.Early Afternoon'
        WHEN date_format(transaction_time,'HH:mm:ss') BETWEEN '14:00:00' AND '17:59:59' THEN '04.Late Afternoon'
        ELSE '05.Evening'
        END AS Timebuckets,
  COUNT(DISTINCT transaction_id) AS number_of_sales,
  COUNT(DISTINCT store_id) AS number_of_stores,
  COUNT(DISTINCT product_id) AS number_of_products,
  SUM(transaction_qty*unit_price) AS Revenue,
  CASE
    WHEN SUM(transaction_qty*unit_price) <= 50 THEN 'Low spender'
    WHEN SUM(transaction_qty*unit_price) BETWEEN 50 AND 100 THEN 'Avg Spender'
    ELSE 'High Spender'
  END AS Consumerspendtrend
FROM workspace.default.bright_coffee_shop_sales
GROUP BY 
  transaction_date,
  transaction_time,
  store_id,
  transaction_date,
  transaction_time,
  store_id,
  store_location,
  product_id,
  transaction_id,
  unit_price,
  transaction_qty,
  product_detail,
  product_category,
  product_type;
