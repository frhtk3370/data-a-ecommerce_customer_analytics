-- =============================================================================
-- Module 4: Monthly Cohort Retention Matrix
-- Purpose : Segment users into cohorts by their first transaction month
--           and track monthly retention rates over time.
-- Engine  : SQLite
-- =============================================================================

WITH customer_cohort AS (
    -- Step 1: Assign first purchase month as cohort identifier
    SELECT 
        CustomerID,
        STRFTIME('%Y-%m', MIN(InvoiceDate)) AS cohort_month
    FROM clean_retail
    WHERE IsCancelled = 0 
      AND CustomerID IS NOT NULL
    GROUP BY CustomerID
),
customer_activities AS (
    -- Step 2: Calculate month index (elapsed months since acquisition)
    SELECT 
        r.CustomerID,
        c.cohort_month,
        STRFTIME('%Y-%m', r.InvoiceDate) AS activity_month,
        (CAST(STRFTIME('%Y', r.InvoiceDate) AS INT) - CAST(SUBSTR(c.cohort_month, 1, 4) AS INT)) * 12 + 
        (CAST(STRFTIME('%m', r.InvoiceDate) AS INT) - CAST(SUBSTR(c.cohort_month, 6, 2) AS INT)) AS cohort_index
    FROM clean_retail r
    JOIN customer_cohort c 
      ON r.CustomerID = c.CustomerID
    WHERE r.IsCancelled = 0
    GROUP BY r.CustomerID, c.cohort_month, activity_month, cohort_index
)
-- Step 3: Count active customer volume per cohort and cohort index
SELECT 
    cohort_month,
    cohort_index,
    COUNT(DISTINCT CustomerID) AS active_customers
FROM customer_activities
GROUP BY cohort_month, cohort_index
ORDER BY cohort_month, cohort_index;