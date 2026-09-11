-- ==========================================================
-- Consumer Goods Ad-hoc Analysis
-- Step 4: Validate Database Load
-- Author: Lokesh Kancharla
-- ==========================================================

USE consumer_goods_db;

-- Confirm that each table was populated successfully.
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
