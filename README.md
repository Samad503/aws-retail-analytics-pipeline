# AWS Retail Analytics Pipeline & Power BI Dashboard

**End-to-end cloud data engineering and business intelligence project** using Amazon S3, AWS Glue, PySpark, Amazon Athena, SQL, and Microsoft Power BI.

## Overview

This project builds an AWS-based analytics pipeline for the **Online Retail II** dataset, containing over **1 million retail transaction records**. Raw transaction data is stored in Amazon S3, transformed with AWS Glue and PySpark, cataloged for SQL analysis in Amazon Athena, and visualized in a three-page Power BI dashboard.

The goal is to explore revenue performance, product demand, geographic sales, customer purchasing behavior, repeat purchases, and cancellations.

## Technology Stack

| Layer | Technology | Purpose |
| --- | --- | --- |
| Storage | Amazon S3 | Store raw files, curated datasets, and Athena results |
| ETL | AWS Glue, PySpark | Clean, validate, and transform transaction data |
| Metadata | AWS Glue Data Catalog and Crawlers | Discover and register curated tables |
| Analytics | Amazon Athena, SQL | Query retail transactions and customer metrics |
| Visualization | Microsoft Power BI | Build dashboards and KPIs |
| Development | Python, SQL | Data processing and analytical queries |

## Architecture

```text
Online Retail II dataset (Excel / CSV)
                  |
                  v
        Amazon S3: raw/csv/
                  |
                  v
         AWS Glue ETL (PySpark)
           /               \
          v                 v
 S3: curated/         S3: curated/
   transactions/         customers/
          |                 |
          +--------+--------+
                   |
                   v
       AWS Glue Crawlers + Data Catalog
                   |
                   v
          Amazon Athena (SQL)
                   |
                   v
     Power BI (CSV exports or ODBC)
                   |
                   v
        Three-page analytics dashboard
```

## Data Pipeline

1. **Ingest:** Convert the Online Retail II source workbook to CSV and upload raw files to Amazon S3.
2. **Transform:** Use an AWS Glue PySpark job to standardize data types, clean transaction records, calculate line-level amounts, and prepare analytics-ready datasets.
3. **Store:** Write curated transaction and customer data to Amazon S3 in Parquet format.
4. **Catalog:** Run Glue Crawlers to register tables in the `retail_analytics` database.
5. **Analyze:** Query the curated tables using Amazon Athena and SQL.
6. **Visualize:** Import query-result CSVs into Power BI or connect to Athena using ODBC to build reports.

### AWS Resources Used

- **AWS Region:** `us-east-1`
- **Glue database:** `retail_analytics`
- **Athena catalog:** `AwsDataCatalog`
- **Athena workgroup:** `primary`
- **Curated tables:** `retail_analytics.transactions`, `retail_analytics.customers`

> Resource names and S3 bucket paths should be configured for your own AWS account. Do not publish access keys, secret keys, session tokens, or private connection settings.

## Power BI Dashboard

### Page 1 — Executive Sales Overview

- Gross sales, total orders, average order value, and customer KPIs
- Monthly sales trend
- Sales by country
- Overall retail performance summary

![Executive Sales Overview](screenshots/page1-executive-overview.png)

### Page 2 — Product & Geographic Performance

- Top products by revenue
- Top products by units sold
- Product performance comparisons
- International sales map

![Product and Geographic Performance](screenshots/page2-product-performance.png)

### Page 3 — Customer Insights

- Total customers and repeat customers
- Repeat customer rate and average customer spending
- Top customers by monetary value
- Customer purchase-frequency distribution
- RFM metrics: recency, frequency, and monetary value
- Monthly cancellation trends

![Customer Insights](screenshots/page3-customer-insights.png)

> The screenshot links above are placeholders. Add the corresponding images to the `screenshots/` folder or remove the links until the screenshots are available.

## Example Athena SQL

### Monthly Gross Sales

