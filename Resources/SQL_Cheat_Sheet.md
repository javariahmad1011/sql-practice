# SQL Cheat Sheet for QA Engineers

A compact reference for day-to-day database validation. The emphasis is on test evidence and defect investigation.

## Retrieve a Specific Test Record

```sql
SELECT employee_id, email, status
FROM employees
WHERE email = 'automation.employee@example.com';
```

**Expected cardinality:** usually exactly one row when email is a unique business key.

## Find Missing Mandatory Data

```sql
SELECT employee_id, email, department_id
FROM employees
WHERE status = 'Active'
  AND (email IS NULL OR department_id IS NULL);
```

**Pass condition:** zero rows.

## Find Duplicates

```sql
SELECT LOWER(email) AS normalized_email,
       COUNT(*) AS duplicate_count
FROM customers
GROUP BY LOWER(email)
HAVING COUNT(*) > 1;
```

## Find Orphaned Child Records

```sql
SELECT o.order_id, o.customer_id
FROM orders o
LEFT JOIN customers c ON c.customer_id = o.customer_id
WHERE c.customer_id IS NULL;
```

**Pass condition:** zero rows.

## Find Latest Row Per Entity

```sql
WITH ranked AS (
    SELECT s.*,
           ROW_NUMBER() OVER (
               PARTITION BY employee_id
               ORDER BY effective_from DESC, salary_id DESC
           ) AS rn
    FROM salaries s
)
SELECT employee_id, amount, effective_from
FROM ranked
WHERE rn = 1;
```

## Validate Aggregate UI Metrics

```sql
SELECT COUNT(*) AS active_employee_count
FROM employees
WHERE status = 'Active';
```

Match the UI's tenant, status, date, permissions, and refresh rules before comparing.

## Date Range Pattern

Prefer half-open ranges for timestamps:

```sql
WHERE created_at >= '2026-08-01 00:00:00'
  AND created_at <  '2026-09-01 00:00:00'
```

This avoids missing high-precision values at the end of the final day.

## NULL Rules

```sql
column IS NULL
column IS NOT NULL
```

Never use `column = NULL`.

## Useful Interview Patterns

```sql
-- Nth/later record: window functions
ROW_NUMBER() OVER (PARTITION BY ... ORDER BY ...)

-- Only need proof a child exists
EXISTS (SELECT 1 FROM child WHERE ...)

-- Need rows with no child
NOT EXISTS (SELECT 1 FROM child WHERE ...)

-- Need duplicate groups
GROUP BY ... HAVING COUNT(*) > 1
```

## Cross-Dialect Notes

| Need | PostgreSQL | MySQL | SQL Server |
|---|---|---|---|
| First N rows | `LIMIT 10` | `LIMIT 10` | `TOP (10)` / `OFFSET FETCH` |
| Boolean | `BOOLEAN` | `BOOLEAN` alias / numeric | `BIT` |
| Full outer join | Supported | Emulate | Supported |
| Case-insensitive match | `ILIKE` | collation-dependent | collation-dependent |

## QA Principle

A good validation query should make it obvious:

- what business rule is being checked;
- what data identifies the test record;
- what result means **pass**;
- what returned rows mean **failure**;
- whether timing, tenant, or environment filters are required.
