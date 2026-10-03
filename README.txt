# E-Commerce Customer Analytics (SQL + Python)

An end-to-end customer intelligence pipeline built on **541,909 raw transactions** from a UK-based online retailer. SQLite handles the data transformation; Python handles analysis and visualization.

## Key Findings

| Metric | Result |
|---|---|
| Gross revenue analyzed | £10,666,684 |
| Unique customers | 4,338 |
| Completed orders | 19,960 |
| Revenue concentration | Champions are 21.8% of customers but drive 54% (£5.75M) of revenue |
| Churn rate (90-day inactivity) | 33.3% of customers, putting £1,033,364 at risk |
| Month-1 retention | Drops to 15–22% across cohorts |
| Cross-selling | Frequently co-purchased product pairs identified for bundling |

## Project Structure

```text
ecommerce-analytics-sql-python/
├── README.md
├── requirements.txt
├── data/
│   ├── raw/                            # Source transaction data
│   └── retail.db                       # Local SQLite database
├── notebooks/
│   └── retail_customer_analytics.ipynb # End-to-end notebook
├── queries/
│   ├── 01_data_cleaning.sql            # Data audit, cleaning, base KPIs
│   ├── 02_rfm_segmentation.sql         # Recency, Frequency, Monetary
│   ├── 03_churn_analysis.sql           # Churn detection, revenue at risk
│   ├── 04_cohort_retention.sql         # Cohort index, retention matrix
│   ├── 05_customer_lifetime_value.sql  # AOV, order frequency, lifespan
│   └── 06_market_basket_analysis.sql   # Self-join product affinity
└── assets/
    ├── 01_top_countries.png
    ├── 02_rfm_treemap.png
    ├── 03_segment_avg_monetary.png
    ├── 04_churn_donut_chart.png
    ├── 05_retention_heatmap.png
    ├── 06_clv_bubble_plot.png
    └── 07_market_basket_top10.png
```

## Tech Stack

| Component | Tools | Use |
|---|---|---|
| Database | SQLite3 | Storage, window functions, subqueries |
| Processing | Python, Pandas | ETL, quantiles (`pd.qcut`), pivoting, aggregation |
| Visualization | Seaborn, Matplotlib, Squarify | Treemap, lollipop, heatmap, donut, bubble charts |
| Methods | RFM, cohort analysis, market basket | Segmentation, retention, co-purchase mining |

## Analysis & Insights

### 1. Geographic Performance

- Total revenue: **£10,666,684.54**
- Active customers: **4,338**
- Completed orders: **19,960**
- The **United Kingdom** generates 84.6% (£9.02M) of revenue, followed by the Netherlands (£285K), EIRE (£283K), Germany (£228K) and France (£209K).

### 2. RFM Segmentation

Customers were scored on Recency, Frequency and Monetary value using quintiles, then grouped into 10 segments.

| Segment | Customers | Avg Recency (days) | Avg Frequency | Total Spend | Avg Spend | Strategy |
|---|---:|---:|---:|---:|---:|---|
| Champions | 948 | 12.4 | 11.1 | £5,753,707 | £6,069 | Exclusive perks, early access |
| Loyal Customers | 513 | 38.0 | 5.1 | £951,098 | £1,854 | Tiered loyalty, cross-selling |
| Can't Lose Them | 409 | 145.2 | 3.9 | £611,451 | £1,495 | Executive win-back campaigns |
| Big Spenders | 74 | 93.6 | 2.3 | £579,967 | £7,837 | Premium concierge service |
| At Risk | 740 | 200.0 | 1.6 | £278,028 | £376 | Reactivation discounts |
| Potential Loyalists | 459 | 16.5 | 2.0 | £272,972 | £595 | Gamified rewards |
| Hibernating / Lost | 692 | 182.2 | 1.0 | £215,096 | £311 | Low-cost re-engagement |
| Need Attention | 369 | 52.1 | 1.8 | £209,054 | £567 | Limited-time promotions |
| New Customers | 116 | 17.8 | 1.0 | £27,208 | £235 | Welcome and onboarding journey |
| Recent High-Value | 18 | 17.9 | 1.0 | £12,827 | £713 | Fast-track loyalty qualification |

### 3. Churn & Revenue at Risk

Using a 90-day inactivity threshold:

- Active customers: **2,893 (66.7%)**
- Churned customers: **1,445 (33.3%)**
- Revenue at risk: **£1,033,364.08**

**Takeaway:** High-tier customers make up over 60% of the revenue at risk. Win-back budgets should focus on *Can't Lose Them* and *Big Spenders* rather than being spread evenly across all churned users.

### 4. Cohort Retention

- Retention falls from 100% to **15–22% in month 1** across all cohorts.
- Surviving customers stay stable at a **20–25%** repeat-purchase rate through month 8, showing a loyal core.

### 5. Customer Lifetime Value

- **Champions** order about once a month (11.1 orders), so purchase frequency is closely tied to customer value.
- **Big Spenders** average £7,837 but only 2.3 orders. Moving them to 4+ orders per year would add significant revenue.

### 6. Market Basket Analysis

Self-joins on `InvoiceNo` surfaced products that are frequently bought together, mostly in home decor and lighting (e.g. matching tea-light holders and lanterns). Checkout cross-sell prompts for these pairs can lift average order value.

## Recommendations

1. **VIP retention:** Assign account managers and offer early access to Champions and Big Spenders to protect ~£6.3M in revenue.
2. **Targeted win-back:** Send personalized replenishment offers to the 409 *Can't Lose Them* customers before they pass 180 days of inactivity.
3. **Onboarding overhaul:** Redesign the first 30 days of post-purchase communication to address the month-1 retention drop.
4. **Checkout cross-selling:** Add top co-purchased pairs as "Frequently Bought Together" bundles with a small discount.

## Run Locally

```bash
# 1. Clone the repository
git clone https://github.com/frhtk3370/ecommerce-analytics-sql-python.git
cd ecommerce-analytics-sql-python

# 2. Create a virtual environment and install dependencies
python -m venv venv
source venv/bin/activate  # Windows: venv\Scripts\activate
pip install -r requirements.txt

# 3. Launch the notebook
jupyter notebook notebooks/retail_customer_analytics.ipynb
```
