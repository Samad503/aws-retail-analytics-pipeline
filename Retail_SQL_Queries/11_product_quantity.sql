SELECT stock_code, MAX(description) AS product_description,
 SUM(quantity) AS total_units_sold
FROM retail_analytics.transactions
WHERE is_valid = true AND transaction_type = 'sale'
GROUP BY stock_code ORDER BY total_units_sold DESC LIMIT 10;
