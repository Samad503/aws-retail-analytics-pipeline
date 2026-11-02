SELECT stock_code, MAX(description) AS product_description,
 SUM(quantity) AS units_sold,
 ROUND(SUM(CAST(line_amount AS DOUBLE)), 2) AS gross_sales_gbp
FROM retail_analytics.transactions
WHERE is_valid = true AND transaction_type = 'sale'
GROUP BY stock_code ORDER BY gross_sales_gbp DESC LIMIT 10;
