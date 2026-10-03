  Executive Summary
In direct-to-consumer (D2C) and modern e-commerce ecosystems, treating all customers uniformly leads to inefficient marketing spend, higher churn rates, and lost lifetime revenue.

This project delivers an end-to-end customer intelligence framework built on 541,909 raw transactional records from a UK-based online retail business. Using SQLite as the high-performance transformation engine and Python for advanced analytics and visualization, the pipeline ingests, sanitizes, segments, and analyzes customer behaviors to extract high-impact commercial insights.

  Key Business Highlights
Gross Revenue Analyzed: £10,666,684 across 4,338 unique customers and 19,960 completed transactions.

Revenue Concentration: The Champions (VIP) segment comprises only 21.8% of the customer base but drives 54% (£5.75M) of total revenue.

Revenue at Risk: A 33.3% churn rate (90-day inactivity threshold) jeopardizes £1,033,364 in commercial revenue.

Retention Drop-off: Month 1 customer retention drops to 15–20%, indicating acquisition churn that requires immediate onboarding intervention.

Cross-Selling Opportunities: Market basket affinity analysis identified high-frequency co-purchased bundles, creating immediate cross-sell bundling potential.

  Project Architecture & Repository Structure
ecommerce-analytics-sql-python/
│
├── README.md                          # Executive summary, findings & recommendations
├── requirements.txt                   # Environment dependencies
├── data/
│   ├── raw/                           # Raw transaction records (.gitkeep / source data)
│   └── retail.db                      # Local SQLite database instance
│
├── notebooks/
│   └── retail_customer_analytics.ipynb # End-to-end runnable Jupyter Notebook
│
├── queries/                           # Modular production-ready SQL scripts
│   ├── 01_data_cleaning.sql           # Data audit, sanitation & base KPIs
│   ├── 02_rfm_segmentation.sql        # Recency, Frequency, Monetary calculations
│   ├── 03_churn_analysis.sql          # Churn detection & revenue at risk
│   ├── 04_cohort_retention.sql        # Monthly cohort index & retention matrix
│   ├── 05_customer_lifetime_value.sql # AOV, order frequency & lifespan metrics
│   └── 06_market_basket_analysis.sql  # Optimized self-join product affinity
│
└── assets/                            # Exported high-resolution analytical visual assets
    ├── 01_top_countries.png
    ├── 02_rfm_treemap.png
    ├── 03_segment_avg_monetary.png
    ├── 04_churn_donut_chart.png
    ├── 05_retention_heatmap.png
    ├── 06_clv_bubble_plot.png
    └── 07_market_basket_top10.png

	Tech Stack & Methodology
ComponentTool / LibraryBusiness ApplicationDatabase EngineSQLite3Persistent relational storage, window functions, and subqueriesData ProcessingPython, PandasETL, quantiles (pd.qcut), matrix pivoting, and aggregationVisual AnalyticsSeaborn, Matplotlib, SquarifyTreemap, Lollipop, Heatmaps, Donut, and Bubble chartsMethodologyRFM, Cohort Analysis, Market BasketCustomer segmentation, retention tracking, co-purchase mining

 Deep-Dive Analytical Modules & Business Insights1. Geographic Performance & Baseline MetricsTotal Revenue: £10,666,684.54Active Customers: 4,338Total Completed Orders: 19,960Market Dominance: The United Kingdom accounts for 84.6% (£9.02M) of gross revenue, followed by the Netherlands (£285K), EIRE (£283K), Germany (£228K), and France (£209K).2. RFM Segmentation & Customer Portfolio DistributionCustomers were segmented into 10 distinct profiles using quintile scoring on Recency, Frequency, and Monetary metrics:SegmentCustomer CountAvg Recency (Days)Avg FrequencyTotal Spend (£)Avg Spend (£)Strategy FocusChampions (VIP)94812.411.1£5,753,707£6,069Exclusive perks & early accessLoyal Customers51338.05.1£951,098£1,854Tiered loyalty & cross-sellingCant Lose Them409145.23.9£611,451£1,495Executive win-back campaignsBig Spenders7493.62.3£579,967£7,837Premium concierge serviceAt Risk740200.01.6£278,028£376Reactivation discount incentivesPotential Loyalists45916.52.0£272,972£595Gamified rewards for next orderHibernating / Lost692182.21.0£215,096£311Low-cost programmatic re-engagementNeed Attention36952.11.8£209,054£567Limited-time urgency promotionsNew Customers11617.81.0£27,208£235Welcome journeys & onboardingRecent High-Value1817.91.0£12,827£713Fast-track loyalty qualification3. Customer Churn & Revenue at Risk AnalysisApplying a strict 90-day inactivity threshold identifies commercial vulnerability:Active Customers: 2,893 (66.7%)Churned Customers: 1,445 (33.3%)Total Revenue at Risk: £1,033,364.08Key Takeaway: Losing high-tier customers accounts for over 60% of this revenue at risk. Win-back efforts must prioritize the Cant Lose Them (High Risk) and Big Spenders segments rather than spreading retention budgets evenly across all churned users.4. Cohort Retention HeatmapEvaluating cohort behavior reveals consistent post-acquisition retention decay across all customer acquisition groups:First-Month Drop-off: Retention drops from 100% to between 15% and 22% in month 1 across all cohorts.Stabilization: Surviving customers remain stable at a 20–25% repeat purchase rate through month 8, demonstrating strong core brand loyalty.5. Customer Lifetime Value (CLV) DynamicsPlotting customer segments along average order frequency and logarithmic monetary spend maps the migration path from entry-level buyers to key accounts:High-Velocity Drivers: Champions place orders roughly once a month (11.1 orders/year), establishing a strong correlation between purchase frequency and annualized enterprise value.Under-Leveraged Value: Big Spenders exhibit an average spend of £7,837 with only 2.3 orders. Converting them to 4+ orders per year would generate substantial net-new revenue.6. Market Basket Analysis & Cross-Selling OpportunitiesUsing SQL self-joins on InvoiceNo, co-purchased items were mapped to uncover natural bundling pairs:Key Product Pairs: Consistent co-purchases occur across home decor and lighting categories (e.g., matching tea-light holders and lantern variations).Cart Optimization: Triggering automated cross-sell prompts during checkout for these paired items can directly lift Average Order Value (AOV).🎯 Strategic Action Plan & Business RecommendationsVIP Retention & White-Glove Treatment:Establish dedicated account managers and exclusive early access promotions for Champions and Big Spenders to protect £6.3M in annual turnover.Targeted Win-Back Campaigns:Deploy dynamic remarketing tailored to the 409 Cant Lose Them accounts with personalized replenishment incentives before they exceed 180 days of inactivity.Onboarding Funnel Overhaul:Re-architect post-purchase communication sequences within the first 30 days of acquisition to address the 80% initial retention drop-off.Algorithmic Cross-Selling at Checkout:Integrate top co-purchased pairs into the e-commerce recommendation engine as "Frequently Bought Together" bundles with a modest incentive discount.