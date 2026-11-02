SELECT ROUND(SUM(CAST(line_amount AS DOUBLE)) / NULLIF(COUNT(DISTINCT invoice_no), 0), 2) AS average_order_value_gbp
FROM retail_analytics.transactions WHERE is_valid = true AND transaction_type = 'sale';
