# Window Functions for History and Duplicate Analysis

## Overview

Window functions preserve row detail while adding rankings, comparisons, and partition-level calculations useful for QA investigations.

## Concepts Covered

- ROW_NUMBER
- RANK
- DENSE_RANK
- LEAD/LAG

## Learning Objectives

- Select one canonical row from duplicate candidates
- Rank values while preserving ties
- Understand dense vs skipped ranking
- Compare sequential history records without self-joins

## Example Queries

```sql
SELECT employee_id, amount,
       LAG(amount) OVER (PARTITION BY employee_id ORDER BY effective_from) AS previous_amount
FROM salaries;
```

## Best Practices

- Define deterministic ORDER BY clauses inside windows.
- Partition by the correct business key.
- Do not confuse RANK and DENSE_RANK when ties matter.
- Use window functions for analysis; add explicit filters in an outer query for pass/fail validations.
