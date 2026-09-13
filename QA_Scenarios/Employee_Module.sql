-- Employee Module - CRUD and Side-Effect Validation
-- Purpose: Validate create, update, deactivate, and relationship behavior for an employee management workflow.
-- -----------------------------------------------------------------------------

-- CREATE: record should be persisted exactly once.
SELECT employee_id,
       first_name,
       last_name,
       email,
       status,
       department_id
FROM employees
WHERE email = 'automation.employee@example.com';

-- UPDATE: verify the department/status values changed as expected.
SELECT employee_id,
       department_id,
       status
FROM employees
WHERE employee_id = 1010
  AND department_id = 20
  AND status = 'Active';

-- DEACTIVATE: employee should be inactive, not physically deleted if soft-delete is required.
SELECT employee_id,
       status
FROM employees
WHERE employee_id = 1010;

-- SIDE EFFECT: deactivation must not orphan salary history.
SELECT s.salary_id
FROM salaries s
LEFT JOIN employees e
       ON e.employee_id = s.employee_id
WHERE s.employee_id = 1010
  AND e.employee_id IS NULL;

-- Expected Output / Validation Evidence
-- CREATE expectation: exactly one row.
-- UPDATE expectation: exactly one row matching new values.
-- DEACTIVATE expectation: one row with status = Inactive.
-- SIDE EFFECT QA PASS expectation: zero rows.

-- Best Practices
-- 1. Validate both the changed fields and fields that must remain unchanged.
-- 2. Use unique QA-owned emails/IDs to isolate test data.
-- 3. Confirm deletion semantics (soft vs hard delete) before writing assertions.
-- 4. Keep history validation separate from current-state validation.
