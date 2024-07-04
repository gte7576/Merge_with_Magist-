-- 3.1 What categories of tech prodcuts does Magist have?
SELECT p.product_category_name, pcnt.product_category_name_english, COUNT(p.product_id) AS product_count
FROM
products p
LEFT JOIN
product_category_name_translation pcnt ON p.product_category_name = pcnt.product_category_name
GROUP BY
pcnt.product_category_name_english,
p.product_category_name
ORDER BY
product_count DESC;

-- SIMPLER 
SELECT * FROM product_category_name_translation
WHERE product_category_name_english LIKE '%tech%'
OR product_category_name_english LIKE '%comp%';

-- How many products of these tech categories have been sold (within the time window of the database snapshot)? 
-- What percentage does that represent from the overall number of products sold?

SELECT
    p.product_category_name,
    pcnt.product_category_name_english,
    COUNT(p.product_id) AS product_count,
	ROUND((COUNT(p.product_id) * 100) / (SELECT COUNT(*) FROM products),2) AS 'Percentage_of_total'
FROM
    products p
LEFT JOIN
    product_category_name_translation pcnt ON p.product_category_name = pcnt.product_category_name
LEFT JOIN
    order_items oi ON p.product_id = oi.product_id
LEFT JOIN
    orders o ON oi.order_id = o.order_id
WHERE
    product_category_name_english LIKE 'industry%' OR
    product_category_name_english LIKE '%commerce' OR
    product_category_name_english LIKE '%tools' OR
    product_category_name_english LIKE 'tablets%' OR
    product_category_name_english LIKE '%appliance' OR
    product_category_name_english LIKE '%print%' OR
    product_category_name_english LIKE 'office%' OR
    product_category_name_english LIKE 'computers%' OR
    product_category_name_english LIKE 'dvds%' OR
    product_category_name_english LIKE 'market%' OR
    product_category_name_english IN ('audio', 'music', 'computers', 'telephony', 'electronics', 'pc_gamers')
GROUP BY
    p.product_category_name,
    pcnt.product_category_name_english
ORDER BY
    pcnt.product_category_name_english;



SELECT
    p.product_category_name,
    pcnt.product_category_name_english,
    COUNT(p.product_id) AS product_count,
    (COUNT(p.product_id) * 100) / (SELECT COUNT(*) FROM products) AS 'Percentage_of_total',
    YEAR(o.order_approved_at) AS year_,
    TIME(o.order_approved_at) AS time_
FROM
    products p
LEFT JOIN
    product_category_name_translation pcnt ON p.product_category_name = pcnt.product_category_name
LEFT JOIN
    order_items oi ON p.product_id = oi.product_id
LEFT JOIN
    orders o ON oi.order_id = o.order_id
WHERE
	order_approved_at BETWEEN 2017 AND 2018 AND
    product_category_name_english LIKE 'industry%' OR
    product_category_name_english LIKE '%commerce' OR
    product_category_name_english LIKE '%tools' OR
    product_category_name_english LIKE 'tablets%' OR
    product_category_name_english LIKE '%appliance' OR
    product_category_name_english LIKE '%print%' OR
    product_category_name_english LIKE 'office%' OR
    product_category_name_english LIKE 'computers%' OR
    product_category_name_english LIKE 'dvds%' OR
    product_category_name_english LIKE 'market%' OR
    product_category_name_english IN ('audio', 'music', 'computers', 'telephony', 'electronics', 'pc_gamers')
GROUP BY
    p.product_category_name,
    pcnt.product_category_name_english,
    year_,
    time_
HAVING COUNT(p.product_id) > 1
ORDER BY
	p.product_category_name,
	pcnt.product_category_name_english,
    product_count DESC,
	year_,
	time_;

---- What’s the average price of the products being sold?

SELECT product_id, ROUND(AVG(price),2) AS avg_price
FROM
order_items
GROUP BY
product_id
ORDER BY
ROUND(AVG(price),2) DESC;

SELECT ROUND(AVG(price),2) FROM order_items;

-- Are expensive tech products popular?
SELECT product_category_name_english, count(*) / (select count(*) from order_items) * 100
FROM order_items oi
join products using (product_id)
join product_category_name_translation using (product_category_name)
where product_category_name_english IN ('audio', 'music', 'computers', 'telephony', 'electronics', 'pc_gamers')
and price > 120.65;

