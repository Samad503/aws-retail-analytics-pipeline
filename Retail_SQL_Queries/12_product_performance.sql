SELECT stock_code, MAX(description) AS product_description,
 ROUND(AVG(CAST(unit_price AS DOUBLE)), 2) AS average_unit_price_gbp,
 SUM(quantity) AS total_units_sold,
 ROUND(SUM(CAST(line_amount AS DOUBLE)), 2) AS gross_sales_gbp
FROM retail_analytics.transactions
WHERE is_valid = true AND transaction_type = 'sale'
GROUP BY stock_code HAVING SUM(quantity) > 100
ORDER BY gross_sales_gbp DESC LIMIT 20;
