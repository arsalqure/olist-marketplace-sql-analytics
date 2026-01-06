/* =====================================================================
   FILE        : 04_customer_analytics.sql
   PURPOSE     : Growth Reality & Customer Behavior
   DATASET     : Olist Brazilian E-Commerce (2016–2018)

   ANALYTICAL FOCUS
   ---------------------------------------------------------------------
   This file evaluates customer growth quality beyond top-line metrics.
   It answers:
   • Do customers come back? (retention)
   • How quickly do they return? (repurchase velocity)

   IMPORTANT
   ---------------------------------------------------------------------
   • Canonical customer identity: customer_unique_id
   • Delivered orders only (realized behavior)
   • Metrics are customer-level, not order-level
   ===================================================================== */


/* =====================================================================
   8. REPEAT CUSTOMER RATE (BINARY RETENTION)
   PURPOSE: Measure true retention (repeat vs one-time customers)
   ===================================================================== */

SELECT
    COUNT(*)                                AS customers,
    SUM(total_orders > 1)                   AS repeat_customers,
    ROUND(
        100.0 * SUM(total_orders > 1) / COUNT(*),
        2
    )                                       AS repeat_pct
FROM (
    SELECT
        c.customer_unique_id,
        COUNT(DISTINCT o.order_id)          AS total_orders
    FROM orders o
    JOIN customers c
        ON o.customer_id = c.customer_id
    WHERE o.order_status = 'delivered'
    GROUP BY c.customer_unique_id
);


/* =====================================================================
   9. AVERAGE TIME TO SECOND PURCHASE
   PURPOSE: Measure repurchase velocity (depth, not just rate)

   INTERPRETATION
   ---------------------------------------------------------------------
   • Lower values indicate faster customer re-engagement
   • Only customers with at least two delivered orders are included
   • First → second purchase gap is used (cleanest signal)
   ===================================================================== */

WITH customer_orders AS (

    SELECT
        c.customer_unique_id,
        o.order_purchase_timestamp,
        ROW_NUMBER() OVER (
            PARTITION BY c.customer_unique_id
            ORDER BY o.order_purchase_timestamp
        )                                   AS rn
    FROM orders o
    JOIN customers c
        ON o.customer_id = c.customer_id
    WHERE o.order_status = 'delivered'

)

SELECT
    ROUND(
        AVG(
            julianday(o2.order_purchase_timestamp)
            - julianday(o1.order_purchase_timestamp)
        ),
        2
    )                                       AS avg_days_to_second_order
FROM customer_orders o1
JOIN customer_orders o2
    ON o1.customer_unique_id = o2.customer_unique_id
WHERE o1.rn = 1
  AND o2.rn = 2;
