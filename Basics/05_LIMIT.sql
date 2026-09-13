-- LIMIT / TOP - Safe Sampling
-- Purpose: Sample recent orders during exploratory validation without returning the full table.
-- Dialect note: PostgreSQL/MySQL use LIMIT; SQL Server commonly uses TOP or OFFSET/FETCH.
-- -----------------------------------------------------------------------------

-- PostgreSQL / MySQL
SELECT order_id,
       customer_id,
       order_date,
       status,
       total_amount
FROM orders
ORDER BY order_date DESC,
         order_id DESC
LIMIT 10;

-- SQL Server equivalent:
-- SELECT TOP (10) order_id, customer_id, order_date, status, total_amount
-- FROM orders
-- ORDER BY order_date DESC, order_id DESC;

-- Expected Output / Validation Evidence
-- Up to 10 most recent orders are returned.
-- order_id | customer_id | order_date | status     | total_amount
-- 9008     | 2004        | 2026-08-15 | Completed  | 249.99

-- Best Practices
-- 1. Always combine sampling with ORDER BY; otherwise the sample is nondeterministic.
-- 2. Keep dialect differences documented in shared QA repositories.
-- 3. Sampling is for investigation, not for proving whole-table correctness.
