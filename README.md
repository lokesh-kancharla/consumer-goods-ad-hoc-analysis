# Consumer Goods Ad-hoc Analysis

A SQL portfolio project focused on answering practical business questions for a fictional consumer-goods company.

## Project Objective
Use SQL to analyze sales, customers, products, markets, discounts, and manufacturing costs and convert raw transactional data into decision-ready insights.

## Database Name

```sql
consumer_goods_db
```

The database name is consistent across the project. The setup script creates `consumer_goods_db`, and the analysis script starts with `USE consumer_goods_db;`.

## How to Run the Project

### Option 1 — MySQL Workbench
1. Open MySQL Workbench.
2. Open `sql/00_create_database.sql`.
3. Click the lightning/execute button. This creates the database, tables, sample data, and validation counts.
4. Open `sql/02_analysis.sql`.
5. Execute each request one by one to see the results.

### Option 2 — MySQL Command Line

```bash
mysql -u root -p < sql/00_create_database.sql
mysql -u root -p consumer_goods_db < sql/02_analysis.sql
```

## File Execution Order

Recommended:

```text
sql/00_create_database.sql
        ↓
sql/02_analysis.sql
```

Manual alternative:

```text
Create/select database manually
        ↓
sql/00_schema.sql
        ↓
sql/01_sample_data.sql
        ↓
sql/02_analysis.sql
```

## Business Questions Covered
1. Identify markets where a major customer operates.
2. Measure year-over-year growth in unique products.
3. Find product segments with the largest product counts.
4. Identify segments with the strongest product growth.
5. Find products with the highest and lowest manufacturing costs.
6. Rank customers by average pre-invoice discount.
7. Track monthly gross sales for a key customer.
8. Identify the quarter with the highest sold quantity.
9. Rank sales channels by gross sales contribution.
10. Identify top products within each product division.

## SQL Skills Demonstrated
- Database creation
- Primary keys and foreign keys
- Dimension and fact table design
- JOINs
- GROUP BY and aggregation
- CTEs
- Window functions
- CASE expressions
- Percentage calculations
- Ranking
- Date-based analysis
- Business KPI calculations

## Repository Structure
- `sql/00_create_database.sql` — complete database setup script with database creation, tables, sample data, and validation checks
- `sql/00_schema.sql` — table schema only
- `sql/01_sample_data.sql` — sample dataset only
- `sql/02_analysis.sql` — 10 business analysis queries
- `docs/business_questions.md` — business context for each request
- `Consumer_Goods_Ad_Hoc_Analysis_5_Slide_Lokesh_Kancharla.pptx` — project presentation deck

## Data Model
The project uses 2 dimension tables and 4 fact tables.

### Dimension Tables
- `dim_customer` stores customer information such as customer code, customer name, market, region, and channel.
- `dim_product` stores product information such as product code, product name, segment, and division.

### Fact Tables
- `fact_sales_monthly` stores monthly sales transactions by customer, product, fiscal year, date, and sold quantity.
- `fact_gross_price` stores product price by fiscal year.
- `fact_manufacturing_cost` stores product manufacturing cost by cost year.
- `fact_pre_invoice_deductions` stores customer discount percentage by fiscal year.

### Table Relationships
- `dim_customer.customer_code` connects to `fact_sales_monthly.customer_code`.
- `dim_customer.customer_code` connects to `fact_pre_invoice_deductions.customer_code`.
- `dim_product.product_code` connects to `fact_sales_monthly.product_code`.
- `dim_product.product_code` connects to `fact_gross_price.product_code`.
- `dim_product.product_code` connects to `fact_manufacturing_cost.product_code`.

## Author
Lokesh Kancharla

> This project is an original portfolio implementation inspired by common consumer-goods ad-hoc SQL case-study patterns. The schema, sample data, documentation, and SQL organization in this repository were prepared for this portfolio project.
