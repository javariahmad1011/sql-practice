-- ROW_NUMBER - Identify Duplicate Customer Records
-- Purpose: Assign a deterministic sequence to duplicate normalized emails so rows after the first can be investigated.
-- -----------------------------------------------------------------------------

WITH ranked_customers AS (
    SELECT customer_id,
           customer_name,
           email,
           ROW_NUMBER() OVER (
               PARTITION BY LOWER(email)
               ORDER BY created_date,
                        customer_id
           ) AS duplicate_sequence
    FROM customers
    WHERE email IS NOT NULL
)
SELECT customer_id,
       customer_name,
       email,
       duplicate_sequence
FROM ranked_customers
WHERE duplicate_sequence > 1
ORDER BY email,
         duplicate_sequence;

-- Expected Output / Validation Evidence
-- QA PASS expectation: zero rows when normalized email is unique.
-- customer_id | customer_name | email              | duplicate_sequence
-- 2012        | Duplicate QA  | qa@example.com     | 2

-- Best Practices
-- 1. Use a deterministic tie-breaker such as customer_id.
-- 2. Never delete duplicates automatically based only on ROW_NUMBER results; investigate business context first.
-- 3. Normalize only according to the real uniqueness rule.
