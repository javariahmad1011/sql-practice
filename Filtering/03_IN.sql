-- IN - Validate Approved Status Sets
-- Purpose: Retrieve orders in user-visible workflow states while excluding cancelled or archived records.
-- -----------------------------------------------------------------------------

SELECT order_id,
       customer_id,
       status,
       total_amount
FROM orders
WHERE status IN ('Pending', 'Processing', 'Completed')
ORDER BY order_id;

-- Expected Output / Validation Evidence
-- order_id | customer_id | status     | total_amount
-- 9001     | 2001        | Completed  | 149.50
-- 9005     | 2003        | Processing | 320.00

-- Best Practices
-- 1. Use IN when validating membership in a small, explicit set of allowed values.
-- 2. Keep the list aligned with the API/UI contract.
-- 3. For very large value sets, join to a reference table instead of hard-coding values.
