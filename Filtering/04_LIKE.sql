-- LIKE - Pattern-Oriented Data Checks
-- Purpose: Find test customer accounts using a controlled QA email suffix and verify they can be cleaned up after execution.
-- -----------------------------------------------------------------------------

SELECT customer_id,
       customer_name,
       email
FROM customers
WHERE LOWER(email) LIKE '%+qa@example.com'
ORDER BY customer_id;

-- Expected Output / Validation Evidence
-- customer_id | customer_name   | email
-- 2010        | Regression User | regression+qa@example.com
-- Returned rows represent QA-owned test data.

-- Best Practices
-- 1. Normalize case when the target database collation may be case-sensitive.
-- 2. Avoid leading wildcards on high-volume indexed columns when performance matters.
-- 3. Do not use LIKE as a substitute for proper validation of complex formats such as email addresses.
