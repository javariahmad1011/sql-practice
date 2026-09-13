-- Duplicate Check - Business Key Duplicates
-- Purpose: Detect duplicate employees by normalized email and duplicate orders by a composite business signature.
-- -----------------------------------------------------------------------------

-- Duplicate employee email.
SELECT LOWER(email) AS normalized_email,
       COUNT(*) AS duplicate_count
FROM employees
WHERE email IS NOT NULL
GROUP BY LOWER(email)
HAVING COUNT(*) > 1;

-- Potential duplicate orders submitted for the same customer, date, and amount.
SELECT customer_id,
       order_date,
       total_amount,
       COUNT(*) AS duplicate_count
FROM orders
WHERE status <> 'Cancelled'
GROUP BY customer_id,
         order_date,
         total_amount
HAVING COUNT(*) > 1;

-- Expected Output / Validation Evidence
-- QA PASS expectation: zero rows unless duplicates are explicitly allowed.
-- Potential duplicates require business review before they are treated as defects.

-- Best Practices
-- 1. Define a business key before labeling rows duplicates.
-- 2. Normalization rules should match application behavior.
-- 3. Use duplicate checks to identify candidates; do not automatically delete records.
