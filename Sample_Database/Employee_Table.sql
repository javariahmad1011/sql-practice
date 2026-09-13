-- Sample Database - Employees Table
-- Purpose: Create and seed employee master data used throughout the repository. IDs are explicit for cross-database portability.
-- -----------------------------------------------------------------------------

CREATE TABLE employees (
    employee_id   INTEGER PRIMARY KEY,
    first_name    VARCHAR(50)  NOT NULL,
    last_name     VARCHAR(50)  NOT NULL,
    email         VARCHAR(150) NOT NULL,
    status        VARCHAR(20)  NOT NULL,
    hire_date     DATE         NOT NULL,
    department_id INTEGER      NULL,
    manager_id    INTEGER      NULL,
    CONSTRAINT uq_employees_email UNIQUE (email),
    CONSTRAINT fk_employees_department
        FOREIGN KEY (department_id) REFERENCES departments(department_id),
    CONSTRAINT fk_employees_manager
        FOREIGN KEY (manager_id) REFERENCES employees(employee_id)
);

INSERT INTO employees
    (employee_id, first_name, last_name, email, status, hire_date, department_id, manager_id)
VALUES
    (1001, 'Aisha',  'Khan',   'aisha.khan@example.com',   'Active',   '2022-03-14', 10, NULL),
    (1002, 'Daniel', 'Reed',   'daniel.reed@example.com',  'Active',   '2023-07-01', 20, 1001),
    (1003, 'Sofia',  'Martin', 'sofia.martin@example.com', 'On Leave', '2024-01-22', 20, 1002),
    (1004, 'Marcus', 'Lee',    'marcus.lee@example.com',   'Active',   '2021-10-11', 30, 1001),
    (1005, 'Priya',  'Shah',   'priya.shah@example.com',   'Inactive', '2020-05-18', 10, 1001);

-- Expected Output / Validation Evidence
-- Validation query:
-- SELECT COUNT(*) AS employee_rows FROM employees;
-- employee_rows
-- 5

-- Best Practices
-- 1. Explicit IDs keep seed data predictable across PostgreSQL, MySQL, and SQL Server.
-- 2. Create departments before employees so the department foreign key can be enforced.
-- 3. Production schemas should enforce approved status values using constraints/reference tables when appropriate.
