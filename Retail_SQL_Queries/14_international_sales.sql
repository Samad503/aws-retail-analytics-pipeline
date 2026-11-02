SELECT country, COUNT(DISTINCT invoice_no) AS total_orders,
 ROUND(SUM(CAST(line_amount AS DOUBLE)), 2) AS gross_sales_gbp
FROM retail_analytics.transactions
WHERE is_valid = true AND transaction_type = 'sale' AND country <> 'United Kingdom'
GROUP BY country ORDER BY gross_sales_gbp DESC;
