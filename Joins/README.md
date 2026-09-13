# Joins for Cross-Table QA Validation

## Overview

Cross-table reconciliation is central to database testing. These examples validate relationships between employees, departments, customers, orders, and salary history.

## Concepts Covered

- INNER JOIN
- LEFT JOIN
- RIGHT JOIN
- FULL OUTER JOIN
- SELF JOIN

## Learning Objectives

- Verify related data persisted across normalized tables
- Find missing child/parent relationships
- Identify records present on only one side of a relationship
- Compare rows within the same table
- Avoid false matches caused by incomplete join conditions

## Example Queries

```sql
SELECT e.employee_id, e.first_name, d.department_name
FROM employees e
JOIN departments d ON d.department_id = e.department_id
WHERE e.status = 'Active';
```

## Best Practices

- Join on keys, not display names.
- Confirm cardinality before interpreting row counts.
- Keep filters on the intended side of an outer join.
- When a join multiplies rows unexpectedly, investigate one-to-many relationships before adding DISTINCT.
