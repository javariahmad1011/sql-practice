-- NULL - Missing Data Validation
-- Purpose: Detect active employees missing a mandatory department assignment or email address.
-- -----------------------------------------------------------------------------

SELECT employee_id,
       first_name,
       last_name,
       email,
       department_id
FROM employees
WHERE status = 'Active'
  AND (email IS NULL OR department_id IS NULL);

-- Expected Output / Validation Evidence
-- QA PASS expectation: zero rows.
-- Any returned row indicates an active employee is missing mandatory data.

-- Best Practices
-- 1. Use IS NULL / IS NOT NULL; comparisons such as = NULL are never correct.
-- 2. Check whether the application also stores empty strings; NULL and '' are different values.
-- 3. Write negative validation queries so zero rows has an explicit pass meaning.
