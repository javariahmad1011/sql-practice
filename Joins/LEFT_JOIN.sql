-- LEFT JOIN - Detect Missing Salary Records
-- Purpose: Identify active employees who do not have a current salary row.
-- -----------------------------------------------------------------------------

SELECT e.employee_id,
       e.first_name,
       e.last_name,
       s.salary_id
FROM employees e
LEFT JOIN salaries s
       ON s.employee_id = e.employee_id
      AND s.is_current = 1
WHERE e.status = 'Active'
  AND s.salary_id IS NULL;

-- Expected Output / Validation Evidence
-- QA PASS expectation: zero rows.
-- Returned employee IDs are missing a current salary record.

-- Best Practices
-- 1. Put child-table conditions such as s.is_current = 1 inside the JOIN when preserving unmatched parents.
-- 2. A WHERE predicate on the right table can accidentally convert a LEFT JOIN into an INNER JOIN.
-- 3. Zero-result orphan checks make strong automated database assertions.
