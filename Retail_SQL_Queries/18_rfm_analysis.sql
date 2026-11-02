WITH sales AS (
 SELECT * FROM retail_analytics.transactions
 WHERE is_valid = true AND transaction_type = 'sale'
 AND customer_id IS NOT NULL AND TRIM(customer_id) <> ''
), reference_date AS (
 SELECT DATE_ADD('day', 1, CAST(MAX(invoice_timestamp) AS DATE)) AS analysis_date FROM sales
)
SELECT s.customer_id,
 DATE_DIFF('day', CAST(MAX(s.invoice_timestamp) AS DATE), MAX(r.analysis_date)) AS recency_days,
 COUNT(DISTINCT s.invoice_no) AS frequency,
 ROUND(SUM(CAST(s.line_amount AS DOUBLE)), 2) AS monetary_value_gbp
FROM sales s CROSS JOIN reference_date r
GROUP BY s.customer_id ORDER BY monetary_value_gbp DESC;
