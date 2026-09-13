-- RIGHT JOIN - Validate Department Coverage
-- Purpose: List all departments, including departments that currently have no employees, to validate configuration coverage.
-- -----------------------------------------------------------------------------

SELECT d.department_id,
       d.department_name,
       e.employee_id,
       e.status
FROM employees e
RIGHT JOIN departments d
        ON d.department_id = e.department_id
ORDER BY d.department_id,
         e.employee_id;

-- Expected Output / Validation Evidence
-- department_id | department_name       | employee_id | status
-- 10            | Quality Engineering    | 1001        | Active
-- 40            | Security               | NULL        | NULL
-- Department 40 is configured but has no employees.

-- Best Practices
-- 1. RIGHT JOIN is valid but LEFT JOIN is often easier to read; choose a team convention.
-- 2. Preserve the table whose completeness you are validating.
-- 3. Do not interpret NULL employee columns as a database error unless the business rule requires staffing.
