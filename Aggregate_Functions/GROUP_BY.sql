-- GROUP BY - Status Distribution Validation
-- Purpose: Summarize orders by status to compare backend workflow distribution with reporting output.
-- -----------------------------------------------------------------------------

SELECT status,
       COUNT(*) AS order_count,
       SUM(total_amount) AS total_value
FROM orders
GROUP BY status
ORDER BY status;

-- Expected Output / Validation Evidence
-- status     | order_count | total_value
-- Cancelled  | 1           | 89.00
-- Completed  | 4           | 1249.49
-- Pending    | 2           | 710.00

-- Best Practices
-- 1. Include every non-aggregated selected column in GROUP BY.
-- 2. Validate status domain values separately so typos do not become hidden extra groups.
-- 3. Compare grouped results using the same data snapshot when checking a dashboard.
