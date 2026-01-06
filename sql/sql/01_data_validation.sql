-- 1. Dataset Date Range
SELECT
  MIN(order_purchase_timestamp) AS first_order,
  MAX(order_purchase_timestamp) AS last_order
FROM orders;

-- 2. Order Status Distribution
SELECT
  order_status,
  COUNT(*) AS cnt
FROM orders
GROUP BY order_status
ORDER BY cnt DESC;

-- 3. System-Level Counts (context only)
SELECT
  COUNT(*) AS total_orders,
  COUNT(DISTINCT customer_id) AS total_customers
FROM orders;

-- 4. True Customer Count (canonical)
SELECT
  COUNT(DISTINCT c.customer_unique_id) AS real_customers
FROM orders o
JOIN customers c
  ON o.customer_id = c.customer_id;
