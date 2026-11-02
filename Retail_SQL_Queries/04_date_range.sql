SELECT MIN(invoice_timestamp) AS first_transaction,
 MAX(invoice_timestamp) AS last_transaction,
 COUNT(DISTINCT invoice_no) AS unique_invoices
FROM retail_analytics.transactions WHERE is_valid = true;
