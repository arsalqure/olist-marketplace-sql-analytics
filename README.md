# 🛒 Olist E-Commerce — SQL Analytics

> **What drives revenue, retention, and customer satisfaction across 100K orders on Brazil's largest marketplace dataset — answered in SQL, validated to the cent.**

![SQL](https://img.shields.io/badge/SQL-Advanced-1f6feb?style=flat-square)
![Engine](https://img.shields.io/badge/Engine-SQLite%20%2F%20MySQL%208-003b57?style=flat-square)
![Dataset](https://img.shields.io/badge/Dataset-Olist%20(100K%20orders)-ff6b35?style=flat-square)
![Window Functions](https://img.shields.io/badge/Window%20Functions-%E2%9C%94-16a34a?style=flat-square)
![Reconciled](https://img.shields.io/badge/Revenue%20reconciled-within%200.02%25-16a34a?style=flat-square)

A rigorous, reproducible SQL analysis of the **Olist Brazilian E-Commerce** dataset (99,441 orders, 96K customers, 3,095 sellers, Sep 2016 – Oct 2018). Built around one principle: **every metric is defined once, scoped honestly, and reconciled against ground truth before it's reported.**

---

## 🎯 Key Findings

| # | Finding | The number |
|---|---------|-----------|
| 1 | **Delivery speed is the #1 satisfaction lever.** Late orders don't just annoy — they collapse ratings. | 4.48★ → **2.25★** as delivery slips past 30 days; negative reviews jump **6.6% → 63%** |
| 2 | **Retention — not acquisition — is the growth ceiling.** The business acquires well but barely re-engages. | Only **3.0%** of customers ever place a second order |
| 3 | **Revenue is geographically concentrated.** Logistics investment has an obvious target. | **São Paulo = 38%** of GMV; top 3 states = **63%** |
| 4 | **The revenue model is financially sound.** Item-level GMV ties out to actual customer payments. | Reconciles within **0.02%** (R$2,688 of R$15.4M) |
| 5 | **Brazil runs on credit installments.** Payment design matters for this market. | Credit card = **78%** of payment value, avg **3.5** installments |

---

## 📊 The Headline Insight

![Delivery speed vs customer satisfaction](delivery_vs_satisfaction.png)

> Orders delivered in **≤3 days average 4.48★** with just 6.6% negative reviews. Once delivery crosses **30 days**, the average rating falls to **2.25★** and **63% of reviews turn negative.** The relationship is clean and monotonic across every bucket — delivery time is not *a* factor in satisfaction, it is *the* factor.

---

## 💡 What I'd Do With This

- **Treat delivery SLA as a CSAT program, not a logistics metric.** The data shows the cliff is between the 15–30 day and 30+ day buckets — set an internal hard ceiling well before 30 days and the negative-review rate stays in single digits.
- **Shift budget from acquisition to retention.** A 3% repeat rate means nearly all GMV is one-and-done. Even a few points of repeat-rate improvement compounds faster than buying new customers.
- **Concentrate fulfillment investment in SP / RJ / MG.** Three states drive ~63% of revenue; faster delivery there protects the majority of the rating base.
- **Lean into installment-friendly checkout.** Credit installments dominate payment behavior — friction here is friction on 78% of revenue.

---

## 📈 Business Context

![Monthly merchandise GMV](monthly_gmv.png)

The marketplace scaled from a near-standing start in late 2016 to roughly **R$1M in monthly merchandise GMV** through 2018, on a stable **~R$135 average order value.** Total delivered merchandise GMV across the window: **R$13.2M** (R$15.4M including freight).

| Metric | Value |
|---|---|
| Orders (all statuses) | 99,441 |
| Delivered orders | 96,478 (97.0%) |
| Unique customers | 96,096 |
| Merchandise GMV | R$13,221,498 |
| Gross billings (incl. freight) | R$15,419,774 |
| Customer payments (reconciliation) | R$15,422,462 → **0.02% residual** |
| Repeat-purchase rate | 3.0% |
| Avg. order cycle time | 12.6 days |

---

## 🗂️ Repository Structure

The project is split into numbered files that run in order. **Scope and revenue grain are defined once** in `00` and inherited everywhere else — change the definition of "realized revenue" in one place and the whole project follows.

| File | What it does |
|---|---|
| `00_canonical_views.sql` | Canonical scope + grain. Defines the "delivered order" universe and order-grain revenue **once** as reusable views. |
| `01_data_validation.sql` | Sanity checks, canonical customer identity, and referential-integrity proofs (zero orphaned joins). |
| `02_core_business_kpis.sql` | Monthly GMV, gross billings, and AOV on a gap-free calendar. |
| `03_operations_metrics.sql` | Order cycle time + a censor-aware monthly cancellation rate. |
| `04_customer_analytics.sql` | Repeat rate, time-to-second-purchase, and an acquisition-cohort retention curve. |
| `05_marketplace_extensions.sql` | Revenue by state, seller performance, and top categories. |
| `06_payments_and_reviews.sql` | Revenue reconciliation, payment-mix profiling, and the delivery-vs-satisfaction analysis. |
| `olist_analysis_colab.ipynb` | One-click runnable notebook — loads the data and runs all 16 queries with results inline. |

---

## 🔬 What Makes This Analysis Rigorous

This is the part that separates a query dump from an analysis:

- **Canonical identity.** `customer_id` is minted *per order* in this dataset; the real person is `customer_unique_id`. Using the wrong one inflates the customer count by ~3,300 and breaks every retention metric. This is resolved up front.
- **Fan-out is neutralized.** Revenue is aggregated to **order grain** in a view, so GMV queries never silently double-count when an order has multiple line items.
- **A coherent cancellation cohort.** A naïve version attributes cancellations and deliveries to *different* time buckets, producing a metric that measures nothing (and even invents phantom months). Here, the rate is "of orders **placed** in month *M*, what fraction were canceled" — one cohort, one denominator.
- **Right-censoring is handled.** Orders placed at the dataset's edge haven't had time to finalize, so those months are flagged `CENSORED` instead of being reported as if mature.
- **Deterministic window functions.** 265 customers have two orders sharing an identical timestamp; every `ROW_NUMBER`/`LEAD` includes a tiebreaker so results are reproducible run-to-run.
- **Reconciliation as proof of trust.** GMV is tied out against actual payments (within 0.02%) — the residual is fully explained by freight and vouchers. A reviewer who sees the numbers reconcile trusts everything else.

---

## 🛠️ How to Run

**Zero setup (recommended):** open `olist_analysis_colab.ipynb` in [Google Colab](https://colab.research.google.com), drag the 8 CSVs into the file panel, and choose **Runtime → Run all**. Every result renders inline.

**Locally:** any SQLite client (e.g. [DB Browser for SQLite](https://sqlitebrowser.org)) — run `00` first, then `01`–`06`. MySQL 8.0+ versions of each query are also included.

---

## 📋 Dataset & Scope

- **Source:** [Olist Brazilian E-Commerce Public Dataset](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) (Kaggle).
- **Scope:** Core KPIs are computed on **delivered orders only** (realized revenue/behavior). This is stated explicitly in every file.
- **Honest framing:** This is a focused **SQL analytics** project — its value is in metric rigor and the business reasoning, not in pipeline orchestration or dashboarding. Numbers throughout were verified against the raw data.

---

<sub>Built to be read by a hiring manager in 30 seconds and defended in a technical interview for 30 minutes.</sub>
