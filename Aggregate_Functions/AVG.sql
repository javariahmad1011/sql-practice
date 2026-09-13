-- AVG - Compare Business Segments
-- Purpose: Calculate average current salary by department to validate analytics output.
-- -----------------------------------------------------------------------------

SELECT d.department_name,
       AVG(s.amount) AS average_salary
FROM departments d
JOIN employees e
  ON e.department_id = d.department_id
JOIN salaries s
  ON s.employee_id = e.employee_id
 AND s.is_current = 1
WHERE e.status = 'Active'
GROUP BY d.department_name
ORDER BY d.department_name;

-- Expected Output / Validation Evidence
-- department_name     | average_salary
-- Engineering         | 68500.00
-- Quality Engineering | 62000.00

-- Best Practices
-- 1. Confirm one current salary row per employee before averaging to avoid duplicated weight.
-- 2. Document rounding rules used by the consuming UI.
-- 3. AVG ignores NULL amounts; validate whether NULL salaries should exist first.
