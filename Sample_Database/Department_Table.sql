-- Sample Database - Departments Table
-- Purpose: Create and seed department reference data for join and referential-integrity exercises.
-- -----------------------------------------------------------------------------

CREATE TABLE departments (
    department_id   INTEGER PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL,
    department_code VARCHAR(20)  NOT NULL,
    is_active       INTEGER      NOT NULL,
    CONSTRAINT uq_departments_code UNIQUE (department_code)
);

INSERT INTO departments
    (department_id, department_name, department_code, is_active)
VALUES
    (10, 'Quality Engineering', 'QA',  1),
    (20, 'Engineering',         'ENG', 1),
    (30, 'Data & Analytics',    'DATA',1),
    (40, 'Security',            'SEC', 1);

-- Expected Output / Validation Evidence
-- Validation query:
-- SELECT department_id, department_code FROM departments ORDER BY department_id;
-- 10 | QA
-- 20 | ENG
-- 30 | DATA
-- 40 | SEC

-- Best Practices
-- 1. Reference codes should be stable and unique.
-- 2. INTEGER 0/1 is used here for broad portability; native BOOLEAN/BIT may be preferable per platform.
-- 3. Avoid deleting referenced lookup rows without validating downstream impact.
