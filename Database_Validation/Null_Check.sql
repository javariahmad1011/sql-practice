-- NULL Check - Mandatory Fields
-- Purpose: Find missing mandatory values across employee and order records.
-- -----------------------------------------------------------------------------

SELECT 'employees' AS source_table,
       CAST(employee_id AS VARCHAR(50)) AS record_id,
       'email/department_id' AS invalid_fields
FROM employees
WHERE status = 'Active'
  AND (email IS NULL OR department_id IS NULL)

UNION ALL

SELECT 'orders' AS source_table,
       CAST(order_id AS VARCHAR(50)) AS record_id,
       'customer_id/order_date/total_amount' AS invalid_fields
FROM orders
WHERE customer_id IS NULL
   OR order_date IS NULL
   OR total_amount IS NULL;

-- Expected Output / Validation Evidence
-- QA PASS expectation: zero rows.
-- source_table | record_id | invalid_fields
-- orders       | 9016      | customer_id/order_date/total_amount

-- Best Practices
-- 1. NULL checks should reflect conditional mandatory rules, not only schema NOT NULL constraints.
-- 2. Consider empty strings and whitespace for text fields separately.
-- 3. Return record identifiers so failures are directly traceable.
