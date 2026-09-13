-- Dashboard - Source-to-UI Metric Reconciliation
-- Purpose: Calculate backend values that should match employee, customer, order, and revenue widgets.
-- -----------------------------------------------------------------------------

SELECT
    (SELECT COUNT(*)
     FROM employees
     WHERE status = 'Active') AS active_employees,

    (SELECT COUNT(*)
     FROM customers
     WHERE account_status = 'Active') AS active_customers,

    (SELECT COUNT(*)
     FROM orders
     WHERE status IN ('Pending', 'Processing')) AS open_orders,

    (SELECT COALESCE(SUM(total_amount), 0)
     FROM orders
     WHERE status = 'Completed'
       AND order_date >= '2026-08-01'
       AND order_date <  '2026-09-01') AS completed_revenue_august;

-- Expected Output / Validation Evidence
-- active_employees | active_customers | open_orders | completed_revenue_august
-- 3                | 5                | 3           | 1249.49
-- Each value should match the corresponding dashboard/API metric for the same snapshot.

-- Best Practices
-- 1. Confirm dashboard refresh latency and data-source timing before raising a mismatch defect.
-- 2. Match all UI filters, tenant filters, permissions, and time zones.
-- 3. Reconcile source components individually before validating a composite KPI.
-- 4. Record the execution timestamp with screenshot/query evidence.
