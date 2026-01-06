# SQL Notes

This folder contains the SQL logic used to define and validate business metrics.
Only **delivered orders** are used wherever outcomes are measured.

## Key Principles
- Canonical customer identity is `customer_unique_id`
- One file = one responsibility
- Core KPIs are intentionally minimal and stable
- Optional / descriptive analysis is kept separate

## File Intent
- `01_data_validation.sql`  
  Sanity checks and identity validation (not KPIs)

- `02_core_business_kpis.sql`  
  Single canonical monthly KPI query (orders, GMV, AOV)

- `03_operations_metrics.sql`  
  Fulfillment efficiency and cancellation behavior

- `04_customer_analytics.sql`  
  Retention and repurchase timing

- `05_marketplace_extensions.sql`  
  Optional geographic and seller-side insights

## Notes
- Metrics are written to be readable without execution
- Assumptions are documented inline in SQL comments

