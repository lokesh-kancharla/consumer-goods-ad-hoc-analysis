-- ==========================================================
-- Consumer Goods Ad-hoc Analysis
-- Step 3: Load Sample Data
-- Author: Lokesh Kancharla
-- Scenario: United States consumer-goods market
-- ==========================================================

USE consumer_goods_db;

START TRANSACTION;

INSERT INTO dim_customer (customer_code, customer, market, region, channel) VALUES
(1001,'BestBuy','USA','Midwest','Retailer'),
(1002,'Amazon','USA','West','E-Commerce'),
(1003,'Walmart','USA','South','Retailer'),
(1004,'Target','USA','Midwest','Retailer'),
(1005,'Costco','USA','West','Warehouse Club'),
(1006,'Staples','USA','Northeast','Retailer'),
(1007,'Newegg','USA','West','E-Commerce'),
(1008,'B&H Photo','USA','Northeast','E-Commerce');

INSERT INTO dim_product (product_code, product, segment, division) VALUES
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

INSERT INTO fact_gross_price (product_code, fiscal_year, gross_price) VALUES
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

INSERT INTO fact_manufacturing_cost (product_code, cost_year, manufacturing_cost) VALUES
('P101',2021,540),('P102',2021,810),
('P103',2021,12),('P104',2021,22),
('P105',2021,100),('P106',2021,185),
('P107',2021,38),('P108',2021,460),
('P109',2021,980),('P110',2021,62),
('P111',2021,115),('P112',2021,70);

INSERT INTO fact_pre_invoice_deductions (customer_code, fiscal_year, pre_invoice_discount_pct) VALUES
(1001,2021,0.0640),
(1002,2021,0.0870),
(1003,2021,0.0750),
(1004,2021,0.0690),
(1005,2021,0.0810),
(1006,2021,0.0520),
(1007,2021,0.0720),
(1008,2021,0.0580);

INSERT INTO fact_sales_monthly
(sale_date, fiscal_year, customer_code, product_code, sold_quantity) VALUES
('2020-09-15',2021,1001,'P101',140),
('2020-10-12',2021,1001,'P103',520),
('2020-11-20',2021,1001,'P105',220),
('2020-12-10',2021,1001,'P108',105),
('2021-01-11',2021,1001,'P102',90),
('2021-02-14',2021,1001,'P104',360),
('2021-03-18',2021,1001,'P106',155),
('2021-04-09',2021,1001,'P107',290),
('2021-05-21',2021,1001,'P109',65),
('2021-06-16',2021,1001,'P110',330),
('2021-07-13',2021,1001,'P111',240),
('2021-08-19',2021,1001,'P112',260),
('2020-09-28',2021,1002,'P103',850),
('2020-12-18',2021,1002,'P102',120),
('2021-03-08',2021,1002,'P105',280),
('2021-06-26',2021,1002,'P111',460),
('2020-11-05',2021,1003,'P104',680),
('2021-01-05',2021,1003,'P101',150),
('2021-04-22',2021,1003,'P107',370),
('2021-08-02',2021,1003,'P112',420),
('2020-09-06',2021,1004,'P108',130),
('2021-02-16',2021,1004,'P105',240),
('2021-05-30',2021,1004,'P103',580),
('2021-07-18',2021,1004,'P109',85),
('2020-10-25',2021,1005,'P110',310),
('2021-03-14',2021,1005,'P101',95),
('2021-06-05',2021,1005,'P106',150),
('2020-12-29',2021,1006,'P107',320),
('2021-04-03',2021,1006,'P102',70),
('2021-08-27',2021,1006,'P111',260),
('2020-10-02',2021,1007,'P106',190),
('2021-02-07',2021,1007,'P110',420),
('2021-07-07',2021,1007,'P111',300),
('2020-11-19',2021,1008,'P105',160),
('2021-05-12',2021,1008,'P101',100),
('2021-06-22',2021,1008,'P112',210);

COMMIT;
