# 🛒 Olist Marketplace SQL Analytics

A structured SQL analytics project built on real transactional data from the **Olist Brazilian e-commerce marketplace**, designed to extract **reliable, decision-ready insights** across revenue performance, operational efficiency, cancellations, and customer behavior.

This project focuses on **accurate metric definition**, **production-grade SQL logic**, and **clear business interpretation**, transforming raw marketplace data into insights that support reporting, performance tracking, and strategic decision-making.

---

## 🔍 What This Project Covers

### 📈 Revenue & Growth Analysis  
Track how **delivered orders**, **GMV**, and **average order value (AOV)** evolve over time using clean, gap-free monthly metrics.

### 🚚 Operational Performance  
Measure real fulfillment efficiency by analyzing **order cycle times** from purchase to customer delivery.

### ❌ Cancellation Analysis  
Identify when cancellations occur using **decision-month logic**, ensuring accurate attribution and trustworthy cancellation rates.

### 👥 Customer Behavior  
Analyze true customer retention using **stable customer identity**, including **repeat customer rate** and **time to second purchase**.

---

## 🧠 Analytical Philosophy

- Business-correct definitions over surface-level counts  
- Metrics designed to reflect **realized business value**, not system artifacts  
- Explicit handling of edge cases (NULLs, duplicates, timing mismatches)  
- SQL written for **clarity, correctness, and scalability**

---

## 📦 Dataset

- **Source:** Public Olist Brazilian e-commerce dataset (Brazil)
- **Core Tables Used:**  
  - `orders`  
  - `order_items`  
  - `customers`  
  - `sellers`  
  - `products`

Customer-level analysis is performed using **`customer_unique_id`** to represent true customer identity rather than session-level IDs.

---

## 🛠 Tools & Environment

- SQL (SQLite-compatible)
- Relational data modeling
- Time-series aggregation
- Window functions for customer lifecycle analysis

---

## 📊 Key Metrics Produced

- Monthly delivered orders  
- Monthly GMV and AOV  
- Average order cycle time  
- Monthly cancellation rate (decision-based)  
- Repeat customer rate  
- Average time to second purchase

---

## ⚠️ Assumptions & Limitations

- Analysis is limited to delivered and canceled orders where relevant timestamps are available  
- Revenue is calculated using item prices (shipping excluded)  
- Results reflect historical data and do not imply future performance

---

## 📌 Summary

This repository demonstrates how raw marketplace data can be transformed into **trustworthy business metrics** using disciplined SQL design, thoughtful aggregation, and careful handling of real-world data issues.
