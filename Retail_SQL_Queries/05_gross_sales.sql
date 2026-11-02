SELECT ROUND(SUM(CASE WHEN transaction_type = 'sale' THEN CAST(line_amount AS DOUBLE) ELSE 0 END), 2) AS gross_sales_gbp
FROM retail_analytics.transactions WHERE is_valid = true;
