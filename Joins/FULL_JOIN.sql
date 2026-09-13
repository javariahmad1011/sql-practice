-- FULL OUTER JOIN - Reconcile Two Data Sets
-- Purpose: Reconcile configured customer records against orders and surface customers without orders plus orphan order references.
-- Dialect note: PostgreSQL and SQL Server support FULL OUTER JOIN; MySQL requires an emulation pattern.
-- -----------------------------------------------------------------------------

-- PostgreSQL / SQL Server
SELECT c.customer_id AS customer_record,
       o.customer_id AS order_reference,
       c.customer_name,
       o.order_id
FROM customers c
FULL OUTER JOIN orders o
             ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL
   OR o.order_id IS NULL
ORDER BY COALESCE(c.customer_id, o.customer_id);

-- Expected Output / Validation Evidence
-- customer_record | order_reference | customer_name | order_id
-- 2005            | NULL            | No Orders Ltd | NULL
-- NULL            | 2999            | NULL          | 9015
-- Rows show unmatched data on either side.

-- Best Practices
-- 1. FULL OUTER JOIN is excellent for reconciliation because it preserves unmatched rows from both sets.
-- 2. MySQL does not support FULL OUTER JOIN natively; emulate with LEFT JOIN + RIGHT JOIN/UNION when needed.
-- 3. Reconciliation queries should clearly identify which side is missing.
