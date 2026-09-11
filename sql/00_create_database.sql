-- Consumer Goods Ad-hoc Analysis Database
-- Author: Lokesh Kancharla

DROP DATABASE IF EXISTS consumer_goods_db;
CREATE DATABASE consumer_goods_db;
USE consumer_goods_db;

-- ==============================
-- Dimension Tables
-- ==============================
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

-- ==============================
-- Fact Tables
-- ==============================
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

-- ==============================
-- Sample Data
-- ==============================
INSERT INTO dim_customer VALUES
(1001,'Croma','India','APAC','Retailer'),
(1002,'Croma','UAE','MEA','Retailer'),
(1003,'BestBuy','USA','NA','Retailer'),
(1004,'Amazon','India','APAC','E-Commerce'),
(1005,'Flipkart','India','APAC','E-Commerce'),
(1006,'Reliance Digital','India','APAC','Retailer'),
(1007,'Staples','Canada','NA','Retailer'),
(1008,'Newegg','USA','NA','E-Commerce');

INSERT INTO dim_product VALUES
('P101','NovaBook Air','Notebook','PC'),
('P102','NovaBook Pro','Notebook','PC'),
('P103','Pulse Mouse','Accessories','P&A'),
('P104','Pulse Keyboard','Accessories','P&A'),
('P105','Vision Monitor 24','Peripherals','P&A'),
('P106','Vision Monitor 32','Peripherals','P&A'),
('P107','Echo Headset','Accessories','P&A'),
('P108','Core Desktop','Desktop','PC'),
('P109','Core Gaming Desktop','Desktop','PC'),
('P110','Flash SSD 1TB','Storage','P&A'),
('P111','Flash SSD 2TB','Storage','P&A'),
('P112','Connect Dock','Accessories','P&A');

INSERT INTO fact_gross_price VALUES
('P101',2020,850),('P101',2021,875),
('P102',2020,1250),('P102',2021,1295),
('P103',2020,35),('P103',2021,38),
('P104',2020,55),('P104',2021,59),
('P105',2020,180),('P105',2021,190),
('P106',2020,320),('P106',2021,335),
('P107',2020,85),('P107',2021,90),
('P108',2020,700),('P108',2021,735),
('P109',2020,1450),('P109',2021,1495),
('P110',2020,110),('P110',2021,105),
('P111',2021,175),('P112',2021,120);

INSERT INTO fact_manufacturing_cost VALUES
('P101',2021,540),('P102',2021,810),
('P103',2021,12),('P104',2021,22),
('P105',2021,100),('P106',2021,185),
('P107',2021,38),('P108',2021,460),
('P109',2021,980),('P110',2021,62),
('P111',2021,115),('P112',2021,70);

INSERT INTO fact_pre_invoice_deductions VALUES
(1001,2021,0.0810),(1002,2021,0.0650),(1003,2021,0.0540),
(1004,2021,0.0920),(1005,2021,0.0870),(1006,2021,0.0740),
(1007,2021,0.0470),(1008,2021,0.0690);

INSERT INTO fact_sales_monthly
(sale_date,fiscal_year,customer_code,product_code,sold_quantity) VALUES
('2020-09-15',2021,1001,'P101',120),
('2020-10-12',2021,1001,'P103',450),
('2020-11-20',2021,1001,'P105',180),
('2020-12-10',2021,1001,'P108',90),
('2021-01-11',2021,1001,'P102',80),
('2021-02-14',2021,1001,'P104',320),
('2021-03-18',2021,1001,'P106',140),
('2021-04-09',2021,1001,'P107',260),
('2021-05-21',2021,1001,'P109',55),
('2021-06-16',2021,1001,'P110',300),
('2021-07-13',2021,1001,'P111',210),
('2021-08-19',2021,1001,'P112',240),
('2020-10-02',2021,1003,'P101',160),
('2021-01-23',2021,1003,'P109',95),
('2021-05-12',2021,1003,'P106',170),
('2021-07-07',2021,1003,'P110',380),
('2020-09-28',2021,1004,'P103',700),
('2020-12-18',2021,1004,'P102',100),
('2021-03-08',2021,1004,'P105',250),
('2021-06-26',2021,1004,'P111',410),
('2020-11-05',2021,1005,'P104',600),
('2021-02-05',2021,1005,'P101',130),
('2021-04-22',2021,1005,'P107',330),
('2021-08-02',2021,1005,'P112',390),
('2020-09-06',2021,1006,'P108',110),
('2021-01-16',2021,1006,'P105',210),
('2021-05-30',2021,1006,'P103',520),
('2021-07-18',2021,1006,'P109',70),
('2020-10-25',2021,1007,'P110',260),
('2021-03-14',2021,1007,'P101',75),
('2021-06-05',2021,1007,'P106',120),
('2020-12-29',2021,1008,'P107',280),
('2021-04-03',2021,1008,'P102',60),
('2021-08-27',2021,1008,'P111',240);

-- Validation
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
