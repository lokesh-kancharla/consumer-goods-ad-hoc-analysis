-- Consumer Goods Ad-hoc Analysis
-- Step 2: Create Schema

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
    FOREIGN KEY (product_code) REFERENCES dim_product(product_code)
);

CREATE TABLE fact_manufacturing_cost (
    product_code VARCHAR(20) NOT NULL,
    cost_year INT NOT NULL,
    manufacturing_cost DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (product_code, cost_year),
    FOREIGN KEY (product_code) REFERENCES dim_product(product_code)
);

CREATE TABLE fact_pre_invoice_deductions (
    customer_code INT NOT NULL,
    fiscal_year INT NOT NULL,
    pre_invoice_discount_pct DECIMAL(6,4) NOT NULL,
    PRIMARY KEY (customer_code, fiscal_year),
    FOREIGN KEY (customer_code) REFERENCES dim_customer(customer_code)
);

CREATE TABLE fact_sales_monthly (
    sale_id INT PRIMARY KEY AUTO_INCREMENT,
    sale_date DATE NOT NULL,
    fiscal_year INT NOT NULL,
    customer_code INT NOT NULL,
    product_code VARCHAR(20) NOT NULL,
    sold_quantity INT NOT NULL,
    FOREIGN KEY (customer_code) REFERENCES dim_customer(customer_code),
    FOREIGN KEY (product_code) REFERENCES dim_product(product_code)
);
