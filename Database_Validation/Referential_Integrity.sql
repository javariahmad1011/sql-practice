-- Referential Integrity - Orphan Detection
-- Purpose: Find child rows that reference missing parent records even when foreign-key constraints are absent or disabled in a test environment.
-- -----------------------------------------------------------------------------

-- Employees referencing a missing department.
SELECT e.employee_id,
       e.department_id
FROM employees e
LEFT JOIN departments d
       ON d.department_id = e.department_id
WHERE e.department_id IS NOT NULL
  AND d.department_id IS NULL;

-- Orders referencing a missing customer.
SELECT o.order_id,
       o.customer_id
FROM orders o
LEFT JOIN customers c
       ON c.customer_id = o.customer_id
WHERE o.customer_id IS NOT NULL
  AND c.customer_id IS NULL;

-- Salaries referencing a missing employee.
SELECT s.salary_id,
       s.employee_id
FROM salaries s
LEFT JOIN employees e
       ON e.employee_id = s.employee_id
WHERE e.employee_id IS NULL;

-- Expected Output / Validation Evidence
-- QA PASS expectation: zero rows from all checks.
-- Any result is an orphaned record and should be investigated immediately.

-- Best Practices
-- 1. Keep foreign keys enabled in production-like environments whenever possible.
-- 2. Orphan checks remain valuable after migrations/imports even when constraints exist.
-- 3. Validate deletion behavior (RESTRICT/CASCADE/soft delete) against requirements.
