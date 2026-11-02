SELECT COUNT(DISTINCT customer_id) AS unique_customers
FROM retail_analytics.transactions
WHERE is_valid = true AND transaction_type = 'sale'
 AND customer_id IS NOT NULL AND TRIM(customer_id) <> '';
