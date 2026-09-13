-- DENSE_RANK - Distinct Salary Bands
-- Purpose: Assign consecutive ranking numbers to distinct current salary values per department.
-- -----------------------------------------------------------------------------

SELECT e.department_id,
       e.employee_id,
       s.amount,
       DENSE_RANK() OVER (
           PARTITION BY e.department_id
           ORDER BY s.amount DESC
       ) AS salary_band_rank
FROM employees e
JOIN salaries s
  ON s.employee_id = e.employee_id
 AND s.is_current = 1
ORDER BY e.department_id,
         salary_band_rank,
         e.employee_id;

-- Expected Output / Validation Evidence
-- department_id | employee_id | amount   | salary_band_rank
-- 20            | 1004        | 78000.00 | 1
-- 20            | 1005        | 78000.00 | 1
-- 20            | 1006        | 70000.00 | 2

-- Best Practices
-- 1. DENSE_RANK does not leave gaps after ties.
-- 2. Choose RANK vs DENSE_RANK based on the reporting requirement, not preference.
-- 3. Keep ordering direction explicit because it changes the meaning of rank 1.
