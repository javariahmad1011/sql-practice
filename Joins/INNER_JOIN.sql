-- INNER JOIN - Validate Employee Department Mapping
-- Purpose: Confirm active employees reference valid departments and expose the department name displayed in the UI.
-- -----------------------------------------------------------------------------

SELECT e.employee_id,
       e.first_name,
       e.last_name,
       d.department_id,
       d.department_name
FROM employees e
INNER JOIN departments d
        ON d.department_id = e.department_id
WHERE e.status = 'Active'
ORDER BY e.employee_id;

-- Expected Output / Validation Evidence
-- employee_id | first_name | last_name | department_id | department_name
-- 1001        | Aisha      | Khan      | 10            | Quality Engineering

-- Best Practices
-- 1. Join using primary/foreign key columns.
-- 2. INNER JOIN hides orphaned employees; use a LEFT JOIN validation to detect missing parents.
-- 3. Compare row counts before and after the join when every employee is expected to have a department.
