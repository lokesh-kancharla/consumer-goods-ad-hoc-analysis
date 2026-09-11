# Consumer Goods Ad-hoc Analysis

A simple MySQL portfolio project that analyzes consumer-goods sales in the U.S.

The goal is to use SQL to answer business questions about sales, products, customers, discounts, manufacturing costs, regions, and sales channels.

## Tools

- MySQL
- SQL
- Power BI

## Database

`consumer_goods_db`

## Project Files

```text
sql/00_init_database.sql   - Creates the database
sql/01_schema.sql          - Creates the tables
sql/02_seed_data.sql       - Loads sample data
sql/03_validation.sql      - Checks the data load
sql/04_analysis.sql        - Answers the business questions
```

Run the SQL files in the order shown above.

## Data

The project contains 6 tables:

- `dim_customer` - customer, region, and sales channel
- `dim_product` - product, segment, and division
- `fact_sales_monthly` - sales quantity and date
- `fact_gross_price` - product prices
- `fact_manufacturing_cost` - product manufacturing costs
- `fact_pre_invoice_deductions` - customer discounts

The sample dataset uses U.S. customers such as BestBuy, Amazon, Walmart, Target, Costco, Staples, Newegg, and B&H Photo. The figures are synthetic and are used only for portfolio analysis.

## Business Questions

1. Which U.S. regions generated the highest gross sales in FY2025?
2. What was the percentage increase in unique products from FY2024 to FY2025?
3. How many unique products are available in each segment?
4. Which segments grew from FY2024 to FY2025?
5. Which products had the highest and lowest manufacturing costs in FY2025?
6. Which U.S. customers received the highest discounts in FY2025?
7. What was BestBuy's monthly gross sales trend in FY2025?
8. Which fiscal quarter had the highest sold quantity in FY2025?
9. What percentage of gross sales came from each U.S. sales channel in FY2025?
10. What are the top 3 products by sold quantity within each division in FY2025?

## SQL Skills Used

- JOINs
- GROUP BY
- SUM and COUNT
- MIN and MAX
- CTEs
- CASE statements
- Date functions
- Percentage calculations
- DENSE_RANK

## Project Structure

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
