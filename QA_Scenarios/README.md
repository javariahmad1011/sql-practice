# Real-World QA Database Scenarios

## Overview

Scenario-driven SQL used to validate application modules after manual, API, or automation test execution. Tables such as users, login_events, payroll_runs, and leave_requests represent realistic application schemas beyond the sample database.

## Concepts Covered

- Login persistence and account state
- Employee CRUD
- Payroll reconciliation
- Leave workflow rules
- Dashboard metric validation

## Learning Objectives

- Connect frontend actions to backend state
- Build SQL evidence for end-to-end testing
- Validate workflow transitions
- Reconcile summary UI against source data
- Design post-condition checks for automation

## Example Queries

```sql
SELECT COUNT(*) AS ui_expected_count
FROM employees
WHERE status = 'Active';
```

## Best Practices

- Capture test identifiers in automated runs so SQL can target exact records.
- Prefer read-only validation queries in shared environments.
- Validate both positive state changes and forbidden side effects.
- Compare data from the same transaction/reporting window.
