WITH customer_orders AS (
 SELECT customer_id, COUNT(DISTINCT invoice_no) AS order_count
 FROM retail_analytics.transactions
 WHERE is_valid = true AND transaction_type = 'sale'
 AND customer_id IS NOT NULL AND TRIM(customer_id) <> ''
 GROUP BY customer_id
)
SELECT COUNT(*) AS total_customers,
 COUNT_IF(order_count >= 2) AS repeat_customers,
 ROUND(100.0 * COUNT_IF(order_count >= 2) / NULLIF(COUNT(*), 0), 2) AS repeat_customer_percentage
FROM customer_orders;
