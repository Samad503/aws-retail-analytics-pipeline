SELECT COUNT(*) AS total_records,
 COUNT_IF(is_valid = true) AS valid_records,
 COUNT_IF(is_valid = false OR is_valid IS NULL) AS invalid_records,
 COUNT_IF(customer_id IS NULL OR TRIM(customer_id) = '') AS missing_customer_ids,
 COUNT_IF(invoice_timestamp IS NULL) AS invalid_dates,
 COUNT_IF(unit_price IS NULL OR unit_price < 0) AS invalid_prices
FROM retail_analytics.transactions;
