-- AND / OR - Validate Combined Business Rules
-- Purpose: Find employees who are active/on leave and still belong to a department, matching a common access-control eligibility rule.
-- -----------------------------------------------------------------------------

SELECT employee_id,
       first_name,
       last_name,
       status,
       department_id
FROM employees
WHERE (status = 'Active' OR status = 'On Leave')
  AND department_id IS NOT NULL;

-- Expected Output / Validation Evidence
-- employee_id | first_name | last_name | status   | department_id
-- 1001        | Aisha      | Khan      | Active   | 10
-- 1003        | Sofia      | Martin    | On Leave | 20

-- Best Practices
-- 1. Parenthesize OR conditions before combining them with AND.
-- 2. Mirror acceptance-criteria grouping in the query to avoid false positives.
-- 3. For complex rules, build and verify each predicate independently before combining them.
