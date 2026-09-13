-- Sample Database - Customers Table
-- Purpose: Create and seed customer/account data used in duplicate, filtering, join, and dashboard validations.
-- -----------------------------------------------------------------------------

CREATE TABLE customers (
    customer_id   INTEGER PRIMARY KEY,
    customer_name VARCHAR(120) NOT NULL,
    email         VARCHAR(150) NOT NULL,
    account_status VARCHAR(20) NOT NULL,
    created_date  DATE         NOT NULL,
    CONSTRAINT uq_customers_email UNIQUE (email)
);

INSERT INTO customers
    (customer_id, customer_name, email, account_status, created_date)
VALUES
    (2001, 'Northwind QA',     'northwind@example.com',     'Active',   '2025-05-10'),
    (2002, 'Acme Test Labs',   'acme@example.com',          'Active',   '2025-07-18'),
    (2003, 'Regression Co',    'regression@example.com',    'Active',   '2026-01-05'),
    (2004, 'Boundary Systems', 'boundary@example.com',      'Active',   '2026-02-12'),
    (2005, 'No Orders Ltd',    'noorders@example.com',      'Inactive', '2026-03-03'),
    (2010, 'Regression User',  'regression+qa@example.com', 'Active',   '2026-06-01');

-- Expected Output / Validation Evidence
-- Validation query:
-- SELECT COUNT(*) AS active_customers FROM customers WHERE account_status = 'Active';
-- active_customers
-- 5

-- Best Practices
-- 1. Email uniqueness is enforced in the sample schema; real systems may use normalized/case-insensitive uniqueness.
-- 2. Seed data should include states needed for positive and negative tests.
-- 3. Keep synthetic test data free of real personal information.
