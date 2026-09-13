-- Payroll Module - Batch Reconciliation
-- Purpose: Validate payroll line counts and gross pay against active employees and current salary data.
-- -----------------------------------------------------------------------------

-- Source population expected for a monthly payroll run.
SELECT COUNT(*) AS expected_employee_count,
       SUM(s.amount / 12.0) AS expected_monthly_gross
FROM employees e
JOIN salaries s
  ON s.employee_id = e.employee_id
 AND s.is_current = 1
WHERE e.status = 'Active';

-- Actual generated payroll batch.
SELECT pr.payroll_run_id,
       COUNT(pi.payroll_item_id) AS actual_employee_count,
       SUM(pi.gross_amount) AS actual_monthly_gross
FROM payroll_runs pr
JOIN payroll_items pi
  ON pi.payroll_run_id = pr.payroll_run_id
WHERE pr.payroll_run_id = 30001
GROUP BY pr.payroll_run_id;

-- Negative check: duplicate employee within the same payroll run.
SELECT payroll_run_id,
       employee_id,
       COUNT(*) AS item_count
FROM payroll_items
WHERE payroll_run_id = 30001
GROUP BY payroll_run_id,
         employee_id
HAVING COUNT(*) > 1;

-- Expected Output / Validation Evidence
-- Expected and actual employee counts/gross values should reconcile after applying the same payroll rules.
-- Duplicate-item query QA PASS expectation: zero rows.

-- Best Practices
-- 1. Document proration, unpaid leave, bonuses, tax, and rounding rules before comparing totals.
-- 2. Reconcile both count and amount; one matching metric is insufficient.
-- 3. Use fixed-precision currency types and explicit rounding policies.
-- 4. Never alter payroll records while gathering defect evidence.
