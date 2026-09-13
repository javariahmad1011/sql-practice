-- Employee Validation - Master Data Rules
-- Purpose: Validate employee status, hire-date, department, and manager consistency.
-- -----------------------------------------------------------------------------

SELECT employee_id,
       first_name,
       last_name,
       status,
       hire_date,
       department_id,
       manager_id
FROM employees
WHERE status NOT IN ('Active', 'Inactive', 'On Leave')
   OR hire_date IS NULL
   OR (status = 'Active' AND department_id IS NULL)
   OR manager_id = employee_id;

-- Expected Output / Validation Evidence
-- QA PASS expectation: zero rows.
-- A returned row violates at least one employee master-data rule.

-- Best Practices
-- 1. Keep each rule traceable to an acceptance criterion or data contract.
-- 2. Split rules into separate queries when defect triage needs more specific evidence.
-- 3. Self-manager references should be prevented by validation or constraints where possible.
