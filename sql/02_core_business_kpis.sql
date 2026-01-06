/* =====================================================================
   FILE        : 02_core_business_kpis.sql
   PURPOSE     : Core Business KPIs — Monthly Revenue & Unit Economics
   DATASET     : Olist Brazilian E-Commerce (2016–2018)

   CANONICAL KPI DEFINITIONS
   ---------------------------------------------------------------------
   • Scope              : Delivered orders only
   • GMV                : Sum of item-level prices
   • Delivered Orders   : Count of distinct delivered order_id
   • AOV                : GMV ÷ Delivered Orders
   • Time Grain         : Monthly (calendar-safe)

   DESIGN DECISION
   ---------------------------------------------------------------------
   A recursive calendar CTE is intentionally used to:
   • Preserve months with zero delivered orders
   • Avoid false gaps in time-series trends
   • Maintain a single, authoritative KPI query

   NOTE
   ---------------------------------------------------------------------
   This file contains ONE canonical KPI query by design.
   No exploratory or derived metrics belong here.
   ===================================================================== */


/* =====================================================================
   CALENDAR-SAFE MONTHLY GMV, DELIVERED ORDERS & AOV
   ===================================================================== */

WITH RECURSIVE calendar (month) AS (

    -- Start from first purchase month in dataset
    SELECT
        strftime('%Y-%m', MIN(order_purchase_timestamp))
    FROM orders

    UNION ALL

    -- Increment month-by-month until last purchase month
    SELECT
        strftime('%Y-%m', date(month || '-01', '+1 month'))
    FROM calendar
    WHERE month < (
        SELECT strftime('%Y-%m', MAX(order_purchase_timestamp))
        FROM orders
    )
)

SELECT
    c.month                                   AS order_month,
    COUNT(DISTINCT o.order_id)                AS delivered_orders,
    ROUND(COALESCE(SUM(oi.price), 0), 2)      AS delivered_gmv,
    ROUND(
        COALESCE(SUM(oi.price), 0)
        / NULLIF(COUNT(DISTINCT o.order_id), 0),
        2
    )                                         AS aov
FROM calendar c
LEFT JOIN orders o
    ON strftime('%Y-%m', o.order_purchase_timestamp) = c.month
   AND o.order_status = 'delivered'
LEFT JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY c.month
ORDER BY c.month;

