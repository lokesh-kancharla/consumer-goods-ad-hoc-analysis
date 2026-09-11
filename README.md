# Consumer Goods Ad-hoc Analysis

A portfolio-ready MySQL project built around a **U.S. consumer-goods market** scenario. The project demonstrates an end-to-end analytical workflow: database initialization, relational schema design, reproducible data loading, simple validation, and business analysis.

## Project Objective

Use SQL to answer practical management questions across U.S. customers, regions, products, pricing, manufacturing costs, discounts, sales channels, and monthly sales performance.

## Technology

- MySQL 8.0+
- Relational modeling with primary and foreign keys
- CTEs, window functions, aggregations, CASE expressions, ranking, and KPI calculations

## Database Name

```sql
consumer_goods_db
```

Every SQL file explicitly uses the same database name.

## End-to-End Execution Order

Run the files in this exact order:

```text
sql/00_init_database.sql
        ↓
sql/01_schema.sql
        ↓
sql/02_seed_data.sql
        ↓
sql/03_validation.sql
        ↓
sql/04_analysis.sql
```

Each file has one responsibility. There is no duplicate schema creation or duplicate data loading.

### Step 1 — Initialize the database

`sql/00_init_database.sql`

- Drops the old demo database if it exists.
- Creates `consumer_goods_db`.
- Sets UTF-8 character encoding.
- Selects the database for use.

### Step 2 — Create the schema

`sql/01_schema.sql`

Creates 2 dimension tables and 4 fact tables with primary keys, foreign keys, data types, constraints, and indexes.

### Step 3 — Load sample data

`sql/02_seed_data.sql`

Loads a reproducible U.S. market dataset with customers such as BestBuy, Amazon, Walmart, Target, Costco, Staples, Newegg, and B&H Photo.

### Step 4 — Validate the load

`sql/03_validation.sql`

Runs simple row-count checks to confirm each table loaded successfully.

### Step 5 — Run the business analysis

`sql/04_analysis.sql`

Contains 10 ad-hoc analytical requests covering U.S. regional sales, product growth, manufacturing cost, discounting, BestBuy monthly sales, quarterly volume, channel contribution, and product ranking.

## MySQL Workbench Instructions

1. Open MySQL Workbench and connect to your MySQL server.
2. Open and execute `sql/00_init_database.sql`.
3. Execute `sql/01_schema.sql`.
4. Execute `sql/02_seed_data.sql`.
5. Execute `sql/03_validation.sql` and confirm row counts are populated.
6. Execute the queries in `sql/04_analysis.sql` one by one and review the result grids.

## Command-Line Instructions

From the repository root:

```bash
mysql -u root -p < sql/00_init_database.sql
mysql -u root -p < sql/01_schema.sql
mysql -u root -p < sql/02_seed_data.sql
mysql -u root -p < sql/03_validation.sql
mysql -u root -p < sql/04_analysis.sql
```

## Data Model

The project uses 2 dimension tables and 4 fact tables.

### Dimension tables

- `dim_customer` — U.S. customer name, market, region, and channel
- `dim_product` — product name, segment, and division

### Fact tables

- `fact_sales_monthly` — sales activity by date, customer, product, and fiscal year
- `fact_gross_price` — product gross price by fiscal year
- `fact_manufacturing_cost` — manufacturing cost by product and year
- `fact_pre_invoice_deductions` — customer discount percentage by fiscal year

### Relationships

```text
dim_customer (1) ─────< fact_sales_monthly (*) >───── (1) dim_product
      |                                                    |
      |                                                    ├────< fact_gross_price (*)
      |                                                    |
      |                                                    └────< fact_manufacturing_cost (*)
      |
      └────< fact_pre_invoice_deductions (*)
```

More detail is available in `docs/data_model.md`.

## Business Questions Covered

1. Which U.S. regions generated the highest gross sales in FY2021?
2. What was the percentage increase in unique products from FY2020 to FY2021?
3. How many unique products are available in each product segment?
4. Which segment(s) had the largest increase in unique products from FY2020 to FY2021?
5. Which products had the highest and lowest manufacturing costs in FY2021?
6. Which U.S. customers received the highest average pre-invoice discounts in FY2021?
7. What was BestBuy's monthly gross sales trend in FY2021?
8. Which fiscal quarter generated the highest sold quantity in FY2021?
9. What percentage of gross sales came from each U.S. sales channel in FY2021?
10. What are the top 3 products by sold quantity within each division?

## SQL Skills Demonstrated

- Database creation and initialization
- Fact/dimension table modeling
- Primary and foreign keys
- Transaction-controlled data loading
- Simple validation checks
- JOINs
- GROUP BY and aggregation
- CTEs
- CASE expressions
- Window functions
- `DENSE_RANK()`
- Percentage calculations
- Date-based analysis
- Business KPI analysis

## Repository Structure

```text
consumer-goods-ad-hoc-analysis/
├── README.md
├── docs/
│   ├── business_questions.md
│   └── data_model.md
└── sql/
    ├── 00_init_database.sql
    ├── 01_schema.sql
    ├── 02_seed_data.sql
    ├── 03_validation.sql
    └── 04_analysis.sql
```

## Author

Lokesh Kancharla

> This repository is an original portfolio implementation based on a U.S. consumer-goods ad-hoc analytics use case. The codebase is designed to be reproducible, easy to explain in interviews, and simple for another analyst or developer to run locally.

### Portfolio vs. production

This is a production-style portfolio project, not a live production application. A real production deployment would normally add environment-specific configuration, secrets management, migrations, automated testing, CI/CD, access controls, monitoring, and backup/recovery procedures.
