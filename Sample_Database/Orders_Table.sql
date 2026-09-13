-- Sample Database - Orders Table
-- Purpose: Create and seed transactional order data for joins, aggregations, boundary checks, and dashboard reconciliation.
-- -----------------------------------------------------------------------------

CREATE TABLE orders (
    order_id     INTEGER PRIMARY KEY,
    customer_id  INTEGER       NOT NULL,
    order_date   DATE          NOT NULL,
    status       VARCHAR(20)   NOT NULL,
    total_amount DECIMAL(12,2) NOT NULL,
    CONSTRAINT fk_orders_customer
        FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO orders
    (order_id, customer_id, order_date, status, total_amount)
VALUES
    (9001, 2001, '2026-08-02', 'Completed', 149.50),
    (9002, 2002, '2026-08-04', 'Completed', 100.00),
    (9003, 2003, '2026-08-07', 'Cancelled',  89.00),
    (9004, 2004, '2026-08-09', 'Completed', 250.00),
    (9005, 2003, '2026-08-12', 'Processing',320.00),
    (9006, 2001, '2026-08-14', 'Pending',   500.00),
    (9007, 2002, '2026-08-15', 'Completed', 749.99),
    (9008, 2004, '2026-08-15', 'Pending',   210.00);

-- Expected Output / Validation Evidence
-- Validation query:
-- SELECT status, COUNT(*) FROM orders GROUP BY status ORDER BY status;
-- Cancelled | 1
-- Completed | 4
-- Pending   | 2
-- Processing| 1

-- Best Practices
-- 1. Keep transactional IDs deterministic in seed data for repeatable tests.
-- 2. Add timestamps/idempotency keys in real systems when duplicate submission testing is important.
-- 3. Currency values should use DECIMAL/NUMERIC and explicit rounding rules.
