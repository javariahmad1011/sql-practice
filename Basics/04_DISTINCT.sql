-- DISTINCT - Discover Stored Domain Values
-- Purpose: Identify the actual employee status values present in the database and detect unexpected domain values.
-- -----------------------------------------------------------------------------

SELECT DISTINCT status
FROM employees
ORDER BY status;

-- Expected Output / Validation Evidence
-- status
-- Active
-- Inactive
-- On Leave
-- QA expectation: values should match the approved status domain.

-- Best Practices
-- 1. Use DISTINCT to inspect controlled-value domains during exploratory testing.
-- 2. Compare discovered values with requirements or API contracts.
-- 3. Investigate spelling/case variants such as Active, ACTIVE, and active as potential data-quality issues.
