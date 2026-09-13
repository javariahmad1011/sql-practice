-- BETWEEN - Boundary Value Validation
-- Purpose: Validate orders whose totals fall inside a configured approval range, including both minimum and maximum boundaries.
-- -----------------------------------------------------------------------------

SELECT order_id,
       customer_id,
       total_amount,
       status
FROM orders
WHERE total_amount BETWEEN 100.00 AND 500.00
ORDER BY total_amount;

-- Expected Output / Validation Evidence
-- order_id | customer_id | total_amount | status
-- 9002     | 2002        | 100.00       | Completed
-- 9006     | 2001        | 500.00       | Pending
-- BETWEEN is inclusive of 100.00 and 500.00.

-- Best Practices
-- 1. Confirm whether business boundaries are inclusive before using BETWEEN.
-- 2. For timestamps, prefer >= start AND < next_boundary to avoid end-of-day precision issues.
-- 3. Validate values just below, exactly at, and just above each boundary.
