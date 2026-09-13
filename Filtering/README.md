# Filtering for Test Data and Edge Cases

## Overview

Filtering queries model the conditions QA Engineers use to isolate boundary values, invalid combinations, pattern mismatches, optional data, and targeted regression records.

## Concepts Covered

- Boolean logic with AND/OR
- Inclusive range validation
- Controlled set membership
- Pattern matching
- NULL semantics

## Learning Objectives

- Translate acceptance criteria into precise predicates
- Validate boundary conditions
- Detect records outside approved enumerations
- Find malformed or suspicious text values
- Differentiate NULL from empty strings

## Example Queries

```sql
SELECT employee_id, email, status
FROM employees
WHERE status IN ('Active', 'On Leave')
  AND email LIKE '%@%';
```

## Best Practices

- Use parentheses whenever AND/OR precedence could be misread.
- Test both inclusive boundaries when using BETWEEN.
- Use IN for small approved enumerations.
- Handle NULL explicitly with IS NULL / IS NOT NULL, never = NULL.
