-- Scalar Subquery - Salary Above Company Average
-- Purpose: Find active employees whose current salary is above the current-company average for investigation or analytics validation.
-- -----------------------------------------------------------------------------

SELECT e.employee_id,
       e.first_name,
       e.last_name,
       s.amount
FROM employees e
JOIN salaries s
  ON s.employee_id = e.employee_id
 AND s.is_current = 1
WHERE e.status = 'Active'
  AND s.amount > (
      SELECT AVG(s2.amount)
      FROM salaries s2
      WHERE s2.is_current = 1
  )
ORDER BY s.amount DESC;

-- Expected Output / Validation Evidence
-- employee_id | first_name | last_name | amount
-- 1004        | Marcus     | Lee       | 78000.00

-- Best Practices
-- 1. Confirm the subquery returns one scalar value.
-- 2. Align populations: decide whether the average should include inactive employees.
-- 3. For reusable reporting, a CTE may be clearer when the derived metric is referenced multiple times.
