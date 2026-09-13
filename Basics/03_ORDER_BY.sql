-- ORDER BY - Deterministic Evidence
-- Purpose: Review salary history in a predictable sequence so the most recent record can be validated first.
-- -----------------------------------------------------------------------------

SELECT salary_id,
       employee_id,
       amount,
       effective_from,
       is_current
FROM salaries
WHERE employee_id = 1001
ORDER BY effective_from DESC,
         salary_id DESC;

-- Expected Output / Validation Evidence
-- salary_id | employee_id | amount   | effective_from | is_current
-- 5012      | 1001        | 62000.00 | 2026-04-01     | 1
-- 4881      | 1001        | 59000.00 | 2025-04-01     | 0

-- Best Practices
-- 1. Add a secondary sort key to make ordering deterministic when dates can tie.
-- 2. Do not assume physical database row order.
-- 3. Use descending dates for history validation when the latest state matters most.
