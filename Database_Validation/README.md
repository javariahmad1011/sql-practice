# Database Validation Checks

## Overview

Production-style SQL assertions for verifying data integrity after application workflows. Most negative checks are intentionally written so **zero rows = pass**.

## Concepts Covered

- User/account integrity
- Employee master-data validation
- Salary rule validation
- Duplicate detection
- NULL checks
- Referential integrity

## Learning Objectives

- Design SQL as a test oracle
- Detect invalid persisted states after UI/API actions
- Produce defect-ready evidence
- Validate relational constraints beyond the frontend
- Build checks suitable for manual or automated execution

## Example Queries

```sql
SELECT e.employee_id
FROM employees e
LEFT JOIN departments d ON d.department_id = e.department_id
WHERE e.department_id IS NOT NULL
  AND d.department_id IS NULL;
```

## Best Practices

- State the pass condition in every validation file.
- Prefer validations that return only failing rows.
- Run checks against a controlled test-data snapshot.
- Never repair data manually before capturing evidence for the defect.
