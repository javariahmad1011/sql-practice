-- HAVING - Detect Duplicate Business Keys
-- Purpose: Identify normalized customer emails appearing more than once, a common account integrity issue.
-- -----------------------------------------------------------------------------

SELECT LOWER(email) AS normalized_email,
       COUNT(*) AS duplicate_count
FROM customers
WHERE email IS NOT NULL
GROUP BY LOWER(email)
HAVING COUNT(*) > 1
ORDER BY duplicate_count DESC,
         normalized_email;

-- Expected Output / Validation Evidence
-- QA PASS expectation: zero rows when email must be unique.
-- normalized_email       | duplicate_count
-- shared@example.com     | 2

-- Best Practices
-- 1. Use WHERE to filter source rows and HAVING to filter aggregate groups.
-- 2. Normalize case only if the business rule treats email case-insensitively.
-- 3. Confirm uniqueness at both application and database-constraint levels where appropriate.
