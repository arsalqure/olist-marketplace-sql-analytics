# 🛒 Olist Marketplace SQL Analytics

A structured SQL analytics project built on real transactional data from the **Olist Brazilian e-commerce marketplace**, focused on generating **accurate, decision-ready business metrics** across revenue performance, operational efficiency, cancellations, and customer behavior.

The project prioritizes **correct metric definitions**, **robust SQL logic**, and **clear business interpretation**, ensuring insights reflect real marketplace activity rather than system artifacts.

---

## 📌 Project Scope

This analysis addresses key marketplace questions, including:

- How do **delivered orders, GMV, and AOV** trend over time?
- How efficient is the **order fulfillment process** from purchase to delivery?
- When should **cancellations** be attributed to ensure accurate reporting?
- How many customers genuinely **return**, and how long does it take?
- How is revenue distributed across **sellers and customer regions**?

All metrics are designed to represent **realized business value**.

---

## 🔍 What This Project Covers

### 📈 Revenue & Growth  
Analyze monthly trends in **delivered orders**, **Gross Merchandise Value (GMV)**, and **Average Order Value (AOV)** using consistent, delivered-only definitions.

### 🚚 Operations & Fulfillment  
Measure fulfillment efficiency through **average order cycle time** (purchase → customer delivery).

### ❌ Cancellations  
Calculate **monthly cancellation rates** using decision-month logic to avoid timing bias caused by delivery delays.

### 👥 Customer Behavior  
Evaluate customer retention using **true customer identity**, including:
- Repeat customer rate  
- Average time to second purchase  

### 🏪 Marketplace Extensions  
Explore revenue distribution across **customer states** and analyze **seller-level performance**, including order volume, complexity, and revenue efficiency.

---

## 🧠 Analytical Principles

- Business-correct definitions over surface-level counts  
- Delivered orders used as the basis for revenue and customer metrics  
- Explicit handling of edge cases (NULL values, duplicate identifiers, timing mismatches)  
- SQL written for **clarity, correctness, and scalability**

---

## 📦 Dataset

- **Source:** Public Olist Brazilian e-commerce dataset  
- **Time Range:** 2016–2018  

### Core Tables Used
- `orders`
- `order_items`
- `customers`
- `sellers`
- `products`

Customer-level analysis is performed using **`customer_unique_id`**, which represents a true customer across multiple orders.  
`customer_id` is treated as a technical identifier only.

---

## 🛠 Tools & Environment

- SQL (SQLite-compatible)
- Common Table Expressions (CTEs)
- Recursive CTEs for calendar-based analysis
- Window functions for customer behavior metrics
- Time-series aggregation and NULL-safe calculations

---

## 📊 Key Metrics Produced

- Monthly delivered orders  
- Delivered GMV and AOV  
- Average order cycle time  
- Monthly cancellation rate (decision-based)  
- Repeat customer rate  
- Average time to second purchase  
- Seller and geographic revenue distribution  

---

## ⚠️ Assumptions & Limitations

- Revenue calculations include item prices only (shipping excluded)
- Only delivered orders represent realized revenue
- No marketing or channel attribution available
- Results reflect historical behavior and do not imply future performance

These limitations are explicit and intentional.

---

## 📌 Summary

This repository demonstrates how marketplace transaction data can be translated into **trustworthy business metrics** using disciplined SQL design, careful aggregation logic, and thoughtful handling of real-world data constraints.
