SELECT YEAR(invoice_timestamp) AS year, MONTH(invoice_timestamp) AS month,
 COUNT(DISTINCT invoice_no) AS cancellation_invoices,
 ROUND(SUM(ABS(CAST(line_amount AS DOUBLE))), 2) AS cancellation_amount_gbp
FROM retail_analytics.transactions
WHERE is_valid = true AND transaction_type = 'cancellation'
GROUP BY 1, 2 ORDER BY 1, 2;
