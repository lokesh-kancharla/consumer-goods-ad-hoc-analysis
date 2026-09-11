-- Consumer Goods Ad-hoc Analysis
-- Author: Lokesh Kancharla

DROP TABLE IF EXISTS fact_sales_monthly;
DROP TABLE IF EXISTS fact_pre_invoice_deductions;
DROP TABLE IF EXISTS fact_manufacturing_cost;
DROP TABLE IF EXISTS fact_gross_price;
DROP TABLE IF EXISTS dim_product;
DROP TABLE IF EXISTS dim_customer;

CREATE TABLE dim_customer (
    customer_code INT PRIMARY KEY,
    customer VARCHAR(100) NOT NULL,
    market VARCHAR(50) NOT NULL,
    region VARCHAR(50),
    channel VARCHAR(50) NOT NULL
);

CREATE TABLE dim_product (
    product_code VARCHAR(20) PRIMARY KEY,
    product VARCHAR(120) NOT NULL,
    segment VARCHAR(50) NOT NULL,
    division VARCHAR(50) NOT NULL
);

CREATE TABLE fact_gross_price (
    product_code VARCHAR(20),
    fiscal_year INT,
    gross_price DECIMAL(10,2),
    PRIMARY KEY (product_code, fiscal_year),
    FOREIGN KEY (product_code) REFERENCES dim_product(product_code)
);

CREATE TABLE fact_manufacturing_cost (
    product_code VARCHAR(20),
    cost_year INT,
    manufacturing_cost DECIMAL(10,2),
    PRIMARY KEY (product_code, cost_year),
    FOREIGN KEY (product_code) REFERENCES dim_product(product_code)
);

CREATE TABLE fact_pre_invoice_deductions (
    customer_code INT,
    fiscal_year INT,
    pre_invoice_discount_pct DECIMAL(6,4),
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
