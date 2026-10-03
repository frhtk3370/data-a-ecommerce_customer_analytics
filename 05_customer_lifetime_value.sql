-- =============================================================================
-- Module 5: Customer Lifetime Value (CLV) & Unit Economics
-- Purpose : Derive Average Order Value (AOV), Purchase Frequency, and Total Spend
--           at customer level for lifetime value and segmentation modeling.
-- Engine  : SQLite
-- =============================================================================

SELECT 
    CustomerID,
    COUNT(DISTINCT InvoiceNo) AS total_orders,
    ROUND(SUM(TotalAmount), 2) AS total_monetary,
    ROUND(SUM(TotalAmount) / COUNT(DISTINCT InvoiceNo), 2) AS average_order_value_aov,
    ROUND(
        JULIANDAY(MAX(InvoiceDate)) - JULIANDAY(MIN(InvoiceDate)), 0
    ) AS customer_lifespan_days
FROM clean_retail
WHERE IsCancelled = 0 
  AND CustomerID IS NOT NULL
GROUP BY CustomerID
ORDER BY total_monetary DESC;