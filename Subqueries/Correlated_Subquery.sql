-- Correlated Subquery - Latest Salary Row per Employee
-- Purpose: Return each employee salary row only when its effective date is the latest for that employee.
-- -----------------------------------------------------------------------------

SELECT s.salary_id,
       s.employee_id,
       s.amount,
       s.effective_from
FROM salaries s
WHERE s.effective_from = (
    SELECT MAX(s2.effective_from)
    FROM salaries s2
    WHERE s2.employee_id = s.employee_id
)
ORDER BY s.employee_id;

-- Expected Output / Validation Evidence
-- salary_id | employee_id | amount   | effective_from
-- 5012      | 1001        | 62000.00 | 2026-04-01
-- 5013      | 1002        | 68000.00 | 2026-04-01

-- Best Practices
-- 1. Correlate using the true business relationship key.
-- 2. If two rows can share the same latest date, add a tie-break rule such as salary_id.
-- 3. For large history tables, compare performance with ROW_NUMBER() over a partition.
