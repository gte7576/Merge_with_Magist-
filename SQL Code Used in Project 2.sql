-- 3.2 How many months of data are included in the Magist Database?
USE MAGIST;
SELECT 
	order_purchase_timestamp 
FROM orders;

SELECT
	max(order_purchase_timestamp) , min(order_purchase_timestamp)
FROM orders;

select timestampdiff(month, min(order_purchase_timestamp), max(order_purchase_timestamp))
from orders;
	
-- How many sellers are there?   Could not differniate between tech and non tech.
SELECT 
	COUNT(*) AS total_sellers
FROM sellers;

SELECT
	max(order_purchase_timestamp) , min(order_purchase_timestamp)
FROM orders;



SELECT 
	COUNT(*) AS tech_sellers
FROM sellers;


SELECT COUNT(DISTINCT seller_id) AS total_sellers
FROM sellers;

-- How many tech sellers are there?
SELECT 

-- What is the total amount earned by tech sellers?


-- TECH SALES


SELECT
	SUM(payment_value)
FROM
    order_payments;
    
-- Average monthly income of all sellers

SELECT sum(price)/26 from order_items;
join products using (product_id)
join product_category_name_translation using (product_category_name)
where product_category_name_english IN 






	






    



    

