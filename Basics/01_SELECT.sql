-- SELECT - Targeted Data Inspection
-- Purpose: Retrieve only the columns required to validate employee records created or updated by the application.
-- -----------------------------------------------------------------------------

SELECT employee_id,
       first_name,
       last_name,
       email,
       status
FROM employees;

-- Expected Output / Validation Evidence
-- employee_id | first_name | last_name | email                  | status
-- 1001        | Aisha      | Khan      | aisha.khan@example.com | Active
-- 1002        | Daniel     | Reed      | daniel.reed@example.com| Active

-- Best Practices
-- 1. Select explicit columns to reduce noise and make test evidence easier to review.
-- 2. Avoid exposing sensitive columns such as password hashes or tokens unless the test requires them.
-- 3. Use stable business/test identifiers in later predicates rather than relying on row position.
