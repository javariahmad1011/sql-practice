-- MIN / MAX - Range Validation
-- Purpose: Verify observed order values stay within expected business limits and support boundary testing.
-- -----------------------------------------------------------------------------

SELECT MIN(total_amount) AS minimum_order_value,
       MAX(total_amount) AS maximum_order_value
FROM orders
WHERE status <> 'Cancelled';

-- Expected Output / Validation Evidence
-- minimum_order_value | maximum_order_value
-- 25.00               | 950.00

-- Best Practices
-- 1. Use MIN/MAX to investigate data ranges before selecting boundary test cases.
-- 2. Exclude statuses only when the same exclusion exists in the requirement.
-- 3. A valid min/max does not prove all intermediate records are valid; pair with negative-range checks.
