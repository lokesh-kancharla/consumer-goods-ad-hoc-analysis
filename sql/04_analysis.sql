-- Consumer Goods Ad-hoc Analysis
-- Step 5: Business Analysis

USE consumer_goods_db;

-- 1. Which regions generated the highest gross sales in FY2025?
SELECT
    c.region,
    ROUND(SUM(s.sold_quantity * g.gross_price), 2) AS gross_sales
FROM fact_sales_monthly s
INNER JOIN dim_customer c
    ON s.customer_code = c.customer_code
INNER JOIN fact_gross_price g
    ON s.product_code = g.product_code
    AND s.fiscal_year = g.fiscal_year
WHERE s.fiscal_year = 2025
GROUP BY c.region
ORDER BY gross_sales DESC;

-- 2. What was the percentage increase in unique products from FY2024 to FY2025?
WITH product_counts AS (
    SELECT fiscal_year, COUNT(DISTINCT product_code) AS unique_products
    FROM fact_gross_price
    WHERE fiscal_year IN (2024, 2025)
    GROUP BY fiscal_year
)
SELECT
    MAX(CASE WHEN fiscal_year = 2024 THEN unique_products END) AS products_2024,
    MAX(CASE WHEN fiscal_year = 2025 THEN unique_products END) AS products_2025,
    ROUND(
        (MAX(CASE WHEN fiscal_year = 2025 THEN unique_products END) -
         MAX(CASE WHEN fiscal_year = 2024 THEN unique_products END)) * 100.0 /
         MAX(CASE WHEN fiscal_year = 2024 THEN unique_products END), 2
    ) AS pct_change
FROM product_counts;

-- 3. How many unique products are available in each segment?
SELECT
    segment,
    COUNT(DISTINCT product_code) AS product_count
FROM dim_product
GROUP BY segment
ORDER BY product_count DESC;

-- 4. Which segments grew from FY2024 to FY2025?
SELECT
    p.segment,
    COUNT(DISTINCT CASE WHEN g.fiscal_year = 2024 THEN g.product_code END) AS products_2024,
    COUNT(DISTINCT CASE WHEN g.fiscal_year = 2025 THEN g.product_code END) AS products_2025
FROM fact_gross_price g
INNER JOIN dim_product p
    ON g.product_code = p.product_code
WHERE g.fiscal_year IN (2024, 2025)
GROUP BY p.segment
HAVING products_2025 > products_2024
ORDER BY products_2025 - products_2024 DESC;

-- 5. Which products had the highest and lowest manufacturing costs in FY2025?
SELECT
    p.product,
    m.manufacturing_cost
FROM fact_manufacturing_cost m
INNER JOIN dim_product p
    ON m.product_code = p.product_code
WHERE m.cost_year = 2025
  AND m.manufacturing_cost IN (
      (SELECT MAX(manufacturing_cost)
       FROM fact_manufacturing_cost
       WHERE cost_year = 2025),
      (SELECT MIN(manufacturing_cost)
       FROM fact_manufacturing_cost
       WHERE cost_year = 2025)
  )
ORDER BY m.manufacturing_cost DESC;

-- 6. Which customers received the highest discounts in FY2025?
SELECT
    c.customer,
    ROUND(d.pre_invoice_discount_pct * 100, 2) AS discount_pct
FROM fact_pre_invoice_deductions d
INNER JOIN dim_customer c
    ON d.customer_code = c.customer_code
WHERE d.fiscal_year = 2025
ORDER BY discount_pct DESC
LIMIT 5;

-- 7. What was BestBuy's monthly gross sales trend in FY2025?
SELECT
    DATE_FORMAT(s.sale_date, '%Y-%m') AS month,
    ROUND(SUM(s.sold_quantity * g.gross_price), 2) AS gross_sales
FROM fact_sales_monthly s
INNER JOIN dim_customer c
    ON s.customer_code = c.customer_code
INNER JOIN fact_gross_price g
    ON s.product_code = g.product_code
    AND s.fiscal_year = g.fiscal_year
WHERE c.customer = 'BestBuy'
  AND s.fiscal_year = 2025
GROUP BY DATE_FORMAT(s.sale_date, '%Y-%m')
ORDER BY month;

-- 8. Which fiscal quarter had the highest sold quantity in FY2025?
SELECT
    CASE
        WHEN MONTH(sale_date) IN (9, 10, 11) THEN 'Q1'
        WHEN MONTH(sale_date) IN (12, 1, 2) THEN 'Q2'
        WHEN MONTH(sale_date) IN (3, 4, 5) THEN 'Q3'
        ELSE 'Q4'
    END AS fiscal_quarter,
    SUM(sold_quantity) AS total_sold_quantity
FROM fact_sales_monthly
WHERE fiscal_year = 2025
GROUP BY fiscal_quarter
ORDER BY total_sold_quantity DESC
LIMIT 1;

-- 9. What percentage of gross sales came from each sales channel in FY2025?
WITH channel_sales AS (
    SELECT
        c.channel,
        SUM(s.sold_quantity * g.gross_price) AS gross_sales
    FROM fact_sales_monthly s
    INNER JOIN dim_customer c
        ON s.customer_code = c.customer_code
    INNER JOIN fact_gross_price g
        ON s.product_code = g.product_code
        AND s.fiscal_year = g.fiscal_year
    WHERE s.fiscal_year = 2025
    GROUP BY c.channel
)
SELECT
    channel,
    ROUND(gross_sales, 2) AS gross_sales,
    ROUND(gross_sales * 100.0 / (SELECT SUM(gross_sales) FROM channel_sales), 2) AS contribution_pct
FROM channel_sales
ORDER BY gross_sales DESC;

-- 10. What are the top 3 products by sold quantity within each division in FY2025?
WITH product_sales AS (
    SELECT
        p.division,
        p.product,
        SUM(s.sold_quantity) AS total_sold_quantity
    FROM fact_sales_monthly s
    INNER JOIN dim_product p
        ON s.product_code = p.product_code
    WHERE s.fiscal_year = 2025
    GROUP BY p.division, p.product
),
ranked_products AS (
    SELECT
        division,
        product,
        total_sold_quantity,
        DENSE_RANK() OVER (
            PARTITION BY division
            ORDER BY total_sold_quantity DESC
        ) AS product_rank
    FROM product_sales
)
SELECT
    division,
    product,
    total_sold_quantity,
    product_rank
FROM ranked_products
WHERE product_rank <= 3
ORDER BY division, product_rank;
