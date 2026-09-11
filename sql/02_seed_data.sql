-- Consumer Goods Ad-hoc Analysis
-- Step 3: Load Sample Data

USE consumer_goods_db;

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
('P101',2024,850),('P101',2025,875),
('P102',2024,1250),('P102',2025,1295),
('P103',2024,35),('P103',2025,38),
('P104',2024,55),('P104',2025,59),
('P105',2024,180),('P105',2025,190),
('P106',2024,320),('P106',2025,335),
('P107',2024,85),('P107',2025,90),
('P108',2024,700),('P108',2025,735),
('P109',2024,1450),('P109',2025,1495),
('P110',2024,110),('P110',2025,105),
('P111',2025,175),('P112',2025,120);

INSERT INTO fact_manufacturing_cost (product_code, cost_year, manufacturing_cost) VALUES
('P101',2025,540),('P102',2025,810),
('P103',2025,12),('P104',2025,22),
('P105',2025,100),('P106',2025,185),
('P107',2025,38),('P108',2025,460),
('P109',2025,980),('P110',2025,62),
('P111',2025,115),('P112',2025,70);

INSERT INTO fact_pre_invoice_deductions (customer_code, fiscal_year, pre_invoice_discount_pct) VALUES
(1001,2025,0.0640),(1002,2025,0.0870),(1003,2025,0.0750),(1004,2025,0.0690),
(1005,2025,0.0810),(1006,2025,0.0520),(1007,2025,0.0720),(1008,2025,0.0580);

INSERT INTO fact_sales_monthly
(sale_date, fiscal_year, customer_code, product_code, sold_quantity) VALUES
('2024-09-15',2025,1001,'P101',140),('2024-10-12',2025,1001,'P103',520),
('2024-11-20',2025,1001,'P105',220),('2024-12-10',2025,1001,'P108',105),
('2025-01-11',2025,1001,'P102',90),('2025-02-14',2025,1001,'P104',360),
('2025-03-18',2025,1001,'P106',155),('2025-04-09',2025,1001,'P107',290),
('2025-05-21',2025,1001,'P109',65),('2025-06-16',2025,1001,'P110',330),
('2025-07-13',2025,1001,'P111',240),('2025-08-19',2025,1001,'P112',260),
('2024-09-28',2025,1002,'P103',850),('2024-12-18',2025,1002,'P102',120),
('2025-03-08',2025,1002,'P105',280),('2025-06-26',2025,1002,'P111',460),
('2024-11-05',2025,1003,'P104',680),('2025-01-05',2025,1003,'P101',150),
('2025-04-22',2025,1003,'P107',370),('2025-08-02',2025,1003,'P112',420),
('2024-09-06',2025,1004,'P108',130),('2025-02-16',2025,1004,'P105',240),
('2025-05-30',2025,1004,'P103',580),('2025-07-18',2025,1004,'P109',85),
('2024-10-25',2025,1005,'P110',310),('2025-03-14',2025,1005,'P101',95),
('2025-06-05',2025,1005,'P106',150),('2024-12-29',2025,1006,'P107',320),
('2025-04-03',2025,1006,'P102',70),('2025-08-27',2025,1006,'P111',260),
('2024-10-02',2025,1007,'P106',190),('2025-02-07',2025,1007,'P110',420),
('2025-07-07',2025,1007,'P111',300),('2024-11-19',2025,1008,'P105',160),
('2025-05-12',2025,1008,'P101',100),('2025-06-22',2025,1008,'P112',210);
