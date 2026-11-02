SELECT
 ROUND(SUM(CASE WHEN transaction_type = 'sale' THEN CAST(line_amount AS DOUBLE) ELSE 0 END), 2) AS gross_sales_gbp,
 ROUND(SUM(CASE WHEN transaction_type = 'cancellation' THEN ABS(CAST(line_amount AS DOUBLE)) ELSE 0 END), 2) AS cancellation_amount_gbp,
 ROUND(SUM(CASE WHEN transaction_type IN ('sale', 'cancellation') THEN CAST(line_amount AS DOUBLE) ELSE 0 END), 2) AS net_sales_gbp
FROM retail_analytics.transactions WHERE is_valid = true;
