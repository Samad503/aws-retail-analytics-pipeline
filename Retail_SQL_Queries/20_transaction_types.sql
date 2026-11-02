SELECT transaction_type, COUNT(*) AS total_rows,
 ROUND(SUM(CAST(line_amount AS DOUBLE)), 2) AS total_line_amount_gbp
FROM retail_analytics.transactions
WHERE is_valid = true
GROUP BY transaction_type ORDER BY total_rows DESC;
