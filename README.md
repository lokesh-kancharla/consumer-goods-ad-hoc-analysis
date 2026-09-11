# Consumer Goods Ad-hoc Analysis

A SQL portfolio project focused on answering practical business questions for a fictional consumer-goods company.

## Project Objective
Use SQL to analyze sales, customers, products, markets, discounts, and manufacturing costs and convert raw transactional data into decision-ready insights.

## Database Setup
Run this one script first to create the full database, tables, and sample data:

```sql
source sql/00_create_database.sql;
```

Or in MySQL command line:

```bash
mysql -u root -p < sql/00_create_database.sql
```

Database name:

```sql
consumer_goods_db
```

After setup, run:

```sql
source sql/02_analysis.sql;
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
- JOINs
- GROUP BY and aggregation
- CTEs
- Window functions
- CASE expressions
- Percentage calculations
- Ranking
- Date-based analysis
- Business KPI calculations
- Database creation and table relationships

## Repository Structure
- `sql/00_create_database.sql` — complete database creation script with tables and sample data
- `sql/00_schema.sql` — table schema only
- `sql/01_sample_data.sql` — sample dataset only
- `sql/02_analysis.sql` — 10 business analysis queries
- `docs/business_questions.md` — business context for each request

## Tools
MySQL-compatible SQL

## Author
Lokesh Kancharla

> This project is an original portfolio implementation inspired by common consumer-goods ad-hoc SQL case-study patterns. The schema, sample data, documentation, and SQL organization in this repository were prepared for this portfolio project.
