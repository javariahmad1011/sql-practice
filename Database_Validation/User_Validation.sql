-- User Validation - Customer Account Integrity
-- Purpose: Validate common account rules: mandatory email, valid account status, and duplicate normalized emails.
-- -----------------------------------------------------------------------------

-- Check 1: mandatory email on active customer records.
SELECT customer_id,
       customer_name,
       email,
       account_status
FROM customers
WHERE account_status = 'Active'
  AND (email IS NULL OR TRIM(email) = '');

-- Check 2: only approved status values should exist.
SELECT customer_id,
       account_status
FROM customers
WHERE account_status NOT IN ('Active', 'Inactive', 'Suspended');

-- Check 3: normalized email should be unique.
SELECT LOWER(email) AS normalized_email,
       COUNT(*) AS duplicate_count
FROM customers
WHERE email IS NOT NULL
GROUP BY LOWER(email)
HAVING COUNT(*) > 1;

-- Expected Output / Validation Evidence
-- QA PASS expectation for all three checks: zero rows.
-- Any row returned should be attached to the related account/data-integrity defect.

-- Best Practices
-- 1. Validate database constraints and application rules independently.
-- 2. Normalize according to the real identity rule used by the system.
-- 3. Never query password hashes, reset tokens, or secrets unless explicitly required and authorized.
