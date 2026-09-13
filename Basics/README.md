# SQL Basics for QA Validation

## Overview

Core retrieval operations used by QA Engineers to inspect test data safely and consistently. The focus is controlled evidence gathering, not syntax memorization.

## Concepts Covered

- Column-level data inspection
- Predicate-driven test record retrieval
- Deterministic sorting
- Domain-value discovery
- Safe result-set sampling

## Learning Objectives

- Retrieve only fields needed for a test assertion
- Find a specific test record without scanning unrelated data
- Order evidence consistently for comparison
- Discover unexpected status/category values
- Avoid accidental high-volume result sets

## Example Queries

```sql
SELECT employee_id, first_name, last_name, status
FROM employees
WHERE status = 'Active'
ORDER BY employee_id;
```

## Best Practices

- Never use SELECT * in reusable validation queries unless the full row is genuinely required.
- Always filter by stable test identifiers when validating a specific UI or API action.
- Use deterministic ORDER BY when comparing query evidence between runs.
- Limit exploratory queries on large production-like datasets.
