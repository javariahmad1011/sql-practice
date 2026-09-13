-- NOT EXISTS - Find Missing Required Relationships
-- Purpose: Detect active employees with no current salary row.
-- -----------------------------------------------------------------------------

SELECT e.employee_id,
       e.first_name,
       e.last_name
FROM employees e
WHERE e.status = 'Active'
  AND NOT EXISTS (
      SELECT 1
      FROM salaries s
      WHERE s.employee_id = e.employee_id
        AND s.is_current = 1
  );

-- Expected Output / Validation Evidence
-- QA PASS expectation: zero rows.
-- Any returned employee is missing mandatory current salary data.

-- Best Practices
-- 1. NOT EXISTS expresses anti-join intent clearly.
-- 2. Prefer it over NOT IN when the subquery can contain NULL values.
-- 3. Use zero-row expectations for integrity checks in automated test suites.
