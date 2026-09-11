-- ==========================================================
-- Consumer Goods Ad-hoc Analysis
-- Author: Lokesh Kancharla
-- ==========================================================

-- 1. Markets where Croma operates in APAC.
SELECT DISTINCT market
FROM dim_customer
WHERE customer = 'Croma'
  AND region = 'APAC'
ORDER BY market;

-- 2. Percentage increase in unique products from 2020 to 2021.
WITH product_counts AS (
    SELECT fiscal_year, COUNT(DISTINCT product_code) AS unique_products
    FROM fact_gross_price
    WHERE fiscal_year IN (2020, 2021)
    GROUP BY fiscal_year
),
pivoted AS (
    SELECT
        MAX(CASE WHEN fiscal_year = 2020 THEN unique_products END) AS products_2020,
        MAX(CASE WHEN fiscal_year = 2021 THEN unique_products END) AS products_2021
    FROM product_counts
)
SELECT
    products_2020,
    products_2021,
    ROUND((products_2021 - products_2020) * 100.0 / products_2020, 2) AS pct_change
FROM pivoted;

-- 3. Unique product count by segment.
SELECT
    segment,
    COUNT(DISTINCT product_code) AS product_count
FROM dim_product
GROUP BY segment
ORDER BY product_count DESC, segment;

-- 4. Segment with the largest increase in unique products.
WITH segment_year AS (
    SELECT
        p.segment,
        g.fiscal_year,
        COUNT(DISTINCT g.product_code) AS product_count
    FROM fact_gross_price g
    JOIN dim_product p
      ON g.product_code = p.product_code
    WHERE g.fiscal_year IN (2020, 2021)
    GROUP BY p.segment, g.fiscal_year
),
segment_growth AS (
    SELECT
        segment,
        MAX(CASE WHEN fiscal_year = 2020 THEN product_count ELSE 0 END) AS products_2020,
        MAX(CASE WHEN fiscal_year = 2021 THEN product_count ELSE 0 END) AS products_2021
    FROM segment_year
    GROUP BY segment
)
SELECT
    segment,
    products_2020,
    products_2021,
    products_2021 - products_2020 AS increase_in_products
FROM segment_growth
ORDER BY increase_in_products DESC, segment;

-- 5. Products with highest and lowest manufacturing costs.
WITH ranked_costs AS (
    SELECT
        p.product_code,
        p.product,
        m.manufacturing_cost,
        DENSE_RANK() OVER (ORDER BY m.manufacturing_cost DESC) AS high_rank,
        DENSE_RANK() OVER (ORDER BY m.manufacturing_cost ASC) AS low_rank
    FROM fact_manufacturing_cost m
    JOIN dim_product p
      ON m.product_code = p.product_code
    WHERE m.cost_year = 2021
)
SELECT product_code, product, manufacturing_cost
FROM ranked_costs
WHERE high_rank = 1 OR low_rank = 1
ORDER BY manufacturing_cost DESC;

-- 6. Top 5 customers by average pre-invoice discount in India.
SELECT
    c.customer_code,
    c.customer,
    ROUND(AVG(d.pre_invoice_discount_pct) * 100, 2) AS avg_discount_pct
FROM fact_pre_invoice_deductions d
JOIN dim_customer c
  ON d.customer_code = c.customer_code
WHERE d.fiscal_year = 2021
  AND c.market = 'India'
GROUP BY c.customer_code, c.customer
ORDER BY avg_discount_pct DESC
LIMIT 5;

-- 7. Monthly gross sales for Croma.
SELECT
    DATE_FORMAT(s.sale_date, '%Y-%m') AS month,
    ROUND(SUM(s.sold_quantity * g.gross_price), 2) AS gross_sales
FROM fact_sales_monthly s
JOIN dim_customer c
  ON s.customer_code = c.customer_code
JOIN fact_gross_price g
  ON s.product_code = g.product_code
 AND s.fiscal_year = g.fiscal_year
WHERE c.customer = 'Croma'
GROUP BY DATE_FORMAT(s.sale_date, '%Y-%m')
ORDER BY month;

-- 8. Quarter with the highest total sold quantity.
WITH quarterly_sales AS (
    SELECT
        CASE
            WHEN MONTH(sale_date) IN (9,10,11) THEN 'Q1'
            WHEN MONTH(sale_date) IN (12,1,2) THEN 'Q2'
            WHEN MONTH(sale_date) IN (3,4,5) THEN 'Q3'
            ELSE 'Q4'
        END AS fiscal_quarter,
        SUM(sold_quantity) AS total_sold_quantity
    FROM fact_sales_monthly
    WHERE fiscal_year = 2021
    GROUP BY fiscal_quarter
)
SELECT fiscal_quarter, total_sold_quantity
FROM quarterly_sales
ORDER BY total_sold_quantity DESC;

-- 9. Gross sales contribution by channel.
WITH channel_sales AS (
    SELECT
        c.channel,
        SUM(s.sold_quantity * g.gross_price) AS gross_sales
    FROM fact_sales_monthly s
    JOIN dim_customer c
      ON s.customer_code = c.customer_code
    JOIN fact_gross_price g
      ON s.product_code = g.product_code
     AND s.fiscal_year = g.fiscal_year
    WHERE s.fiscal_year = 2021
    GROUP BY c.channel
),
total_sales AS (
    SELECT SUM(gross_sales) AS grand_total
    FROM channel_sales
)
SELECT
    cs.channel,
    ROUND(cs.gross_sales / 1000000, 2) AS gross_sales_mln,
    ROUND(cs.gross_sales * 100.0 / ts.grand_total, 2) AS contribution_pct
FROM channel_sales cs
CROSS JOIN total_sales ts
ORDER BY cs.gross_sales DESC;

-- 10. Top 3 products by sold quantity within each division.
WITH product_sales AS (
    SELECT
        p.division,
        p.product_code,
        p.product,
        SUM(s.sold_quantity) AS total_sold_quantity
    FROM fact_sales_monthly s
    JOIN dim_product p
      ON s.product_code = p.product_code
    WHERE s.fiscal_year = 2021
    GROUP BY p.division, p.product_code, p.product
),
ranked_products AS (
    SELECT
        division,
        product_code,
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
    product_code,
    product,
    total_sold_quantity,
    product_rank
FROM ranked_products
WHERE product_rank <= 3
ORDER BY division, product_rank, product;
