-- Salary Validation - Current Record and Amount Rules
-- Purpose: Detect invalid salary amounts and employees with multiple current salary rows.
-- -----------------------------------------------------------------------------

-- Check 1: salary amount must be positive.
SELECT salary_id,
       employee_id,
       amount,
       effective_from
FROM salaries
WHERE amount <= 0
   OR amount IS NULL;

-- Check 2: at most one current salary row per employee.
SELECT employee_id,
       COUNT(*) AS current_salary_rows
FROM salaries
WHERE is_current = 1
GROUP BY employee_id
HAVING COUNT(*) > 1;

-- Expected Output / Validation Evidence
-- QA PASS expectation: zero rows for both checks.
-- Example failure:
-- employee_id | current_salary_rows
-- 1001        | 2

-- Best Practices
-- 1. Currency fields should use DECIMAL/NUMERIC, not floating point.
-- 2. Add a database constraint/index for one-current-row rules when the platform supports it.
-- 3. Validate effective-date overlap separately if salary periods contain start/end dates.
