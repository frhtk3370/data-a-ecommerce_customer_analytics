-- =============================================================================
-- Module 2: RFM Metric Extraction
-- Purpose : Compute Recency, Frequency, and Monetary metrics per customer.
-- Metric Definitions:
--   - Recency  : Days elapsed from customer's latest purchase to analysis reference date.
--   - Frequency: Total distinct successful orders.
--   - Monetary : Total net monetary revenue generated.
-- Engine  : SQLite
-- =============================================================================

SELECT
    CustomerID,
    ROUND(
        JULIANDAY((
            SELECT DATE(MAX(InvoiceDate), '+1 day') 
            FROM clean_retail 
            WHERE IsCancelled = 0
        )) - JULIANDAY(MAX(InvoiceDate)), 0
    ) AS recency,
    COUNT(DISTINCT InvoiceNo) AS frequency,
    ROUND(SUM(TotalAmount), 2) AS monetary
FROM clean_retail
WHERE IsCancelled = 0 
  AND CustomerID IS NOT NULL
GROUP BY CustomerID;