# Common QA SQL Queries

Reusable query patterns for manual testing, automation support, regression validation, and defect investigation.

## Verify a Created Record

```sql
SELECT customer_id, customer_name, email, account_status
FROM customers
WHERE email = 'unique-test-user@example.com';
```

Expected: exactly one row with values matching the create request.

## Verify an Update

```sql
SELECT employee_id, department_id, status
FROM employees
WHERE employee_id = 1010
  AND department_id = 20
  AND status = 'Active';
```

Expected: exactly one row.

## Verify a Soft Delete / Deactivation

```sql
SELECT employee_id, status
FROM employees
WHERE employee_id = 1010;
```

Expected: row remains but uses the required inactive/deleted state.

## Detect Duplicate Business Keys

```sql
SELECT LOWER(email) AS normalized_email, COUNT(*)
FROM customers
GROUP BY LOWER(email)
HAVING COUNT(*) > 1;
```

Expected: zero rows when email uniqueness is required.

## Detect Orphans

```sql
SELECT s.salary_id, s.employee_id
FROM salaries s
LEFT JOIN employees e ON e.employee_id = s.employee_id
WHERE e.employee_id IS NULL;
```

Expected: zero rows.

## Validate One Current History Row

```sql
SELECT employee_id, COUNT(*) AS current_rows
FROM salaries
WHERE is_current = 1
GROUP BY employee_id
HAVING COUNT(*) > 1;
```

Expected: zero rows.

## Reconcile API/UI Count

```sql
SELECT COUNT(*) AS expected_count
FROM orders
WHERE status IN ('Pending', 'Processing');
```

Use the same tenant, permissions, date window, and status mapping as the API/UI.

## Find Recent Test Activity

```sql
SELECT order_id, customer_id, order_date, status, total_amount
FROM orders
ORDER BY order_date DESC, order_id DESC
LIMIT 20;
```

SQL Server: use `TOP (20)` or `OFFSET/FETCH`.

## Compare Historical Values

```sql
SELECT employee_id,
       effective_from,
       amount,
       LAG(amount) OVER (
           PARTITION BY employee_id
           ORDER BY effective_from, salary_id
       ) AS previous_amount
FROM salaries;
```

Useful for checking increments, state transitions, or audit-history changes.

## Safe QA Usage

- Prefer `SELECT` validation in shared environments.
- If test setup requires writes, use approved test databases and transactions.
- Never run unreviewed `UPDATE` or `DELETE` statements against production.
- Use synthetic identifiers so automated test data is easy to trace and clean up.
- Capture query text, parameters, database/environment, timestamp, and result evidence with defects.
