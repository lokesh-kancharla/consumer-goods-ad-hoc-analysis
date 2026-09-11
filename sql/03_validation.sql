-- ==========================================================
-- Consumer Goods Ad-hoc Analysis
-- Step 4: Validate Database Load
-- Author: Lokesh Kancharla
-- ==========================================================

USE consumer_goods_db;

-- Row-count validation
SELECT 'dim_customer' AS table_name, COUNT(*) AS row_count FROM dim_customer
UNION ALL
SELECT 'dim_product', COUNT(*) FROM dim_product
UNION ALL
SELECT 'fact_gross_price', COUNT(*) FROM fact_gross_price
UNION ALL
SELECT 'fact_manufacturing_cost', COUNT(*) FROM fact_manufacturing_cost
UNION ALL
SELECT 'fact_pre_invoice_deductions', COUNT(*) FROM fact_pre_invoice_deductions
UNION ALL
SELECT 'fact_sales_monthly', COUNT(*) FROM fact_sales_monthly;

-- Referential-integrity sanity checks.
-- Every result below should return 0 orphan records.
SELECT 'sales_without_customer' AS validation_check, COUNT(*) AS issue_count
FROM fact_sales_monthly s
LEFT JOIN dim_customer c ON s.customer_code = c.customer_code
WHERE c.customer_code IS NULL
UNION ALL
SELECT 'sales_without_product', COUNT(*)
FROM fact_sales_monthly s
LEFT JOIN dim_product p ON s.product_code = p.product_code
WHERE p.product_code IS NULL
UNION ALL
SELECT 'price_without_product', COUNT(*)
FROM fact_gross_price g
LEFT JOIN dim_product p ON g.product_code = p.product_code
WHERE p.product_code IS NULL
UNION ALL
SELECT 'cost_without_product', COUNT(*)
FROM fact_manufacturing_cost m
LEFT JOIN dim_product p ON m.product_code = p.product_code
WHERE p.product_code IS NULL
UNION ALL
SELECT 'discount_without_customer', COUNT(*)
FROM fact_pre_invoice_deductions d
LEFT JOIN dim_customer c ON d.customer_code = c.customer_code
WHERE c.customer_code IS NULL;