```sql
SELECT
    DATE_TRUNC('month', invoice_timestamp) AS sales_month,
    ROUND(SUM(CAST(line_amount AS DOUBLE)), 2) AS gross_sales_gbp,
    COUNT(DISTINCT invoice_no) AS total_orders
FROM retail_analytics.transactions
WHERE is_valid = true
  AND transaction_type = 'sale'
GROUP BY 1
ORDER BY 1;
```

### Top 10 Products by Sales

```sql
SELECT
    stock_code,
    MAX(description) AS product_description,
    SUM(quantity) AS units_sold,
    ROUND(SUM(CAST(line_amount AS DOUBLE)), 2) AS gross_sales_gbp
FROM retail_analytics.transactions
WHERE is_valid = true
  AND transaction_type = 'sale'
GROUP BY stock_code
ORDER BY gross_sales_gbp DESC
LIMIT 10;
```

### Repeat Customer Rate

```sql
WITH customer_orders AS (
    SELECT customer_id, COUNT(DISTINCT invoice_no) AS order_count
    FROM retail_analytics.transactions
    WHERE is_valid = true
      AND transaction_type = 'sale'
      AND customer_id IS NOT NULL
      AND TRIM(customer_id) <> ''
    GROUP BY customer_id
)
SELECT
    COUNT(*) AS total_customers,
    COUNT_IF(order_count >= 2) AS repeat_customers,
    ROUND(100.0 * COUNT_IF(order_count >= 2) / NULLIF(COUNT(*), 0), 2)
        AS repeat_customer_rate_pct
FROM customer_orders;
```

## Suggested Repository Structure

```text
AWS-Retail-Analytics-Pipeline/
├── README.md
├── .gitignore
├── etl/
│   └── retail-analytics-etl.py
├── sql/
│   ├── monthly_sales.sql
│   ├── top_products.sql
│   └── customer_retention.sql
├── dashboard/
│   └── Retail_Analytics_Dashboard.pbix
└── screenshots/
    ├── page1-executive-overview.png
    ├── page2-product-performance.png
    └── page3-customer-insights.png
```

> The structure above is a suggested layout. Add only files that you have actually created, and update filenames if yours differ.

## How to Reproduce

1. Obtain the Online Retail II dataset and prepare CSV input files.
2. Create an S3 bucket and upload the CSVs under `raw/csv/`.
3. Configure an IAM role with the permissions required for Glue, S3, and Athena. Keep credentials outside the repository.
4. Upload the PySpark ETL script and create an AWS Glue job.
5. Run the Glue job to write curated Parquet datasets to S3.
6. Create and run crawlers for the transactions and customers datasets.
7. Confirm that the `transactions` and `customers` tables are visible in Athena under `retail_analytics`.
8. Run the SQL queries and export results as CSV, or connect Power BI through the Athena ODBC driver.
9. Open the Power BI report and refresh or re-import the relevant datasets.

## Data and Security Notes

- This repository is intended to share **code, queries, report files, and screenshots**, not AWS credentials.
- Avoid publishing raw transaction data or customer-level exports containing customer identifiers.
- CSV-export dashboards are snapshots; updating the underlying S3 data does **not** automatically refresh previously downloaded CSVs.
- Aggregated CSV datasets may not cross-filter consistently across visuals. Importing detailed tables and building a shared model enables richer interactivity.
- Gross sales and cancellation amounts are reported separately; cancellation totals should not automatically be interpreted as confirmed refunds.

## Future Improvements

- Schedule and monitor ETL jobs using AWS EventBridge and Glue workflows.
- Add data quality checks for null values, duplicates, invalid quantities, and reconciliation.
- Improve dashboard filtering with a consistent semantic model and date dimension.
- Configure a reliable Athena-to-Power BI refresh process.
- Benchmark Parquet storage savings, Athena query runtime, and query cost.

## Skills Demonstrated

**AWS cloud architecture · Data engineering · PySpark ETL · Parquet · SQL analytics · Data cataloging · Power BI · Customer analytics · Business intelligence**
