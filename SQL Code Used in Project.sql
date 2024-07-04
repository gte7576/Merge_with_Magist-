 USE magist;
 SELECT COUNT(order_id) AS total_orders
 FROM orders;

 SELECT order_status, COUNT(*) AS order_count
 FROM orders
GROUP BY order_status;

SELECT 
	Year(order_purchase_timestamp) AS only_year, 
    MONTH(order_purchase_timestamp) AS only_month, 
    COUNT(customer_id)
FROM
	orders
GROUP BY only_year , only_month
ORDER BY only_year , only_month;

SELECT COUNT(DISTINCT product_id)
FROM products;

SELECT 
    product_category_name_english,
    COUNT(DISTINCT product_id) AS n_products
FROM
    products
JOIN 
	product_category_name_translation
    USING (product_category_name)
GROUP BY product_category_name
ORDER BY COUNT(product_id) DESC;

SELECT COUNT(DISTINCT product_id)
FROM order_items;

SELECT 
	MAX(payment_value) as highest,
    MIN(payment_value) as lowest
FROM
	order_payments;
    
-- 7

SELECT MIN(price) AS cheapest,
MAX(price) AS most_expensive
 FROM magist.order_items;