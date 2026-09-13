# SQL Interview Preparation for QA / SDET Roles

## Overview

Interview material focused on how QA Engineers use SQL to investigate defects and validate systems. Questions emphasize reasoning, data integrity, and practical testing scenarios.

## Concepts Covered

- Conceptual SQL questions
- Query challenges
- QA-oriented database testing questions
- Debugging and reconciliation patterns

## Learning Objectives

- Explain SQL choices clearly in interview settings
- Write readable validation queries under time pressure
- Identify edge cases and data-integrity risks
- Discuss dialect/performance considerations without over-engineering

## Example Queries

```sql
SELECT employee_id, COUNT(*) AS current_salary_rows
FROM salaries
WHERE is_current = 1
GROUP BY employee_id
HAVING COUNT(*) > 1;
```

## Best Practices

- Explain assumptions before writing the query.
- Prefer correctness and readability over cleverness.
- State expected cardinality and pass/fail behavior.
- Mention indexes or execution plans only after the logical query is correct.
