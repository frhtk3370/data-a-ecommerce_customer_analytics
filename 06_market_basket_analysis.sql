-- =============================================================================
-- Module 6: Market Basket Analysis (Cross-Selling Opportunities)
-- Purpose : Detect top product pairs frequently co-purchased in the same order
--           using self-join optimization, excluding operational items.
-- Engine  : SQLite
-- =============================================================================

WITH valid_items AS (
    -- Filter out shipping and manual line items
    SELECT DISTINCT 
        InvoiceNo, 
        Description
    FROM clean_retail
    WHERE IsCancelled = 0 
      AND Description IS NOT NULL 
      AND Description NOT IN ('POSTAGE', 'DOTCOM POSTAGE', 'MANUAL')
)
SELECT 
    t1.Description AS product_a,
    t2.Description AS product_b,
    COUNT(*) AS times_bought_together
FROM valid_items t1
JOIN valid_items t2 
  ON t1.InvoiceNo = t2.InvoiceNo 
 AND t1.Description < t2.Description -- Avoid symmetric duplicate pairs (A+B and B+A)
GROUP BY product_a, product_b
ORDER BY times_bought_together DESC
LIMIT 20;