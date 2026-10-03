-- =============================================================================
-- Module 3: Customer Churn & Revenue at Risk Analysis
-- Purpose : Identify inactive customers based on a 90-day inactivity threshold
--           and quantify total financial exposure (Revenue at Risk).
-- Engine  : SQLite
-- =============================================================================

WITH customer_summary AS (
    SELECT
        CustomerID,
        CAST(
            (SELECT JULIANDAY(MAX(InvoiceDate)) FROM clean_retail WHERE IsCancelled = 0) 
            - JULIANDAY(MAX(InvoiceDate)) 
            AS INT
        ) AS recency_days,
        ROUND(SUM(Quantity * UnitPrice), 2) AS total_spend
    FROM clean_retail
    WHERE IsCancelled = 0 
      AND CustomerID IS NOT NULL
    GROUP BY CustomerID
),
churn_flagged AS (
    SELECT 
        CustomerID,
        total_spend,
        CASE WHEN recency_days > 90 THEN 1 ELSE 0 END AS is_churn
    FROM customer_summary
)
SELECT 
    COUNT(DISTINCT CustomerID) AS total_customers,
    SUM(is_churn) AS churned_customers,
    COUNT(DISTINCT CustomerID) - SUM(is_churn) AS active_customers,
    ROUND(100.0 * SUM(is_churn) / COUNT(DISTINCT CustomerID), 2) AS churn_rate_pct,
    ROUND(SUM(CASE WHEN is_churn = 1 THEN total_spend ELSE 0 END), 2) AS revenue_at_risk,
    ROUND(SUM(total_spend), 2) AS total_revenue
FROM churn_flagged;