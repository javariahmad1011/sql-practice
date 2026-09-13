-- Sample Database - Salary History Table
-- Purpose: Create and seed salary history records for aggregate, subquery, window, and payroll validations.
-- -----------------------------------------------------------------------------

CREATE TABLE salaries (
    salary_id      INTEGER PRIMARY KEY,
    employee_id    INTEGER       NOT NULL,
    amount         DECIMAL(12,2) NOT NULL,
    effective_from DATE          NOT NULL,
    is_current     INTEGER       NOT NULL,
    CONSTRAINT fk_salaries_employee
        FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

INSERT INTO salaries
    (salary_id, employee_id, amount, effective_from, is_current)
VALUES
    (4881, 1001, 59000.00, '2025-04-01', 0),
    (5012, 1001, 62000.00, '2026-04-01', 1),
    (5013, 1002, 68000.00, '2026-04-01', 1),
    (5014, 1003, 64000.00, '2026-04-01', 1),
    (5015, 1004, 78000.00, '2026-04-01', 1),
    (4700, 1005, 55000.00, '2024-04-01', 1);

-- Expected Output / Validation Evidence
-- Validation query:
-- SELECT employee_id, COUNT(*) FROM salaries WHERE is_current = 1 GROUP BY employee_id;
-- Each seeded employee has exactly one current row.

-- Best Practices
-- 1. Store currency in fixed precision DECIMAL/NUMERIC.
-- 2. Real schemas should enforce one current row per employee using an appropriate constraint/index strategy.
-- 3. History rows should be immutable or tightly audited in production systems.
