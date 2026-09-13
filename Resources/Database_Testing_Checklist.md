# Database Testing Checklist

Use this checklist when validating application features that persist or transform data.

## Before Testing

- Identify the tables/views affected by the feature.
- Confirm the primary key and business key used to trace the test record.
- Confirm environment, tenant, and database/schema.
- Review mandatory, optional, default, and generated fields.
- Understand status values and legal state transitions.
- Identify related tables, audit/history records, and downstream jobs.
- Confirm whether delete behavior is hard delete, soft delete, or archive.
- Confirm time zone and reporting/replication delay where relevant.

## Create Validation

- Exactly one expected row is inserted.
- Input values are persisted correctly.
- Default/generated values are correct.
- Data types and precision are preserved.
- Related child/audit rows are created when required.
- No duplicate business key is created.
- Invalid input is not persisted.

## Update Validation

- Target row changes to the expected values.
- Unchanged fields remain unchanged.
- Update timestamp/version is correct if used.
- Audit/history row is created when required.
- No duplicate current/history rows are created.
- Concurrent update behavior matches the design.

## Delete / Deactivate Validation

- Record is physically removed only when hard delete is required.
- Soft-delete/status flag is correct when retention is required.
- Child rows follow the correct restrict/cascade/archive behavior.
- Historical/audit records remain available when required.
- Deleted/inactive data is excluded from normal UI/API queries.

## Data Integrity

- Mandatory columns do not contain NULL/blank values.
- Unique business keys are unique.
- Foreign-key relationships have no orphans.
- Controlled fields contain approved domain values only.
- Monetary values use expected precision and scale.
- Dates and timestamps follow valid ranges and time zones.
- One-current-row rules are enforced for history tables.

## Reconciliation

- UI count equals backend count using identical filters.
- UI monetary total equals backend aggregate.
- API response fields equal persisted fields.
- Batch output count equals source eligibility count.
- Dashboard/report data uses the expected snapshot/refresh window.
- Migration/import source and target counts reconcile.

## Negative / Edge Cases

- Duplicate submission does not create unintended duplicate records.
- Boundary values are handled at min/max limits.
- Empty string vs NULL behavior is correct.
- Case sensitivity matches business rules.
- Invalid references are rejected.
- Invalid status transitions are rejected.
- Overlapping dates/ranges are handled correctly.
- Large values and precision boundaries are tested.

## Defect Evidence

Include:

- environment and database/schema;
- test user or synthetic record identifier;
- SQL query used;
- expected result and actual result;
- execution timestamp;
- relevant UI/API screenshot or payload;
- transaction/request/correlation ID where available;
- impact and reproducible steps.

## Automation Readiness

A database check is a strong automation candidate when:

- the query is read-only;
- test data can be identified deterministically;
- pass/fail semantics are explicit;
- timing/replication delay is controlled;
- the assertion does not depend on unrelated shared data;
- credentials are stored securely outside source control.
