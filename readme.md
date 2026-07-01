# Product Growth Analytics

An end-to-end Product Growth Analytics case study conducted on the RetailRocket e-commerce clickstream dataset. This project analyzes user behavior across the purchase journey, identifies conversion bottlenecks, segments customers based on purchasing behavior, and presents actionable business recommendations through interactive dashboards.

---

## Business Problem

RetailRocket receives millions of user interactions across its platform, but only a small percentage of users complete a purchase.

This project aims to answer the following business questions:

- How healthy is the overall platform?
- Where do users abandon the purchase journey?
- Which customer segments contribute the greatest value?
- What strategies can improve conversion and customer retention?

---

## Objectives

- Analyze user engagement and purchasing behavior.
- Identify conversion bottlenecks within the purchase funnel.
- Segment customers using behavioral RF (Recency-Frequency) analysis.
- Develop interactive Power BI dashboards for executive reporting.
- Generate actionable business recommendations to improve product growth.

---
## Dashboard Demo

![Dashboard Demo](dashboard-vid.gif)

For detailed report: [Executive Summary (pdf)](executive-summary.pdf)
---

## Dataset

**Dataset used:** RetailRocket E-Commerce Dataset

The RetailRocket dataset contains anonymized clickstream events collected from an e-commerce platform over approximately **4.5 months (May-September 2015)**. It captures how users interact with products throughout their purchasing journey.

#### Original Dataset Files
<details>
<summary>Click to view dataset details</summary>

The dataset consists of three CSV files:
1. events.csv (Primary Dataset) 

Contains every user interaction on the website.

| Column | Description |
|---------|-------------|
| timestamp | Unix timestamp of the event |
| visitorid | Anonymous user identifier |
| event | Interaction type (`view`, `addtocart`, `transaction`) |
| itemid | Product identifier |
| transactionid | Transaction identifier (available only for purchase events) |

This file served as the primary data source for all analyses.


2. item_properties_part1.csv [Not Used]

Contains historical product attributes such as category and property values.

Since the project focuses on **product growth analytics and user behavior**, rather than product catalog analysis or recommendation systems, this file was not required.


3. item_properties_part2.csv [Not Used]

Continuation of product property history, not utilized for the same reason as Part 1.


4. category_tree.csv [Not Used]

Maps product categories into a hierarchical category tree.

This file is primarily useful for product categorization, merchandising, or recommendation system projects and was therefore excluded from this analysis.
</details>


## Data Preparation & Feature Engineering
<details>
<summary>data pre-processing and feature engineering process</summary>

The raw clickstream data required several preprocessing steps before analysis.

Data Cleaning

- - Converted Unix timestamps into Python datetime format.
- - Removed unnecessary columns for specific analyses.
- - Verified missing values and duplicate records.
- - Standardized column names and data types.
- - Exported the cleaned dataset for PostgreSQL and Power BI.


To support time-series analysis and dashboard development, several new features were created from the event timestamp.

| Feature | Purpose |
|---------|---------|
| date | Daily trend analysis |
| month | Monthly filtering and reporting |
| month_name | Readable month labels for dashboards |
| weekday | Weekly activity analysis |
| hour | Hourly traffic and purchase patterns |
| is_weekend | Weekend vs weekday comparison |

These engineered features enabled temporal analysis without repeatedly transforming timestamps during SQL queries or dashboard calculations.

---

## Final Analytical Dataset

The cleaned dataset: clean_events.csv used throughout the project contains: 

- **2.76 million** user interaction events
- **1.41 million** unique users
- **235,061** unique products
- Three interaction types:
  - Product View
  - Add-to-Cart
  - Transaction

Using PostgreSQL, another csv file was derived concluding RF-segmentation & scoring 

</details>

---

## Tools & Technologies

- Python
- PostgreSQL
- Power BI
- Pandas
- Matplotlib
- Seaborn
- Plotly
- Jupyter Notebook

---

## Project Workflow

1. Business Understanding
2. Data Cleaning & Feature Engineering (python)
3. Exploratory Data Analysis (EDA) (python)
4. SQL Analytics & KPI Development (PostgreSQL)
5. Executive/KPI Dashboard (Power BI)  
6. Purchase Funnel Analysis (PostgreSQL & python for visuals during analysis phase)
7. RF User Segmentation (PostgreSQL & python for visuals during analysis phase)
8. Business Recommendations
9. Final Dashboard (Power BI)

*Note:* Since transaction values are unavailable, customer segmentation was performed using **Recency** and **Frequency** rather than the traditional RFM framework.

---

##  Key Findings

For detailed report: [Executive Summary](executive-summary.pdf)

### Executive Dashboard

- 1.41M unique users generated 2.76M platform interactions.
- Product views represented 96.68% of all events.
- Overall purchase conversion rate was only **0.83%**.
- Average engagement was **1.96 events per user**.

### Funnel Analysis

| Stage | Users |
|--------|-------:|
| Viewed Products | 1,404,179 |
| Added to Cart | 37,722 |
| Purchased | 11,719 |

Conversion Rates:

- View → Cart: **2.69%**
- Cart → Purchase: **31.07%**
- Overall: **0.83%**

The largest drop-off occurs before users add products to their cart.

### RF User Segmentation

Customers were segmented into:

- Champions
- High-Value Users
- Emerging Users
- Casual Users
- Declining Users
- Inactive Users

The analysis revealed that repeat purchasing is relatively uncommon, with an average purchase frequency of **1.92** purchases per buyer.

---

## Business Recommendations

- Improve product discovery through personalized recommendations and enhanced search.
- Optimize product pages with richer descriptions, reviews, and stronger calls-to-action.
- Develop loyalty programs for Champions and High-Value Users.
- Launch targeted re-engagement campaigns for Declining and Inactive Users.
- Leverage RF segmentation to personalize CRM and lifecycle marketing initiatives.

---


## Expected Business Impact

This analysis identifies key opportunities to improve user conversion and long-term retention.

By addressing the View-to-Cart bottleneck and implementing targeted retention strategies, the business can strengthen customer engagement, improve purchase conversion, and support sustainable product growth.

---

*Pavni Rastogi*
