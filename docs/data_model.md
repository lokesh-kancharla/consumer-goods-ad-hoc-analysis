# Data Model

The project uses a small star-style analytical model with 2 dimension tables and 4 fact tables for a U.S.-focused consumer-goods analytics scenario.

## Dimension tables

### `dim_customer`
One row per U.S. customer account.

Primary key: `customer_code`

Important fields:
- `customer` — customer/account name such as BestBuy, Amazon, Walmart, Target, Costco, Staples, Newegg, and B&H Photo
- `market` — set to `USA` for this portfolio dataset
- `region` — U.S. operating region such as Midwest, West, South, and Northeast
- `channel` — sales channel such as Retailer, E-Commerce, or Warehouse Club

Used by:
- `fact_sales_monthly.customer_code`
- `fact_pre_invoice_deductions.customer_code`

Relationship: one customer can have many sales rows and one discount record per fiscal year.

### `dim_product`
One row per product.

Primary key: `product_code`

Used by:
- `fact_sales_monthly.product_code`
- `fact_gross_price.product_code`
- `fact_manufacturing_cost.product_code`

Relationship: one product can appear in many sales rows, pricing records, and cost records.

## Fact tables

### `fact_sales_monthly`
Stores sales activity by date, customer, product, and fiscal year.

Foreign keys:
- `customer_code` → `dim_customer.customer_code`
- `product_code` → `dim_product.product_code`

### `fact_gross_price`
Stores product gross price by fiscal year.

Foreign key:
- `product_code` → `dim_product.product_code`

Composite primary key:
- (`product_code`, `fiscal_year`)

### `fact_manufacturing_cost`
Stores manufacturing cost by product and cost year.

Foreign key:
- `product_code` → `dim_product.product_code`

Composite primary key:
- (`product_code`, `cost_year`)

### `fact_pre_invoice_deductions`
Stores customer-level pre-invoice discount percentage by fiscal year.

Foreign key:
- `customer_code` → `dim_customer.customer_code`

Composite primary key:
- (`customer_code`, `fiscal_year`)

## Relationship summary

```text
dim_customer (1) ─────< fact_sales_monthly (*) >───── (1) dim_product
      |                                                    |
      |                                                    ├────< fact_gross_price (*)
      |                                                    |
      |                                                    └────< fact_manufacturing_cost (*)
      |
      └────< fact_pre_invoice_deductions (*)
```

The customer dimension supports U.S. region, customer, and channel analysis. The product dimension supports product-segment, product-division, cost, price, and ranking analysis.
