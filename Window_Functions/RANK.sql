-- RANK - Salary Ranking with Ties
-- Purpose: Rank current salaries within each department while preserving equal-salary ties and skipped rank numbers.
-- -----------------------------------------------------------------------------

SELECT e.department_id,
       e.employee_id,
       s.amount,
       RANK() OVER (
           PARTITION BY e.department_id
           ORDER BY s.amount DESC
       ) AS salary_rank
FROM employees e
JOIN salaries s
  ON s.employee_id = e.employee_id
 AND s.is_current = 1
WHERE e.status = 'Active'
ORDER BY e.department_id,
         salary_rank,
         e.employee_id;

-- Expected Output / Validation Evidence
-- department_id | employee_id | amount   | salary_rank
-- 20            | 1004        | 78000.00 | 1
-- 20            | 1005        | 78000.00 | 1
-- 20            | 1006        | 70000.00 | 3

-- Best Practices
-- 1. RANK leaves gaps after ties; this is expected behavior.
-- 2. Use business-relevant partitioning so ranks are comparable.
-- 3. Validate whether the consuming report expects competition ranking or dense ranking.
