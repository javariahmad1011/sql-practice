# Subqueries for Rule-Based Validation

## Overview

Subqueries express validations where a row must be compared with an aggregate, related existence condition, or dependent lookup.

## Concepts Covered

- Scalar subqueries
- Correlated subqueries
- EXISTS
- NOT EXISTS

## Learning Objectives

- Compare a value against a single derived benchmark
- Evaluate row-specific related data
- Test existence without unnecessary row multiplication
- Find missing related data efficiently

## Example Queries

```sql
SELECT e.employee_id, e.first_name, e.last_name
FROM employees e
WHERE EXISTS (
    SELECT 1
    FROM salaries s
    WHERE s.employee_id = e.employee_id
      AND s.is_current = 1
);
```

## Best Practices

- Ensure scalar subqueries truly return one row.
- Prefer EXISTS when only existence matters.
- Correlated subqueries should use indexed relationship keys on large datasets.
- Keep zero-row failure queries explicit and easy to automate.
