SELECT customer_id, COUNT(DISTINCT invoice_no) AS total_orders,
 ROUND(SUM(CAST(line_amount AS DOUBLE)), 2) AS total_spending_gbp
FROM retail_analytics.transactions
WHERE is_valid = true AND transaction_type = 'sale'
 AND customer_id IS NOT NULL AND TRIM(customer_id) <> ''
GROUP BY customer_id ORDER BY total_spending_gbp DESC LIMIT 10;
