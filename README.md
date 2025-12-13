# 🛒 Olist Marketplace SQL Analytics

A comprehensive SQL analytics project that explores transactional data from the Olist Brazilian e-commerce marketplace to deliver clear, reliable business insights across revenue performance, operational efficiency, and customer behavior.

The project focuses on accurate metric design, well-structured SQL logic, and decision-ready KPIs, transforming raw marketplace data into insights that can support real business analysis and reporting.

---

## 📌 Project Overview

Marketplace leadership teams need reliable answers to questions like:
- How is revenue actually growing over time?
- How efficient is order fulfillment from purchase to delivery?
- How often do customers return — and how long does it take?
- When and why do cancellations happen?

This project converts raw marketplace data into **trusted metrics** that can be confidently used for **business decisions, dashboards, and executive reporting**.

---

## 🎯 Business Questions Answered

✔ Monthly delivered orders, GMV, and AOV (gap-free time series)  
✔ Average end-to-end order fulfillment time  
✔ Cancellation rates based on **decision timing**, not naive purchase dates  
✔ True customer retention using **real customer identity**  
✔ Average time between first and second purchase  

Each metric is built with **explicit assumptions** and **validated logic**.

---

## 📊 Dataset

**Source:** Public Olist Brazilian E-Commerce Dataset  
**Coverage:** 2016-09 to 2018-10  

### Core Tables Used
- `orders`
- `order_items`
- `customers`
- `sellers`
- `products`

### Key Design Choice
Customer analysis is performed using **`customer_unique_id`** (true customer identity),  
not `customer_id` (session-level identifier).

This avoids **fake retention inflation** — a common analytical mistake.

---

## 🧠 Analytical Approach

### 1️⃣ Data Validation
- Verified dataset date range
- Audited order status distribution
- Confirmed true customer counts

### 2️⃣ Revenue & Sales KPIs
- Monthly delivered orders
- Delivered GMV (no double counting)
- AOV with NULL-safe calculations
- Calendar-based logic to avoid missing months

### 3️⃣ Operations & Fulfillment
- Average order cycle time (purchase → delivery)
- Delivery efficiency measurement using completed orders only

### 4️⃣ Cancellation Analysis
- Cancellation rates calculated using **decision month**
- Delivered orders grouped by delivery month
- Canceled orders grouped by purchase month
- Prevents misleading cancellation spikes

### 5️⃣ Customer Behavior
- Repeat customer rate using real customer identity
- Time-to-second-purchase using window functions
- Retention metrics aligned with business reality

---

## 📈 Key Insights (Summary)

- **Customer retention is low (~3%)**, typical of transactional marketplaces
- **Average fulfillment time ≈ 12.5 days**, consistent with logistics-heavy e-commerce
- **Cancellations remain under ~1.5%** after early platform stabilization
- Most repeat purchases occur **2–3 months after the first order**
- Revenue growth accelerates significantly from mid-2017 onward

These insights are **directionally reliable**, not over-fit or exaggerated.

---

## 🛠 Tools & Tech Stack

- **SQL (SQLite-compatible)**
- Window Functions
- CTEs (WITH clauses)
- Date & time arithmetic
- Business-safe aggregations


