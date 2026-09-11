# Consumer Goods Ad-hoc Analysis

A portfolio-ready MySQL project that demonstrates an end-to-end analytical workflow: database initialization, relational schema design, reproducible data loading, validation, and business analysis.

## Project Objective

Use SQL to answer practical management questions across customers, products, pricing, manufacturing cost, discounts, and sales. The project is intentionally structured like a small analytical codebase rather than a collection of disconnected SQL files.

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

Creates 2 dimension tables and 4 fact tables with:

- Primary keys
- Foreign keys
- Data types
- NOT NULL rules
- CHECK constraints
- Useful indexes for common joins and filters

### Step 3 — Load sample data

`sql/02_seed_data.sql`

Loads the reproducible dataset inside a transaction. If the script completes successfully, `COMMIT` saves the inserted records.

### Step 4 — Validate the load

`sql/03_validation.sql`

Runs row-count checks and orphan-record checks. The referential-integrity checks should return `0` issues.

### Step 5 — Run the business analysis

`sql/04_analysis.sql`

Contains 10 ad-hoc analytical requests covering product growth, manufacturing cost, discounting, customer sales, quarterly volume, channel contribution, and product ranking.

## MySQL Workbench Instructions

1. Open MySQL Workbench and connect to your MySQL server.
2. Open and execute `sql/00_init_database.sql`.
3. Execute `sql/01_schema.sql`.
4. Execute `sql/02_seed_data.sql`.
5. Execute `sql/03_validation.sql` and confirm the load is valid.
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

- `dim_customer` — customer name, market, region, and channel
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

1. Which APAC markets does Croma operate in?
2. How much did the number of unique products grow from FY2020 to FY2021?
3. Which product segments contain the most products?
4. Which segment experienced the strongest product growth?
5. Which products have the highest and lowest manufacturing costs?
6. Which Indian customers receive the highest average pre-invoice discounts?
7. How do Croma's gross sales trend month by month?
8. Which fiscal quarter generated the highest sold quantity?
9. What percentage of gross sales comes from each sales channel?
10. What are the top three products by sold quantity within each division?

## SQL Skills Demonstrated

- Database creation and initialization
- Fact/dimension table modeling
- Primary and foreign keys
- Data integrity constraints
- Index creation
- Transaction-controlled data loading
- JOINs
- GROUP BY and aggregation
- CTEs
- CASE expressions
- Window functions
- `DENSE_RANK()`
- Percentage calculations
- Date-based analysis
- Validation queries
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

> This repository is an original portfolio implementation based on a consumer-goods ad-hoc analytics use case. The codebase is designed to be reproducible, explainable in interviews, and easy for another developer or analyst to run locally.

### Portfolio vs. production

This is a production-style portfolio project, not a live production application. A real production deployment would normally add environment-specific configuration, secrets management, migrations, automated testing, CI/CD, access controls, monitoring, and backup/recovery procedures.