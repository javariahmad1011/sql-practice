-- SELF JOIN - Validate Manager Relationships
-- Purpose: Resolve each employee to their manager record and identify invalid manager references.
-- -----------------------------------------------------------------------------

SELECT e.employee_id,
       e.first_name AS employee_first_name,
       e.last_name  AS employee_last_name,
       m.employee_id AS manager_id,
       m.first_name AS manager_first_name,
       m.last_name  AS manager_last_name
FROM employees e
LEFT JOIN employees m
       ON m.employee_id = e.manager_id
WHERE e.manager_id IS NOT NULL
ORDER BY e.employee_id;

-- Expected Output / Validation Evidence
-- employee_id | employee_first_name | employee_last_name | manager_id | manager_first_name | manager_last_name
-- 1002        | Daniel              | Reed               | 1001       | Aisha              | Khan

-- Best Practices
-- 1. Use clear aliases for each logical role when joining a table to itself.
-- 2. Use LEFT JOIN when invalid/missing manager references must remain visible.
-- 3. Add a separate zero-row assertion for manager_id values that do not resolve.
