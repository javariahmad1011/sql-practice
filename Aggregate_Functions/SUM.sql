-- SUM - Monetary Reconciliation
-- Purpose: Validate the total value of completed orders for a reconciliation period.
-- -----------------------------------------------------------------------------

SELECT SUM(total_amount) AS completed_order_total
FROM orders
WHERE status = 'Completed'
  AND order_date >= '2026-08-01'
  AND order_date <  '2026-09-01';

-- Expected Output / Validation Evidence
-- completed_order_total
-- 1249.49
-- This should match the reporting/dashboard total for August 2026.

-- Best Practices
-- 1. Use a half-open date range (>= start and < next period) for reliable period boundaries.
-- 2. Confirm cancelled/refunded orders are excluded according to business rules.
-- 3. Keep currency stored and aggregated in fixed-precision numeric types.
