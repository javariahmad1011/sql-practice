-- COUNT - Reconcile Dashboard Counts
-- Purpose: Calculate the number of active employees expected on an employee summary card.
-- -----------------------------------------------------------------------------

SELECT COUNT(*) AS active_employee_count
FROM employees
WHERE status = 'Active';

-- Expected Output / Validation Evidence
-- active_employee_count
-- 3
-- Compare this value with the UI/API dashboard metric.

-- Best Practices
-- 1. Match the UI/API filtering rules exactly before comparing counts.
-- 2. COUNT(*) counts rows; COUNT(column) excludes NULL values.
-- 3. Record the query and test-data state with defect evidence when counts differ.
