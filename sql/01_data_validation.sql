/* =========================================================
   FILE: 01_data_validation.sql
   PURPOSE: Dataset sanity checks & canonical identity setup
   NOTE: Metrics here are contextual — NOT business KPIs
   ========================================================= */


/* =========================================================
   1. DATASET DATE RANGE
   Purpose: Confirm analytical coverage window
   ========================================================= */

SELECT
    MIN(order_purchase_timestamp) AS first_order,
    MAX(order_purchase_timestamp) AS last_order
FROM orders;


/* =========================================================
   2. ORDER STATUS DISTRIBUTION (EDA ONLY)
   Purpose: Understand order lifecycle composition
   ========================================================= */

SELECT
    order_status,
    COUNT(*) AS cnt
FROM orders
GROUP BY order_status
ORDER BY cnt DESC;


/* =========================================================
   3. SYSTEM-LEVEL COUNTS (CONTEXT ONLY)
   Purpose: Demonstrate why customer_id is misleading
   ========================================================= */

-- customer_id is NOT a stable customer identifier
SELECT
    COUNT(*)                    AS total_orders,
    COUNT(DISTINCT customer_id) AS total_customers
FROM orders;


/* =========================================================
   4. TRUE CUSTOMER COUNT (CANONICAL)
   Purpose: Define real customer base using stable identity
   ========================================================= */

SELECT
    COUNT(DISTINCT c.customer_unique_id) AS real_customers
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id;
