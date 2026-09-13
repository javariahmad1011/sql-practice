# SQL Interview Questions for QA Engineers

These questions are framed for QA, SDET, automation, and database-testing interviews rather than generic SQL trivia.

## Core SQL Reasoning

1. **What is the difference between `WHERE` and `HAVING`?**  
   `WHERE` filters rows before grouping; `HAVING` filters groups after aggregation. In QA work, use `HAVING COUNT(*) > 1` to detect duplicate business keys.

2. **Why can `SELECT *` be a poor choice in test automation?**  
   It couples assertions to unrelated schema changes, returns unnecessary data, can expose sensitive fields, and makes evidence harder to read. Select only the fields used by the test oracle.

3. **What is the difference between `COUNT(*)` and `COUNT(column)`?**  
   `COUNT(*)` counts rows; `COUNT(column)` counts non-NULL values in that column. This difference matters when validating optional or mandatory fields.

4. **Why is `= NULL` incorrect?**  
   SQL uses three-valued logic. Use `IS NULL` or `IS NOT NULL` for nullability checks.

5. **When would a QA Engineer use `EXISTS` instead of a JOIN?**  
   When the test only needs to prove related data exists and does not need child columns. `EXISTS` avoids accidental row multiplication.

6. **What can cause an INNER JOIN to return fewer rows than expected?**  
   Missing parent/child relationships, incorrect join keys, filters that exclude rows, data-type mismatches, or dirty data. Compare source counts and run an outer-join orphan check.

7. **What can cause a JOIN to return more rows than expected?**  
   One-to-many relationships, incomplete join predicates, duplicate keys, or joining on non-unique display fields.

8. **Why is a deterministic `ORDER BY` important in automated tests?**  
   Without explicit ordering, row order is not guaranteed. Add tie-break fields when values can be equal.

9. **What is the difference between `RANK`, `DENSE_RANK`, and `ROW_NUMBER`?**  
   `ROW_NUMBER` gives unique sequential numbers, `RANK` gives ties the same rank and leaves gaps, and `DENSE_RANK` gives ties the same rank without gaps.

10. **How do you find duplicates safely?**  
    Define the business key first, normalize only according to business rules, then `GROUP BY` that key and use `HAVING COUNT(*) > 1`. Do not delete anything until the duplicate meaning is confirmed.

## Database Testing Questions

11. **How would you validate that a user created through the UI is saved correctly?**  
    Capture a unique test identifier (email/UUID), query the relevant table by that identifier, assert exactly one row, and verify persisted fields/status/defaults. Then check any required related records or audit events.

12. **How would you verify a delete feature?**  
    First determine whether the requirement is hard delete, soft delete, or archive. Validate the expected row state and check that referential integrity/history behavior matches the deletion contract.

13. **How do you validate a dashboard count?**  
    Recreate the backend population with exactly the same filters, permissions, status definitions, time zone, and reporting window; then compare the aggregate result with the UI/API value.

14. **How do you test referential integrity if foreign keys are disabled?**  
    Use a `LEFT JOIN` from child to parent and filter for missing parent keys. Zero rows should represent pass.

15. **How would you detect multiple 'current' rows in a history table?**  
    Filter `is_current = 1`, group by the owning entity, and use `HAVING COUNT(*) > 1`.

16. **How can SQL support API testing?**  
    Use the API response identifier to query the database and validate persisted fields, status transitions, generated related rows, audit records, and forbidden side effects.

17. **What should you avoid querying in security-sensitive systems?**  
    Plaintext passwords should never exist. Avoid retrieving password hashes, tokens, secrets, full payment details, or unnecessary PII unless the approved test explicitly requires it.

18. **What does 'zero rows = pass' mean?**  
    A negative validation query is written to return only violations. If no rows are returned, the tested integrity rule currently has no failures.

## Scenario Questions

19. An employee is active but does not appear in payroll. What SQL checks would you perform?  
    Verify employee status, current salary existence, payroll eligibility data, payroll batch scope, generated payroll item, and exclusion rules such as unpaid leave or termination date.

20. A customer sees duplicate orders after double-clicking Submit. How would you investigate?  
    Query orders by customer, creation time, amount, idempotency/request key, and status. Check whether two rows were inserted and whether downstream payment/audit records were duplicated.

21. The UI shows 102 active users but SQL returns 105. What do you check before reporting a bug?  
    Tenant scope, soft-deleted users, role/permission filters, stale cache/reporting lag, status mapping, time zone, and whether the UI excludes service/system accounts.

22. A test passes locally but fails against SQL Server. What might be different?  
    Pagination syntax, boolean representation, identifier quoting, date functions, string concatenation, collation/case sensitivity, `FULL OUTER JOIN` availability, and transaction/isolation behavior.

## Interview Answering Pattern

A strong QA-focused answer usually covers:

- the **business rule** being validated;
- the **record identifier** used to isolate test data;
- the **expected row count/state**;
- the **negative side effects** that must not occur;
- any **dialect, concurrency, or data-timing assumptions**;
- what evidence would be attached to a defect.
