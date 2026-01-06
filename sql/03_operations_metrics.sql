/* =====================================================================
   FILE        : 03_operations_metrics.sql
   PURPOSE     : Operational Reality & Execution Quality
   DATASET     : Olist Brazilian E-Commerce (2016–2018)

   METRIC SCOPE
   ---------------------------------------------------------------------
   This file evaluates fulfillment execution after an order is placed.
   Focus areas:
   • Speed of fulfillment (cycle time)
   • Reliability of execution (cancellations)

   IMPORTANT
   ---------------------------------------------------------------------
   • Metrics here describe operational outcomes, not revenue
   • All logic is post-purchase and execution-focused
   • No customer or seller segmentation is applied in this file
   ===================================================================== */


/* =====================================================================
   6. AVERAGE ORDER CYCLE TIME (PURCHASE → DELIVERY)
   PURPOSE: Measure fulfillment efficiency for completed orders
   ===================================================================== */

SELECT
    ROUND(
        AVG(
            julianday(order_delivered_customer_date)
            - julianday(order_purchase_timestamp)
        ),
        2
    ) AS avg_order_cycle_days
FROM orders
WHERE order_status = 'delivered';


/* =====================================================================
   7. MONTHLY CANCELLATION RATE (DECISION-MONTH, CANONICAL)
   PURPOSE: Measure true cancellation behavior without timing bias

   LOGIC NOTES
   ---------------------------------------------------------------------
   • Canceled orders are attributed to PURCHASE month
   • Delivered orders are attributed to DELIVERY month
   • This aligns cancellations with the business decision point
   • ONLY finalized orders (delivered + canceled) are included
   ===================================================================== */

WITH decision_month AS (

    SELECT
        CASE
            WHEN order_status = 'canceled'
                THEN strftime('%Y-%m', order_purchase_timestamp)
            WHEN order_status = 'delivered'
                THEN strftime('%Y-%m', order_delivered_customer_date)
        END AS month,
        order_status
    FROM orders
    WHERE order_status IN ('delivered', 'canceled')

)

SELECT
    month,
    COUNT(*)                                AS finalized_orders,
    SUM(order_status = 'canceled')          AS canceled_orders,
    ROUND(
        100.0 * SUM(order_status = 'canceled') / COUNT(*),
        2
    )                                       AS cancel_rate_pct
FROM decision_month
WHERE month IS NOT NULL
GROUP BY month
ORDER BY month;
