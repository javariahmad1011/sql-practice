-- EXISTS - Validate Related Records
-- Purpose: List active employees that have at least one current salary record without multiplying employee rows.
-- -----------------------------------------------------------------------------

SELECT e.employee_id,
       e.first_name,
       e.last_name
FROM employees e
WHERE e.status = 'Active'
  AND EXISTS (
      SELECT 1
      FROM salaries s
      WHERE s.employee_id = e.employee_id
        AND s.is_current = 1
  )
ORDER BY e.employee_id;

-- Expected Output / Validation Evidence
-- employee_id | first_name | last_name
-- 1001        | Aisha      | Khan
-- 1002        | Daniel     | Reed

-- Best Practices
-- 1. SELECT 1 communicates that only existence matters.
-- 2. EXISTS is often preferable to JOIN when child columns are not needed.
-- 3. Index the correlated foreign key for scalable validation queries.
