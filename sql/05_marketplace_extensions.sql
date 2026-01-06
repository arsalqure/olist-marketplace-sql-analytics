/* =====================================================================
   FILE        : 05_marketplace_extensions.sql
   PURPOSE     : Marketplace Extensions (Optional Depth)
   DATASET     : Olist Brazilian E-Commerce (2016–2018)

   SCOPE NOTE
   ---------------------------------------------------------------------
   This file contains OPTIONAL, descriptive extensions that add context
   to marketplace behavior but are NOT core KPIs.

   These queries are intentionally separated to:
   • Avoid polluting executive metrics
   • Provide exploratory and strategic depth
   • Support geographic and supply-side insights

   IMPORTANT
   ---------------------------------------------------------------------
   • Delivered orders only
   • Metrics here are descriptive, not canonical
   ===================================================================== */


/* =====================================================================
   10. REVENUE BY CUSTOMER STATE
   PURPOSE: Geographic demand distribution
   TYPE   : Optional / Descriptive
   ===================================================================== */

SELECT
    c.customer_state,
    COUNT(DISTINCT o.order_id)        AS orders,
    ROUND(SUM(oi.price), 2)           AS revenue
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY c.customer_state
ORDER BY revenue DESC;


/* =====================================================================
   11. SELLER PERFORMANCE — REVENUE, VOLUME & COMPLEXITY
   PURPOSE: Supply-side marketplace intelligence
   TYPE   : Strong optional extension
   ===================================================================== */

SELECT
    s.seller_id,
    s.seller_state,
    COUNT(DISTINCT o.order_id)        AS delivered_orders,
    COUNT(oi.order_item_id)           AS items_sold,
    ROUND(
        COUNT(oi.order_item_id) * 1.0
        / COUNT(DISTINCT o.order_id),
        2
    )                                 AS items_per_order,
    ROUND(SUM(oi.price), 2)           AS delivered_gmv,
    ROUND(
        SUM(oi.price)
        / COUNT(DISTINCT o.order_id),
        2
    )                                 AS gmv_per_order
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN sellers s
    ON oi.seller_id = s.seller_id
WHERE o.order_status = 'delivered'
GROUP BY s.seller_id, s.seller_state
ORDER BY delivered_gmv DESC
LIMIT 20;
