-- SQL Query Challenges - QA / SDET Interview Set
-- Purpose: A compact set of interview-style problems with production-oriented validation intent.
-- -----------------------------------------------------------------------------

-- Challenge 1: Find the second-highest distinct current salary.
SELECT MAX(amount) AS second_highest_salary
FROM salaries
WHERE is_current = 1
  AND amount < (
      SELECT MAX(amount)
      FROM salaries
      WHERE is_current = 1
  );

-- Challenge 2: Find active employees without a current salary.
SELECT e.employee_id,
       e.email
FROM employees e
WHERE e.status = 'Active'
  AND NOT EXISTS (
      SELECT 1
      FROM salaries s
      WHERE s.employee_id = e.employee_id
        AND s.is_current = 1
  );

-- Challenge 3: Find duplicate customer emails (case-insensitive).
SELECT LOWER(email) AS normalized_email,
       COUNT(*) AS duplicate_count
FROM customers
WHERE email IS NOT NULL
GROUP BY LOWER(email)
HAVING COUNT(*) > 1;

-- Challenge 4: Find each customer's latest order.
WITH ranked_orders AS (
    SELECT order_id,
           customer_id,
           order_date,
           total_amount,
           ROW_NUMBER() OVER (
               PARTITION BY customer_id
               ORDER BY order_date DESC,
                        order_id DESC
           ) AS rn
    FROM orders
)
SELECT order_id,
       customer_id,
       order_date,
       total_amount
FROM ranked_orders
WHERE rn = 1;

-- Challenge 5: Find departments with no active employees.
SELECT d.department_id,
       d.department_name
FROM departments d
LEFT JOIN employees e
       ON e.department_id = d.department_id
      AND e.status = 'Active'
WHERE e.employee_id IS NULL;

-- Expected Output / Validation Evidence
-- Challenge outputs depend on seeded data.
-- Key interview expectations:
-- 1. Second-highest query returns one scalar value or NULL if fewer than two distinct salaries exist.
-- 2. Missing-current-salary query should return zero rows in valid data.
-- 3. Duplicate-email query should return zero rows when uniqueness is enforced.
-- 4. Latest-order query returns one deterministic row per customer with an order.
-- 5. Department query returns configured departments without active staff.

-- Best Practices
-- 1. State assumptions before coding (e.g., distinct vs non-distinct second-highest salary).
-- 2. Prefer deterministic window ordering for latest-row problems.
-- 3. Explain why NOT EXISTS avoids NULL issues associated with NOT IN.
-- 4. Treat interview queries as validation logic: describe expected cardinality and failure meaning.
