-- WHERE - Isolate a Test Record
-- Purpose: Validate the persisted database state for a specific active employee created during a test run.
-- -----------------------------------------------------------------------------

SELECT employee_id,
       first_name,
       last_name,
       email,
       status
FROM employees
WHERE employee_id = 1001
  AND status = 'Active';

-- Expected Output / Validation Evidence
-- employee_id | first_name | last_name | email                  | status
-- 1001        | Aisha      | Khan      | aisha.khan@example.com | Active
-- QA expectation: exactly one row.

-- Best Practices
-- 1. Combine a unique identifier with the expected business state when validating persistence.
-- 2. Prefer exact comparisons for IDs and controlled status values.
-- 3. If multiple rows are returned for a unique ID, raise a data-integrity defect.
