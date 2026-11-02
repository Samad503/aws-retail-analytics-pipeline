SELECT YEAR(invoice_timestamp) AS sales_year, MONTH(invoice_timestamp) AS sales_month,
 ROUND(SUM(CASE WHEN transaction_type = 'sale' THEN CAST(line_amount AS DOUBLE) ELSE 0 END), 2) AS gross_sales_gbp,
 ROUND(SUM(CASE WHEN transaction_type IN ('sale', 'cancellation') THEN CAST(line_amount AS DOUBLE) ELSE 0 END), 2) AS net_sales_gbp,
 COUNT(DISTINCT CASE WHEN transaction_type = 'sale' THEN invoice_no END) AS total_orders
FROM retail_analytics.transactions WHERE is_valid = true
GROUP BY 1, 2 ORDER BY 1, 2;
