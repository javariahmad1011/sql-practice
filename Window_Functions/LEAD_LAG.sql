-- LEAD / LAG - Salary Change Validation
-- Purpose: Compare each salary history row with the previous amount to validate increments and detect unexpected decreases.
-- -----------------------------------------------------------------------------

WITH salary_changes AS (
    SELECT employee_id,
           salary_id,
           effective_from,
           amount,
           LAG(amount) OVER (
               PARTITION BY employee_id
               ORDER BY effective_from,
                        salary_id
           ) AS previous_amount
    FROM salaries
)
SELECT employee_id,
       salary_id,
       effective_from,
       previous_amount,
       amount AS current_amount,
       amount - previous_amount AS amount_change
FROM salary_changes
WHERE previous_amount IS NOT NULL
ORDER BY employee_id,
         effective_from;

-- Expected Output / Validation Evidence
-- employee_id | salary_id | effective_from | previous_amount | current_amount | amount_change
-- 1001        | 5012      | 2026-04-01     | 59000.00        | 62000.00       | 3000.00

-- Best Practices
-- 1. Include a deterministic tie-breaker in the window ORDER BY.
-- 2. Treat the first row per employee separately because LAG returns NULL.
-- 3. Add business-rule filters such as amount < previous_amount only when decreases are forbidden.
