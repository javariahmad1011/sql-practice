# sql-practice

SQL practice repository for QA Engineers including database validation, joins, interview questions, queries, and real-world testing scenarios.

Overview

This repository is structured as a QA Engineer's SQL working notebook rather than a beginner tutorial. It focuses on the SQL patterns commonly used during application testing, defect investigation, backend validation, regression testing, test data verification, API/database reconciliation, and SQA interviews.

The examples intentionally use test-oriented questions such as:

Was the UI action persisted correctly in the database?

Are duplicate business records being created?

Do foreign keys point to valid parent records?

Does payroll data reconcile with employee status and salary history?

Are inactive users still able to generate login activity?

Do dashboard totals match the underlying transactional data?

Can a query identify missing, inconsistent, or suspicious records quickly?

Concepts Covered

Data retrieval and controlled filtering

Multi-table reconciliation with joins

Aggregation and dashboard validation

Subqueries and existence checks

Window functions for duplicate/history analysis

Data-integrity and referential-integrity assertions

Module-level QA database validation

SQL interview problem solving for QA/SDET roles

Learning Objectives

Translate acceptance criteria and business rules into SQL assertions.

Validate UI/API actions against persisted backend state.

Investigate defects using deterministic, evidence-friendly queries.

Reconcile counts and monetary totals across application layers.

Detect duplicates, NULL violations, orphan rows, and invalid history states.

Explain SQL reasoning clearly in QA Engineer and SDET interviews.

Example Queries

-- PASS condition: zero rows.
SELECT e.employee_id, e.email
FROM employees e
WHERE e.status = 'Active'
  AND NOT EXISTS (
      SELECT 1
      FROM salaries s
      WHERE s.employee_id = e.employee_id
        AND s.is_current = 1
  );

Best Practices

Write validations so the expected row count or pass condition is explicit.

Select only columns needed for the assertion or defect evidence.

Use stable test identifiers rather than relying on display order or names.

Match tenant, status, time-zone, and date-window filters before reconciling UI/API totals.

Keep shared-environment validation read-only unless test setup explicitly requires writes.

Document SQL dialect differences instead of hiding platform-specific behavior.

Folder Structure

sql-practice/
├── README.md
├── Basics/
├── Filtering/
├── Joins/
├── Aggregate_Functions/
├── Subqueries/
├── Window_Functions/
├── Database_Validation/
├── QA_Scenarios/
├── Interview_Questions/
├── Sample_Database/
└── Resources/

SQL Topics Covered

Area

Practical QA Use

SELECT / WHERE / ORDER BY

Inspect persisted application data and isolate test records

DISTINCT / LIMIT

Detect unexpected values and safely sample large tables

Filtering

Validate boundary values, optional fields, patterns, and status rules

Joins

Reconcile data across UI/API/database entities

Aggregations

Validate totals, counts, averages, and summary widgets

Subqueries

Express validation rules that depend on related datasets

Window Functions

Detect duplicates, rank history, compare current vs previous values

Database Validation

Check integrity, nullability, duplicates, salary rules, and orphan data

QA Scenarios

Validate login, employee, payroll, leave, and dashboard workflows

Interview Challenges

Practice production-style SQL questions used in QA/SDET interviews

Database Testing

The Database_Validation and QA_Scenarios folders contain queries designed to produce test evidence rather than simply retrieve data. Many validations are written so that zero rows means pass, which makes them useful in manual testing, CI checks, and automation assertions.

Typical database testing covered here includes:

CRUD persistence verification

Data type and business-rule validation

Duplicate detection

Mandatory-field / NULL validation

Referential integrity checks

Cross-table reconciliation

Status transition validation

Historical data validation

Aggregate and dashboard reconciliation

Negative-data checks

QA Validation Examples

-- PASS condition: query returns zero rows.
-- Find active employees without an active salary record.
SELECT e.employee_id,
       e.first_name,
       e.last_name
FROM employees e
LEFT JOIN salaries s
       ON s.employee_id = e.employee_id
      AND s.is_current = 1
WHERE e.status = 'Active'
  AND s.employee_id IS NULL;

-- Reconcile dashboard employee count with the source table.
SELECT COUNT(*) AS active_employee_count
FROM employees
WHERE status = 'Active';

-- Detect duplicate customer emails that could break login or account recovery.
SELECT LOWER(email) AS normalized_email,
       COUNT(*) AS duplicate_count
FROM customers
GROUP BY LOWER(email)
HAVING COUNT(*) > 1;

Skills Demonstrated

SQL-based backend validation for QA

Relational database reasoning

Data reconciliation and defect investigation

Test-oracle design using pass/fail queries

Query readability and maintainability

Edge-case and negative-data validation

Interview-ready SQL problem solving

Ability to translate business rules into database checks

Awareness of SQL dialect differences across major RDBMS platforms

Tools / Database Platforms

The query patterns are applicable to:

PostgreSQL

MySQL 8+

Microsoft SQL Server

Most files use portable SQL where practical. Where syntax differs, comments call out the relevant dialect difference, for example LIMIT, TOP, FETCH FIRST, or MySQL's lack of native FULL OUTER JOIN.

Recommended tools for running the scripts include DBeaver, DataGrip, pgAdmin, MySQL Workbench, Azure Data Studio, or SQL Server Management Studio.

How to Run Queries

Create a test database in the RDBMS of your choice.

Run the sample schema in dependency order: Department_Table.sql → Employee_Table.sql → Salary_Table.sql, then Customers_Table.sql → Orders_Table.sql.

Execute topic queries from the relevant folder.

For validation scripts, read the Expected Output / Validation Evidence comments before execution.

Treat queries documented as zero rows = pass as assertions; any returned row is a candidate defect or data-quality issue.

Adapt date/time, pagination, boolean, and identity syntax to the target database where necessary.



Future Improvements

Add automated database assertions using Python + pytest

Add Playwright/API-to-database reconciliation examples

Add Docker Compose for PostgreSQL and MySQL test environments

Add stored procedure and transaction testing scenarios

Add query performance validation with execution plans and indexes

Add CI workflow to execute validation SQL against seeded test data

Add data migration and ETL reconciliation examples
