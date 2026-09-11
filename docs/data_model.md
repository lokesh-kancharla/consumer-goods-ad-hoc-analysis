# Data Model

This project uses 6 simple tables to analyze consumer-goods sales in the U.S.

## Tables

### `dim_customer`
Stores customer information such as customer name, region, and sales channel.

### `dim_product`
Stores product information such as product name, segment, and division.

### `fact_sales_monthly`
Stores sales transactions including date, customer, product, fiscal year, and quantity sold.

### `fact_gross_price`
Stores the selling price of each product by fiscal year.

### `fact_manufacturing_cost`
Stores the manufacturing cost of each product.

### `fact_pre_invoice_deductions`
Stores the discount percentage given to each customer.

## Relationships

```text
dim_customer ── fact_sales_monthly ── dim_product
      |                                  |
      |                                  ├── fact_gross_price
      |                                  |
      |                                  └── fact_manufacturing_cost
      |
      └── fact_pre_invoice_deductions
```

`customer_code` connects customer data to sales and discounts.

`product_code` connects product data to sales, prices, and manufacturing costs.

These tables are used to answer business questions about sales, products, customers, discounts, costs, regions, and sales channels.
