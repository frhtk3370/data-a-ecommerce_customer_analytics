-- =============================================================================
-- Module 1: Data Audit & Cleaning
-- Purpose : Identify raw data anomalies, compute total monetary amount, 
--           and create a persistent sanitized table (clean_retail).
-- Engine  : SQLite
-- =============================================================================

-- Step 1: Audit Data Quality & Missing Records
SELECT 
    COUNT(*) AS total_rows,
    COUNT(CASE WHEN CustomerID IS NULL THEN 1 END) AS missing_customer_id,
    COUNT(CASE WHEN Quantity <= 0 THEN 1 END) AS non_positive_quantity,
    COUNT(CASE WHEN UnitPrice <= 0 THEN 1 END) AS non_positive_price
FROM raw_retail;

-- Step 2: Create Clean Production Table with Feature Engineering
CREATE TABLE IF NOT EXISTS clean_retail AS
SELECT 
    InvoiceNo,
    StockCode,
    Description,
    Quantity,
    InvoiceDate,
    UnitPrice,
    CustomerID,
    Country,
    ROUND(Quantity * UnitPrice, 2) AS TotalAmount,
    CASE 
        WHEN InvoiceNo LIKE 'C%' OR Quantity < 0 THEN 1 
        ELSE 0 
    END AS IsCancelled
FROM raw_retail
WHERE UnitPrice > 0;

-- Step 3: High-Level Business KPIs (Valid Transactions)
SELECT 
    ROUND(SUM(TotalAmount), 2) AS total_revenue,
    COUNT(DISTINCT CustomerID) AS unique_customers,
    COUNT(DISTINCT InvoiceNo) AS total_orders
FROM clean_retail
WHERE IsCancelled = 0;

-- Step 4: Geographic Revenue Distribution (Top 5 Markets)
SELECT 
    Country,
    ROUND(SUM(TotalAmount), 2) AS total_revenue
FROM clean_retail
WHERE IsCancelled = 0
GROUP BY Country
ORDER BY total_revenue DESC
LIMIT 5;