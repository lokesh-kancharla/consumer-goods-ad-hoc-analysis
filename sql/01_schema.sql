-- ==========================================================
-- Consumer Goods Ad-hoc Analysis
-- Step 2: Create Schema
-- Author: Lokesh Kancharla
-- MySQL 8.0+
-- ==========================================================

USE consumer_goods_db;

CREATE TABLE dim_customer (
    customer_code INT PRIMARY KEY,
    customer VARCHAR(100) NOT NULL,
    market VARCHAR(50) NOT NULL,
    region VARCHAR(50) NOT NULL,
    channel VARCHAR(50) NOT NULL
);

CREATE TABLE dim_product (
    product_code VARCHAR(20) PRIMARY KEY,
    product VARCHAR(120) NOT NULL,
    segment VARCHAR(50) NOT NULL,
    division VARCHAR(50) NOT NULL
);

CREATE TABLE fact_gross_price (
    product_code VARCHAR(20) NOT NULL,
    fiscal_year INT NOT NULL,
    gross_price DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (product_code, fiscal_year),
    CONSTRAINT chk_gross_price_nonnegative CHECK (gross_price >= 0),
    CONSTRAINT fk_gross_price_product
        FOREIGN KEY (product_code) REFERENCES dim_product(product_code)
);

CREATE TABLE fact_manufacturing_cost (
    product_code VARCHAR(20) NOT NULL,
    cost_year INT NOT NULL,
    manufacturing_cost DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (product_code, cost_year),
    CONSTRAINT chk_manufacturing_cost_nonnegative CHECK (manufacturing_cost >= 0),
    CONSTRAINT fk_manufacturing_cost_product
        FOREIGN KEY (product_code) REFERENCES dim_product(product_code)
);

CREATE TABLE fact_pre_invoice_deductions (
    customer_code INT NOT NULL,
    fiscal_year INT NOT NULL,
    pre_invoice_discount_pct DECIMAL(6,4) NOT NULL,
    PRIMARY KEY (customer_code, fiscal_year),
    CONSTRAINT chk_discount_range CHECK (pre_invoice_discount_pct BETWEEN 0 AND 1),
    CONSTRAINT fk_pre_invoice_customer
        FOREIGN KEY (customer_code) REFERENCES dim_customer(customer_code)
);

CREATE TABLE fact_sales_monthly (
    sale_id INT PRIMARY KEY AUTO_INCREMENT,
    sale_date DATE NOT NULL,
    fiscal_year INT NOT NULL,
    customer_code INT NOT NULL,
    product_code VARCHAR(20) NOT NULL,
    sold_quantity INT NOT NULL,
    CONSTRAINT chk_sold_quantity_positive CHECK (sold_quantity > 0),
    CONSTRAINT fk_sales_customer
        FOREIGN KEY (customer_code) REFERENCES dim_customer(customer_code),
    CONSTRAINT fk_sales_product
        FOREIGN KEY (product_code) REFERENCES dim_product(product_code)
);

CREATE INDEX idx_sales_customer ON fact_sales_monthly(customer_code);
CREATE INDEX idx_sales_product ON fact_sales_monthly(product_code);
CREATE INDEX idx_sales_fiscal_year ON fact_sales_monthly(fiscal_year);
CREATE INDEX idx_sales_date ON fact_sales_monthly(sale_date);

SHOW TABLES;
